within Buildings.Fluid.Movers.BaseClasses;
model FlowControlled
  "Partial model for fan or pump with ideally controlled mass flow rate or head as input signal"

  extends Buildings.Fluid.Movers.BaseClasses.PartialFlowMachine(
   preSou(final control_m_flow=control_m_flow));

  extends Buildings.Fluid.Movers.BaseClasses.PowerInterface(
   _perPow(final hydraulicEfficiency=per.hydraulicEfficiency,
           final motorEfficiency=per.motorEfficiency,
           final power=per.power,
           final motorCooledByFluid=per.motorCooledByFluid,
           final use_powerCharacteristic = per.use_powerCharacteristic),
            delta_V_flow = 1E-3*V_flow_max,
     final rho_default = Medium.density(sta_default));

  import cha = Buildings.Fluid.Movers.BaseClasses.Characteristics;

  // what to control
  constant Boolean control_m_flow "= false to control head instead of m_flow"
    annotation(Evaluate=true);

  replaceable parameter Data.FlowControlled per "Record with performance data"
    annotation (choicesAllMatching=true,
      Placement(transformation(extent={{60,-80},{80,-60}})));

  Real r_V(start=1)
    "Ratio V_flow/V_flow_max = V_flow/V_flow(dp=0, N=N_nominal)";

protected
  final parameter Medium.AbsolutePressure p_a_default(displayUnit="Pa") = Medium.p_default
    "Nominal inlet pressure for predefined fan or pump characteristics";

 parameter Modelica.SIunits.VolumeFlowRate V_flow_max=m_flow_nominal/rho_default
    "Maximum volume flow rate";

  parameter Medium.ThermodynamicState sta_default = Medium.setState_pTX(
     T=Medium.T_default,
     p=Medium.p_default,
     X=Medium.X_default[1:Medium.nXi]) "Default medium state";

  Modelica.Blocks.Sources.RealExpression PToMedium_flow(y=Q_flow + WFlo) if  addPowerToMedium
    "Heat and work input into medium"
    annotation (Placement(transformation(extent={{-100,10},{-80,30}})));

  parameter Real powDer[size(per.power.V_flow,1)]=
   if per.use_powerCharacteristic then
     Buildings.Utilities.Math.Functions.splineDerivatives(
                   x=per.power.V_flow,
                   y=per.power.P,
                   ensureMonotonicity=Buildings.Utilities.Math.Functions.isMonotonic(x=per.power.P,
                                                                                     strict=false))
   else
     zeros(size(per.power.V_flow,1))
    "Coefficients for polynomial of power vs. flow rate";

  Modelica.SIunits.Density rho=rho_in "Medium density";
  Real fixme "Approximate value of r_N";
equation
//  etaHyd = cha.efficiency(per=per.hydraulicEfficiency, V_flow=VMachine_flow, d=hydDer, r_N=1, delta=1E-4);
//  etaMot = cha.efficiency(per=per.motorEfficiency,     V_flow=VMachine_flow, d=motDer, r_N=1, delta=1E-4);
  // To compute the electrical power, we set a lower bound for eta to avoid
  // a division by zero.
//  P = WFlo / Buildings.Utilities.Math.Functions.smoothMax(x1=eta, x2=1E-5, deltaX=1E-6);
  //////

  // Power consumption
  // This is the same compuation as in FlowMachineInterface, but since the speed is not known,
  // and because V_flow approximately proportional to the speed (by the affinity laws),
  // we use r_V instead of r_N.
  if per.use_powerCharacteristic then
    // For the homotopy, we want P/V_flow to be bounded as V_flow -> 0 to avoid a very high medium
    // temperature near zero flow.
    if homotopyInitialization then
      P = homotopy(actual=cha.power(per=per.power, V_flow=VMachine_flow, r_N=fixme, d=powDer, delta=1E-4),
                      simplified=port_a.m_flow/m_flow_nominal*
                            cha.power(per=per.power, V_flow=m_flow_nominal/rho_default, r_N=1, d=powDer, delta=1E-4));
    else
      P = (rho/rho_default)*cha.power(per=per.power, V_flow=VMachine_flow, r_N=fixme, d=powDer, delta=1E-4);
    end if;
    // To compute the efficiency, we set a lower bound on the electricity consumption.
    // This is needed because WFlo can be close to zero when P is zero, thereby
    // causing a division by zero.
    // Earlier versions of the model computed WFlo = eta * P, but this caused
    // a division by zero.
    eta = WFlo / Buildings.Utilities.Math.Functions.smoothMax(x1=P, x2=1E-5, deltaX=1E-6);
    // In this configuration, we only know the total power consumption.
    // Because nothing is known about etaMot versus etaHyd, we set etaHyd=1. This will
    // cause etaMot=eta, because eta=etaHyd*etaMot.
    // Earlier versions used etaMot=sqrt(eta), but as eta->0, this function has
    // and infinite derivative.
    etaHyd = 1;
  else
    if homotopyInitialization then
      etaHyd = homotopy(actual=cha.efficiency(per=per.hydraulicEfficiency,     V_flow=VMachine_flow, d=hydDer, r_N=fixme, delta=1E-4),
                        simplified=cha.efficiency(per=per.hydraulicEfficiency, V_flow=V_flow_max,   d=hydDer, r_N=fixme, delta=1E-4));
      etaMot = homotopy(actual=cha.efficiency(per=per.motorEfficiency,     V_flow=VMachine_flow, d=motDer, r_N=fixme, delta=1E-4),
                        simplified=cha.efficiency(per=per.motorEfficiency, V_flow=V_flow_max,   d=motDer, r_N=fixme, delta=1E-4));
    else
      etaHyd = cha.efficiency(per=per.hydraulicEfficiency, V_flow=VMachine_flow, d=hydDer, r_N=fixme, delta=1E-4);
      etaMot = cha.efficiency(per=per.motorEfficiency,     V_flow=VMachine_flow, d=motDer, r_N=fixme, delta=1E-4);
    end if;
    // To compute the electrical power, we set a lower bound for eta to avoid
    // a division by zero.
    P = WFlo / Buildings.Utilities.Math.Functions.smoothMax(x1=eta, x2=1E-5, deltaX=1E-6);

  end if;

  r_V = VMachine_flow/V_flow_max;
  fixme = 1;// r_V/0.71;
  dpMachine = -dp;
  VMachine_flow = port_a.m_flow/rho_in;

  connect(PToMedium_flow.y, prePow.Q_flow) annotation (Line(
      points={{-79,20},{-70,20}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (defaultComponentName="fan",
    Documentation(info="<html>
<p>
This model describes a fan or pump that takes as an input
the head or the mass flow rate.
</p>
</html>",
      revisions="<html>
<ul>
<li>
September 2, 2015, by Michael Wetter:<br/>
Implemented computation of power if <code>per.use_powerCharacteristic=true</code>.
Previously, the value of this parameter was ignored.
This is for
<a href=\"modelica://https://github.com/lbl-srg/modelica-buildings/issues/457\">
issue 457</a>.<br/>
Corrected computation of
<code>etaMot = cha.efficiency(per=per.motorEfficiency,     V_flow=VMachine_flow, d=motDer, r_N=fixme, delta=1E-4)</code>
which previously used <code>V_flow_max</code> instead of <code>VMachine_flow</code>.<br/>
Changed assignments of parameters of record <code>_perPow</code> to be <code>final</code>
as we want users to change the performance record and not the low level declaration.
</li>      
<li>
January 6, 2015, by Michael Wetter:<br/>
Revised model for OpenModelica.
</li>
<li>
April 19, 2014, by Filip Jorissen:<br/>
Set default values for new parameters in <code>efficiency()</code>.
</li>
<li>
October 8, 2013, by Michael Wetter:<br/>
Removed parameter <code>show_V_flow</code>.
</li>
<li>
September 13, 2013 by Michael Wetter:<br/>
Corrected computation of <code>sta_default</code> to use medium default
values instead of medium start values.
</li>
<li>
December 14, 2012 by Michael Wetter:<br/>
Renamed protected parameters for consistency with the naming conventions.
</li>
<li>
October 11, 2012, by Michael Wetter:<br/>
Added implementation of <code>WFlo = eta * P</code> with
guard against division by zero.
</li>
<li>
May 25, 2011, by Michael Wetter:<br/>
Revised implementation of energy balance to avoid having to use conditionally removed models.
</li>
<li>
November 11, 2010, by Michael Wetter:<br/>
Changed <code>V_flow_max=m_flow_nominal/rho_nominal;</code> to <code>V_flow_max=m_flow_max/rho_nominal;</code>
</li>
<li>
July 27, 2010, by Michael Wetter:<br/>
Redesigned model to fix bug in medium balance.
</li>
<li>
March 24, 2010, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end FlowControlled;
