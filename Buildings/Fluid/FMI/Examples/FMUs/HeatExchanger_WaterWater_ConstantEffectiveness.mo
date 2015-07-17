within Buildings.Fluid.FMI.Examples.FMUs;
block HeatExchanger_WaterWater_ConstantEffectiveness
  "FMU declaration for a water to water heat exchanger with constant heat transfer effectiveness"
   extends Buildings.Fluid.FMI.FourPortComponent(
     redeclare replaceable package Medium1 = Buildings.Media.Water,
     redeclare replaceable package Medium2 = Buildings.Media.Water,
     allowFlowReversal1=false,
     allowFlowReversal2=false,
     redeclare final Buildings.Fluid.HeatExchangers.ConstantEffectiveness com(
      final m1_flow_nominal=m1_flow_nominal,
      final m2_flow_nominal=m2_flow_nominal,
      final dp1_nominal=if use_p1_in then dp1_nominal else 0,
      final dp2_nominal=if use_p2_in then dp2_nominal else 0,
      final from_dp1=from_dp1,
      final from_dp2=from_dp2,
      final linearizeFlowResistance1 = linearizeFlowResistance1,
      final linearizeFlowResistance2 = linearizeFlowResistance2,
      final eps=eps,
      final show_T=false));

  parameter Real eps(min=0, max=1) = 0.8 "Heat exchanger effectiveness";

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
This example demonstrates how to export an FMU with a water to water
heat exchanger with constant effectiveness.
The FMU has an instance of
<a href=\"modelica://Buildings.Fluid.HeatExchangers.ConstantEffectiveness\">
Buildings.Fluid.HeatExchangers.ConstantEffectiveness</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
July 17, 2015 by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
__Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Fluid/FMI/Examples/FMUs/HeatExchanger_WaterWater_ConstantEffectiveness.mos"
        "Export FMU"),
    Icon(graphics={                      Rectangle(
          extent={{-72,78},{68,-82}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,65},{101,55}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,-55},{101,-65}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-56,0},{54,-60}},
          lineColor={255,255,255},
          textString="eps=%eps")}));
end HeatExchanger_WaterWater_ConstantEffectiveness;
