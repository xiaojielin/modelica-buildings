within Buildings.Fluid.FMI;
block FourPortComponent
  "Container to export thermofluid flow models with four ports as an FMU"
  extends FourPort;
  replaceable Buildings.Fluid.Interfaces.FourPort com
    constrainedby Buildings.Fluid.Interfaces.FourPort(
      redeclare final package Medium1 = Medium1,
      redeclare final package Medium2 = Medium2,
      final allowFlowReversal1=allowFlowReversal1,
      final allowFlowReversal2=allowFlowReversal2)
    "Component that holds the actual model"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  Modelica.Blocks.Sources.RealExpression dpCom1(y=com.port_a1.p - com.port_b1.p) if
       use_p1_in "Pressure drop of the component 1"
    annotation (Placement(transformation(extent={{-40,18},{-20,38}})));

  Modelica.Blocks.Sources.RealExpression dpCom2(y=com.port_a2.p - com.port_b2.p) if
       use_p2_in "Pressure drop of the component 2"
    annotation (Placement(transformation(extent={{40,-104},{20,-84}})));

protected
  Buildings.Fluid.FMI.InletAdaptor bouIn1(
    redeclare final package Medium = Medium1,
    final allowFlowReversal=allowFlowReversal1,
    final use_p_in=use_p1_in) "Boundary model for inlet 1"
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));

  Buildings.Fluid.FMI.OutletAdaptor bouOut1(
    redeclare final package Medium = Medium1,
    final allowFlowReversal=allowFlowReversal1,
    final use_p_in=use_p1_in) "Boundary component for outlet 1"
    annotation (Placement(transformation(extent={{60,50},{80,70}})));

  Modelica.Blocks.Math.Feedback pOut1 if
       use_p1_in "Pressure at component 1 outlet"
    annotation (Placement(transformation(extent={{-10,30},{10,50}})));

  Buildings.Fluid.FMI.InletAdaptor bouIn2(
    redeclare final package Medium = Medium2,
    final allowFlowReversal=allowFlowReversal2,
    final use_p_in=use_p2_in) "Boundary model for inlet 2"
    annotation (Placement(transformation(extent={{80,-70},{60,-50}})));

  Buildings.Fluid.FMI.OutletAdaptor bouOut2(
    redeclare final package Medium = Medium2,
    final allowFlowReversal=allowFlowReversal2,
    final use_p_in=use_p2_in) "Boundary component for outlet 2"
    annotation (Placement(transformation(extent={{-60,-70},{-80,-50}})));

  Modelica.Blocks.Math.Feedback pOut2 if
       use_p2_in "Pressure at component 2 outlet"
    annotation (Placement(transformation(extent={{10,-90},{-10,-70}})));

equation
  connect(pOut1.u1, bouIn1.p) annotation (Line(
      points={{-8,40},{-70,40},{-70,49}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(dpCom1.y, pOut1.u2) annotation (Line(
      points={{-19,28},{0,28},{0,32}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pOut1.y, bouOut1.p) annotation (Line(
      points={{9,40},{70,40},{70,48}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(inlet2, bouIn2.inlet)
    annotation (Line(points={{110,-60},{81,-60},{81,-60}}, color={0,0,255}));
  connect(bouIn2.p, pOut2.u1) annotation (Line(points={{70,-71},{70,-71},{70,-80},
          {8,-80}}, color={0,0,127}));
  connect(dpCom2.y, pOut2.u2)
    annotation (Line(points={{19,-94},{0,-94},{0,-88}}, color={0,0,127}));
  connect(pOut2.y, bouOut2.p) annotation (Line(points={{-9,-80},{-40,-80},{-70,-80},
          {-70,-72}}, color={0,0,127}));
  connect(bouOut2.outlet, outlet2) annotation (Line(points={{-81,-60},{-110,-60},
          {-110,-60}}, color={0,0,255}));
  connect(inlet1, bouIn1.inlet)
    annotation (Line(points={{-110,60},{-81,60},{-81,60}}, color={0,0,255}));
  connect(bouOut1.outlet, outlet1)
    annotation (Line(points={{81,60},{110,60},{110,60}}, color={0,0,255}));
  connect(bouIn1.port_b, com.port_a1) annotation (Line(points={{-60,60},{-50,60},
          {-50,6},{-10,6}}, color={0,127,255}));
  connect(com.port_b1, bouOut1.port_a) annotation (Line(points={{10,6},{50,6},{50,
          60},{60,60}}, color={0,127,255}));
  connect(bouIn2.port_b, com.port_a2) annotation (Line(points={{60,-60},{32,-60},
          {32,-6},{10,-6}}, color={0,127,255}));
  connect(com.port_b2, bouOut2.port_a) annotation (Line(points={{-10,-6},{-30,-6},
          {-50,-6},{-50,-60},{-60,-60}}, color={0,127,255}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),           Documentation(info="<html>
<p>
Block that serves as a container to export a thermofluid flow component
with four ports.
This block contains a replaceable model <code>com</code> that needs to
be redeclared to export any model that has as its base class
<a href=\"modelica://Buildings.Fluid.Interfaces.PartialFourPort\">
Buildings.Fluid.Interfaces.PartialFourPort</a>.
This allows exporting a large variety of thermofluid flow models
with a simple redeclare.
</p>
<p>
See for example
<a href=\"modelica://Buildings.Fluid.FMI.Examples.FMUs.FixedResistanceDpM\">
Buildings.Fluid.FMI.Examples.FMUs.FixedResistanceDpM (fixme)</a>
or
<a href=\"modelica://Buildings.Fluid.FMI.Examples.FMUs.HeaterCooler_u\">
Buildings.Fluid.FMI.Examples.FMUs.HeaterCooler_u (fixme)</a>
for how to use this block.
</p>
<p>
Note that this block must not be used if the instance <code>com</code>
sets a constant pressure. In such a situation, use
<a href=\"modelica://Buildings.Fluid.FMI.TwoPort\">
Buildings.Fluid.FMI.TwoPort</a>
together with
<a href=\"modelica://Buildings.Fluid.FMI.InletAdaptor\">
Buildings.Fluid.FMI.InletAdaptor</a>
and
<a href=\"modelica://Buildings.Fluid.FMI.OutletAdaptor\">
Buildings.Fluid.FMI.OutletAdaptor</a>
and set the pressure to be equal to the port <code>p</code> of
<a href=\"modelica://Buildings.Fluid.FMI.OutletAdaptor\">
Buildings.Fluid.FMI.OutletAdaptor</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
July 17, 2015, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end FourPortComponent;
