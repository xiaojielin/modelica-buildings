within Buildings.Fluid.Air.BaseClasses;
partial model PartialAirHandlingUnit "Partial AHU model "
  extends Buildings.Fluid.Air.BaseClasses.PartialAirHandlingUnitInterface;
  extends Buildings.Fluid.Actuators.BaseClasses.ValveParameters(
    final m_flow_nominal=m1_flow_nominal,
    dpValve_nominal=dat.nomVal.dpValve_nominal,
    final rhoStd=Medium1.density_pTX(101325, 273.15+4, Medium1.X_default),
    final deltaM = deltaM2);
  extends Buildings.Fluid.Interfaces.FourPortFlowResistanceParameters(
    final computeFlowResistance1=true,
    final computeFlowResistance2=true,
    final dp1_nominal = dat.nomVal.dpCoil1_nominal,
    final dp2_nominal = dat.nomVal.dpCoil2_nominal +
      dat.nomVal.dpHumidifier_nominal+dat.nomVal.dpHeater_nominal);

  // Cooling coil
  parameter Boolean waterSideFlowDependent=true
    "Set to false to make water-side hA independent of mass flow rate"
    annotation (Dialog(tab="Heat transfer",group="Cooling Coil"));
  parameter Boolean airSideFlowDependent=true
    "Set to false to make air-side hA independent of mass flow rate"
    annotation (Dialog(tab="Heat transfer",group="Cooling Coil"));
  parameter Boolean waterSideTemperatureDependent=false
    "Set to false to make water-side hA independent of temperature"
    annotation (Dialog(tab="Heat transfer",group="Cooling Coil"));
  parameter Boolean airSideTemperatureDependent=false
    "Set to false to make air-side hA independent of temperature"
    annotation (Dialog(tab="Heat transfer",group="Cooling Coil"));
   // Dynamics
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));
  parameter Modelica.Fluid.Types.Dynamics massDynamics=energyDynamics
    "Type of mass balance: dynamic (3 initialization options) or steady state"
    annotation(Evaluate=true, Dialog(tab = "Dynamics", group="Equations"));
  // Initialization of the fan
  parameter Medium2.AbsolutePressure p_start = Medium2.p_default
    "Start value of pressure"
    annotation(Dialog(tab = "Initialization"));
  parameter Medium2.Temperature T_start=Medium2.T_default
    "Start value of temperature"
    annotation(Dialog(tab = "Initialization"));
  parameter Medium2.MassFraction X_start[Medium2.nX](
       quantity=Medium2.substanceNames) = Medium2.X_default
    "Start value of mass fractions m_i/m"
    annotation (Dialog(tab="Initialization", enable=Medium2.nXi > 0));
  parameter Medium2.ExtraProperty C_start[Medium2.nC](
       quantity=Medium2.extraPropertiesNames)=fill(0, Medium2.nC)
    "Start value of trace substances"
    annotation (Dialog(tab="Initialization", enable=Medium2.nC > 0));
  parameter Medium2.ExtraProperty C_nominal[Medium2.nC](
       quantity=Medium2.extraPropertiesNames) = fill(1E-2, Medium2.nC)
    "Nominal value of trace substances. (Set to typical order of magnitude.)"
   annotation (Dialog(tab="Initialization", enable=Medium2.nC > 0));
  // valve parameters
  parameter Real l(min=1e-10, max=1) = 0.0001
    "Valve leakage, l=Kv(y=0)/Kv(y=1)"
    annotation(Dialog(group="Valve"));
  parameter Real kFixed(unit="", min=0) = m1_flow_nominal / sqrt(dp1_nominal)
    "Flow coefficient of fixed resistance that may be in series with valve, k=m_flow/sqrt(dp), with unit=(kg.m)^(1/2)."
    annotation(Dialog(group="Valve"));

  parameter Boolean homotopyInitialization = true "= true, use homotopy method"
    annotation(Evaluate=true, Dialog(tab="Advanced"));

  parameter Boolean use_inputFilterValve=true
    "= true, if opening is filtered with a 2nd order CriticalDamping filter"
    annotation(Dialog(tab="Dynamics", group="Valve"));
  parameter Modelica.SIunits.Time riseTimeValve=120
    "Rise time of the filter (time to reach 99.6 % of an opening step)"
    annotation(Dialog(tab="Dynamics", group="Valve",enable=use_inputFilterValve));
  parameter Modelica.Blocks.Types.Init initValve=Modelica.Blocks.Types.Init.InitialOutput
    "Type of initialization (no init/steady state/initial state/initial output)"
    annotation(Dialog(tab="Dynamics", group="Valve",enable=use_inputFilterValve));
  parameter Real yValve_start=1 "Initial value of output"
    annotation(Dialog(tab="Dynamics", group="Valve",enable=use_inputFilterValve));
  // fan parameters
   parameter Buildings.Fluid.Types.InputType inputType = Buildings.Fluid.Types.InputType.Continuous
    "Control input type"
    annotation(Dialog(group="Fan"));
  parameter Boolean addPowerToMedium=true
    "Set to false to avoid any power (=heat and flow work) being added to medium (may give simpler equations)"
    annotation(Dialog(group="Fan"));
  parameter Modelica.SIunits.Time tauFan = 30
    "Time constant at nominal flow (if energyDynamics <> SteadyState)"
     annotation (Dialog(tab = "Dynamics", group="Fan"));
  parameter Boolean use_inputFilterFan=true
    "= true, if speed is filtered with a 2nd order CriticalDamping filter"
    annotation(Dialog(tab="Dynamics", group="Fan"));
  parameter Modelica.SIunits.Time riseTimeFan=30
    "Rise time of the filter (time to reach 99.6 % of the speed)"
    annotation(Dialog(tab="Dynamics", group="Fan",enable=use_inputFilterFan));
  parameter Modelica.Blocks.Types.Init initFan=Modelica.Blocks.Types.Init.InitialOutput
    "Type of initialization (no init/steady state/initial state/initial output)"
    annotation(Dialog(tab="Dynamics", group="Fan",enable=use_inputFilterFan));
  parameter Real yFan_start(min=0, max=1, unit="1")=0 "Initial value of speed"
    annotation(Dialog(tab="Dynamics", group="Fan",enable=use_inputFilterFan));

  Modelica.Blocks.Interfaces.RealInput uWatVal(min=0,max=1,unit="1")
    "Actuator position (0: closed, 1: open) on water side"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}}),
      iconTransformation(extent={{-120,40},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput uFan if
   not inputType == Buildings.Fluid.Types.InputType.Stages
   "Continuous input signal for the fan"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}}),
      iconTransformation(extent={{-120,-40},{-100,-20}})));
  Modelica.Blocks.Interfaces.RealOutput PFan(quantity="Power",unit="W")
    "Electrical power consumed by the fan" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-20,-110})));
  Modelica.Blocks.Interfaces.RealOutput y_valve(min=0,max=1,unit="1")
    "Actual valve position"
    annotation (Placement(transformation(extent={{100,30},{120,50}}),
      iconTransformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.IntegerInput stage if
    inputType == Buildings.Fluid.Types.InputType.Stages
    "Stage input signal for the pressure head"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}}),
        iconTransformation(extent={{-120,-40},{-100,-20}})));

  Buildings.Fluid.HeatExchangers.WetCoilCounterFlow cooCoi(
    final UA_nominal=dat.nomVal.UA_nominal,
    final r_nominal=dat.nomVal.r_nominal,
    final nEle=dat.nomVal.nEle,
    final tau1=dat.nomVal.tau1,
    final tau2=dat.nomVal.tau2,
    final tau_m=dat.nomVal.tau_m,
    redeclare final package Medium1 = Medium1,
    redeclare final package Medium2 = Medium2,
    final allowFlowReversal1=allowFlowReversal1,
    final allowFlowReversal2=allowFlowReversal2,
    final show_T=show_T,
    final m1_flow_small=m1_flow_small,
    final m2_flow_small=m2_flow_small,
    final waterSideFlowDependent=waterSideFlowDependent,
    final airSideFlowDependent=airSideFlowDependent,
    final waterSideTemperatureDependent=waterSideTemperatureDependent,
    final airSideTemperatureDependent=airSideTemperatureDependent,
    final energyDynamics=energyDynamics,
    final m1_flow_nominal=m1_flow_nominal,
    final m2_flow_nominal=m2_flow_nominal,
    final dp1_nominal=0,
    final dp2_nominal=dp2_nominal)
    "Cooling coil"
    annotation (Placement(transformation(extent={{22,-12},{42,8}})));
  replaceable Buildings.Fluid.Movers.BaseClasses.PartialFlowMachine fan(
    final per=dat.perCur,
    redeclare final package Medium = Medium2,
    final allowFlowReversal=allowFlowReversal2,
    final show_T=show_T,
    final energyDynamics=energyDynamics,
    final massDynamics=massDynamics,
    final inputType=inputType,
    final addPowerToMedium=addPowerToMedium,
    final tau=tauFan,
    final use_inputFilter=use_inputFilterFan,
    final riseTime=riseTimeFan,
    final init=initFan,
    final y_start=yFan_start,
    final p_start=p_start,
    final T_start=T_start,
    each final X_start=X_start,
    each final C_start=C_start,
    each final C_nominal=C_nominal,
    final m_flow_small=m2_flow_small,
    final m_flow_nominal=m1_flow_nominal)
    constrainedby Buildings.Fluid.Movers.BaseClasses.PartialFlowMachine
    "Fan"
    annotation (Placement(transformation(extent={{-50,-70},{-70,-50}})));
  replaceable Buildings.Fluid.Actuators.BaseClasses.PartialTwoWayValveKv watVal(
    final allowFlowReversal=allowFlowReversal1,
    final show_T=show_T,
    redeclare final package Medium = Medium1,
    final l=l,
    final kFixed=kFixed,
    final CvData=Buildings.Fluid.Types.CvTypes.OpPoint,
    final from_dp=from_dp1,
    final homotopyInitialization=homotopyInitialization,
    final linearized=linearizeFlowResistance1,
    final rhoStd=rhoStd,
    final use_inputFilter=use_inputFilterValve,
    final riseTime=riseTimeValve,
    final init=initValve,
    final y_start=yValve_start,
    final dpValve_nominal=dpValve_nominal,
    final m_flow_nominal=m_flow_nominal,
    final deltaM=deltaM1,
    final dpFixed_nominal=dp1_nominal)
    constrainedby Buildings.Fluid.Actuators.BaseClasses.PartialTwoWayValveKv
    "Two-way valve" annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=-90,
        origin={60,40})));

equation

  connect(port_a1, cooCoi.port_a1) annotation (Line(points={{-100,60},{-60,60},{
          12,60},{12,4},{22,4}},    color={0,127,255}));
  connect(cooCoi.port_a2, port_a2) annotation (Line(points={{42,-8},{42,-8},{60,
          -8},{60,-60},{100,-60}}, color={0,127,255}));
  connect(cooCoi.port_b1, watVal.port_a)
    annotation (Line(points={{42,4},{60,4},{60,30}}, color={0,127,255}));
  connect(watVal.port_b, port_b1) annotation (Line(points={{60,50},{60,50},{
        60,60},{100,60}},
                     color={0,127,255}));
  connect(fan.P, PFan) annotation (Line(points={{-71,-52},{-80,-52},{-80,-80},
        {-20,-80},{-20,-110}},
                            color={0,0,127}));
  connect(watVal.y, uWatVal) annotation (Line(points={{48,40},{48,40},{-120,40}},
                     color={0,0,127}));
  connect(port_b2, fan.port_b) annotation (Line(points={{-100,-60},{-70,-60}},
                 color={0,127,255}));
  connect(watVal.y_actual, y_valve) annotation (Line(points={{53,45},{53,54},{80,
          54},{80,40},{110,40}}, color={0,0,127}));
  connect(fan.stage, stage) annotation (Line(points={{-60,-48},{-60,-40},{-120,-40}},
        color={255,127,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,255})}),
      Diagram(coordinateSystem(preserveAspectRatio=false),
        graphics={Text(extent={{54,70},{80,64}},lineColor={0,0,255},
                     textString="Waterside",textStyle={TextStyle.Bold}),
                 Text(extent={{58,-64},{84,-70}},lineColor={0,0,255},
                     textString="Airside",textStyle={TextStyle.Bold})}),
    Documentation(info="<html>
<p>This model describes a partial air handling unit model, which contains a water-side valve, a cooling coil and a fan model.</p>
<p>The valve and fan are partial models, and should be redeclared when used in the air handling unit model.</p>
</html>", revisions="<html>
<ul>
<li>May 12, 2017 by Yangyang Fu:<br/>
First implementation. 
</li>
</ul>
</html>"));
end PartialAirHandlingUnit;