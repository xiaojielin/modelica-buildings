within Buildings.Fluid.FMI;
partial block FourPort
  "Container to export a thermofluid flow model with four ports as an FMU"

  replaceable package Medium1 =
      Modelica.Media.Interfaces.PartialMedium "Medium 1 in the component"
      annotation (choicesAllMatching = true);
  replaceable package Medium2 =
      Modelica.Media.Interfaces.PartialMedium "Medium 2 in the component"
      annotation (choicesAllMatching = true);

  parameter Boolean allowFlowReversal1 = true
    "= true to allow flow reversal in medium 1, false restricts to design direction (port_a -> port_b)"
    annotation(Dialog(tab="Assumptions"), Evaluate=true);
  parameter Boolean allowFlowReversal2 = true
    "= true to allow flow reversal in medium 2, false restricts to design direction (port_a -> port_b)"
    annotation(Dialog(tab="Assumptions"), Evaluate=true);

  parameter Boolean use_p1_in = true
    "= true to use a pressure from connector for fluid 1, false to output Medium1.p_default"
    annotation(Evaluate=true);

  parameter Boolean use_p2_in = true
    "= true to use a pressure from connector for fluid 1, false to output Medium1.p_default"
    annotation(Evaluate=true);

  Interfaces.Inlet inlet1(
    redeclare final package Medium = Medium1,
    final allowFlowReversal=allowFlowReversal1,
    final use_p_in=use_p1_in) "Fluid inlet"
    annotation (Placement(transformation(extent={{-120,50},{-100,70}})));

  Interfaces.Outlet outlet1(
    redeclare final package Medium = Medium1,
    final allowFlowReversal=allowFlowReversal1,
    final use_p_in=use_p1_in) "Fluid outlet"
                   annotation (Placement(transformation(extent={{100,50},{120,70}}),
                   iconTransformation(extent={{100,50},{120,70}})));

  Interfaces.Inlet inlet2(
    redeclare final package Medium = Medium2,
    final allowFlowReversal=allowFlowReversal2,
    final use_p_in=use_p2_in) "Fluid inlet"
    annotation (Placement(transformation(extent={{120,-70},{100,-50}})));

  Interfaces.Outlet outlet2(
    redeclare final package Medium = Medium2,
    final allowFlowReversal=allowFlowReversal2,
    final use_p_in=use_p2_in) "Fluid outlet"
                   annotation (Placement(transformation(extent={{-100,-70},{-120,
            -50}}),iconTransformation(extent={{-100,-70},{-120,-50}})));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255}),
            Text(
          extent={{-151,147},{149,107}},
          lineColor={0,0,255},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255},
          textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false,
                   extent={{-100,-100},{100,100}}), graphics),
    Documentation(info="<html>
<p>
Partial model that can be used to export thermofluid flow models with four fluid ports as an FMU.
This model only declares the inlet and outlet ports, the medium and
whether flow reversal is allowed.
</p>
<p>
See
<a href=\"modelica://Buildings.Fluid.FMI.Examples.FMUs.ResistanceVolume\">
Buildings.Fluid.FMI.Examples.FMUs.ResistanceVolume (fixme)</a>
for a block that extends this partial block.
</p>
</html>", revisions="<html>
<ul>
<li>
July 17, 2015, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"));
end FourPort;
