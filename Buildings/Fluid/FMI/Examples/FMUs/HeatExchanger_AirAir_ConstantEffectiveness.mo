within Buildings.Fluid.FMI.Examples.FMUs;
block HeatExchanger_AirAir_ConstantEffectiveness
  "FMU declaration for an air to air heat exchanger with constant heat and mass transfer effectiveness"
   extends Buildings.Fluid.FMI.FourPortComponent(
     redeclare replaceable package Medium1 = Buildings.Media.Air,
     redeclare replaceable package Medium2 = Buildings.Media.Air,
     redeclare final Buildings.Fluid.MassExchangers.ConstantEffectiveness com(
      final m1_flow_nominal=m1_flow_nominal,
      final m2_flow_nominal=m2_flow_nominal,
      final dp1_nominal=if use_p1_in then dp1_nominal else 0,
      final dp2_nominal=if use_p2_in then dp2_nominal else 0,
      final from_dp1=from_dp1,
      final from_dp2=from_dp2,
      final linearizeFlowResistance1 = linearizeFlowResistance1,
      final linearizeFlowResistance2 = linearizeFlowResistance2,
      final epsS=epsS,
      final epsL=epsL,
      final show_T=false));

  parameter Real epsS(min=0, max=1) = 0.8
    "Sensible heat exchanger effectiveness";

  parameter Real epsL(min=0, max=1) = 0.8 "Latent heat exchanger effectiveness";

  parameter Modelica.SIunits.MassFlowRate m1_flow_nominal(min=0) = 0.1
    "Nominal mass flow rate of medium 1"
    annotation(Dialog(group = "Nominal condition"));

  parameter Modelica.SIunits.MassFlowRate m2_flow_nominal(min=0) = 0.1
    "Nominal mass flow rate of medium 2"
    annotation(Dialog(group = "Nominal condition"));

  parameter Modelica.SIunits.Pressure dp1_nominal(min=0, displayUnit="Pa") = 500
    "Nominal pressure difference of medium 1"
    annotation(Dialog(group = "Nominal condition"));

  parameter Modelica.SIunits.Pressure dp2_nominal(min=0, displayUnit="Pa") = 500
    "Nominal pressure difference of medium 2"
    annotation(Dialog(group = "Nominal condition"));

  parameter Boolean from_dp1 = false
    "= true, use m_flow = f(dp) else dp = f(m_flow)"
    annotation (Evaluate=true, Dialog(enable = computeFlowResistance1,
                tab="Flow resistance", group="Medium 1"));

  parameter Boolean from_dp2 = false
    "= true, use m_flow = f(dp) else dp = f(m_flow)"
    annotation (Evaluate=true, Dialog(enable = computeFlowResistance2,
                tab="Flow resistance", group="Medium 2"));

  parameter Boolean linearizeFlowResistance1 = false
    "= true, use linear relation between m_flow and dp for any flow rate"
    annotation(Dialog(
               tab="Flow resistance", group="Medium 1"));
  parameter Boolean linearizeFlowResistance2 = false
    "= true, use linear relation between m_flow and dp for any flow rate"
    annotation(Dialog(
               tab="Flow resistance", group="Medium 1"));

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics),
  Documentation(info="<html>
<p>
This example demonstrates how to export an FMU with an air to air
heat and mass exchanger with constant effectiveness.
The FMU has an instance of
<a href=\"modelica://Buildings.Fluid.MassExchangers.ConstantEffectiveness\">
Buildings.Fluid.MassExchangers.ConstantEffectiveness</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
July 17, 2015 by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
__Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Fluid/FMI/Examples/FMUs/HeatExchanger_AirAir_ConstantEffectiveness.mos"
        "Export FMU"),
    Icon(graphics={
        Polygon(
          points={{22,-75},{52,-85},{22,-95},{22,-75}},
          lineColor={255,255,255},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=allowFlowReversal),
        Rectangle(
          extent={{-68,60},{72,-60}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-101,6},{100,-4}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{2,-4},{102,6}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-68,80},{72,-80}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-54,-12},{56,-72}},
          lineColor={255,255,255},
          textString="Q=%Q_flow_nominal"),
        Rectangle(
          extent={{-100,61},{-68,58}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,127},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-104,94},{-60,66}},
          lineColor={0,0,255},
          textString="u")}));
end HeatExchanger_AirAir_ConstantEffectiveness;
