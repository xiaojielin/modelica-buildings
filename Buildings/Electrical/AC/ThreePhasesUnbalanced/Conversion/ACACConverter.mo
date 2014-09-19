within Buildings.Electrical.AC.ThreePhasesUnbalanced.Conversion;
model ACACConverter "AC AC converter single phase systems (YY)"
  extends
    Buildings.Electrical.AC.ThreePhasesUnbalanced.Conversion.BaseClasses.PartialConverterYY(
    redeclare Buildings.Electrical.AC.OnePhase.Conversion.ACACConverter conv1(
      conversionFactor=conversionFactor,
      eta=eta,
      ground_1=ground_1,
      ground_2=ground_2),
    redeclare Buildings.Electrical.AC.OnePhase.Conversion.ACACConverter conv2(
      conversionFactor=conversionFactor,
      eta=eta,
      ground_1=ground_1,
      ground_2=ground_2),
    redeclare Buildings.Electrical.AC.OnePhase.Conversion.ACACConverter conv3(
      conversionFactor=conversionFactor,
      eta=eta,
      ground_1=ground_1,
      ground_2=ground_2));
  parameter Real conversionFactor
    "Ratio of QS rms voltage on side 2 / QS rms voltage on side 1";
  parameter Real eta(min=0, max=1)
    "Converter efficiency, pLoss = (1-eta) * Ptr";
  parameter Boolean ground_1 = false "Connect side 1 of converter to ground" annotation(Dialog(tab = "Ground", group="side 1"));
  parameter Boolean ground_2 = true "Connect side 2 of converter to ground" annotation(Dialog(tab = "Ground", group="side 2"));
equation

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics), Icon(graphics={
        Line(
          points={{2,60},{2,60},{82,60},{2,60},{82,-60},{2,-60},{2,60},{2,-60}},
          color={0,120,120},
          smooth=Smooth.None),
        Line(
          points={{-2,60},{-2,60},{-82,60},{-2,60},{-82,-60},{-2,-60},{-2,60},{
              -2,-60}},
          color={11,193,87},
          smooth=Smooth.None),
        Text(
          extent={{-100,92},{100,60}},
          lineColor={0,120,120},
          textString="%name"),
        Text(
          extent={{-100,-60},{100,-92}},
          lineColor={0,120,120},
          textString="%conversionFactor"),
        Text(
          extent={{-132,78},{-72,38}},
          lineColor={11,193,87},
          textString="1"),
        Text(
          extent={{-88,52},{-28,12}},
          lineColor={11,193,87},
          textString="AC"),
        Text(
          extent={{32,52},{92,12}},
          lineColor={0,120,120},
          textString="AC"),
        Text(
          extent={{70,78},{130,38}},
          lineColor={0,120,120},
          textString="2"),
        Line(
          points={{-80,-40},{-120,-40}},
          color=DynamicSelect({0,120,120}, if ground_1 then {0,120,120} else {
              255,255,255}),
          smooth=Smooth.None,
          thickness=0.5),
        Line(
          points={{-80,-40},{-106,-14}},
          color=DynamicSelect({0,120,120}, if ground_1 then {0,120,120} else {255,
              255,255}),
          smooth=Smooth.None,
          thickness=0.5),
        Line(
          points={{-102,-16},{-114,-24},{-118,-42}},
          color=DynamicSelect({0,120,120}, if ground_1 then {0,120,120} else {
              255,255,255}),
          smooth=Smooth.Bezier),
        Line(
          points={{80,-40},{120,-40}},
          color=DynamicSelect({0,120,120}, if ground_2 then {0,120,120} else {
              255,255,255}),
          smooth=Smooth.None,
          thickness=0.5),
        Line(
          points={{80,-40},{106,-14}},
          color=DynamicSelect({0,120,120}, if ground_2 then {0,120,120} else {
              255,255,255}),
          smooth=Smooth.None,
          thickness=0.5),
        Line(
          points={{102,-16},{114,-24},{118,-42}},
          color=DynamicSelect({0,120,120}, if ground_2 then {0,120,120} else {
              255,255,255}),
          smooth=Smooth.Bezier)}),
    Documentation(info="<html>
<p>
This is an AC AC converter, based on a power balance between both circuit sides.
The paramater <i>conversionFactor</i> defines the ratio between the RMS voltages
</p>

<p align=\"center\" style=\"font-style:italic;\">
V<sub>2</sub> = conversionFactor * V<sub>1</sub>
</p>

<p>
where <i>V<sub>1</sub></i> and <i>V<sub>2</sub></i> are the RMS voltages
at the primary and secondary sides of the transformer (connector N and P 
respectively).
</p>

<p>
The loss of the converter is proportional to the power transmitted.
The parameter <code>eps</code> is the efficiency of the transfer.
The loss is computed as
</p>
<p align=\"center\" style=\"font-style:italic;\">
P<sub>loss</sub> = (1-&eta;) P<sub>tr</sub>
</p>
<p>
where <i>P<sub>tr</sub></i> is the power transmitted. The model is bi-directional
and the power can flow from both the primary to the secondary and vice-versa.
Furthermore, reactive power on both side are set to 0.
</p>
<h4>Note:</h4>
<p>
This model reuses models from
<a href=\"modelica://Buildings.Electrical.AC.OnePhase.Conversion.ACACConverter\">
Buildings.Electrical.AC.OnePhase.Conversion.ACACConverter</a>.
</p>
<p>
See
<a href=\"modelica://Buildings.Electrical.AC.ThreePhasesUnbalanced.Conversion.BaseClasses.PartialConverterYY\">
Buildings.Electrical.AC.ThreePhasesUnbalanced.Conversion.BaseClasses.PartialConverterYY</a> for
details on the connections.
</p>
</html>"));
end ACACConverter;