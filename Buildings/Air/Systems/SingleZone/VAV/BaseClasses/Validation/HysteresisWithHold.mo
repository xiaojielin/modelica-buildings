within Buildings.Air.Systems.SingleZone.VAV.BaseClasses.Validation;
model HysteresisWithHold "Validate the block HysteresisWithHold"
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Sine sinInp(
    amplitude = 0.2,
    freqHz =    1/360) "Sine input"
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));

  Buildings.Air.Systems.SingleZone.VAV.BaseClasses.HysteresisWithHold noHold(
    onHolDur =  0,
    offHolDur = 0,
    uLow =      0.05,
    uHigh =     0.15) "No On/Off hold"
    annotation (Placement(transformation(extent={{20,50},{40,70}})));
  Buildings.Air.Systems.SingleZone.VAV.BaseClasses.HysteresisWithHold onHold_30sec(
    onHolDur =  30,
    offHolDur = 30,
    uLow =      0.05,
    uHigh =     0.15)
    "On/Off signal are hold for short period"
    annotation (Placement(transformation(extent={{20,10},{40,30}})));
  Buildings.Air.Systems.SingleZone.VAV.BaseClasses.HysteresisWithHold offHold_300sec(
    onHolDur =  30,
    offHolDur = 300,
    uLow =      0.05,
    uHigh =     0.15)
    "Off signal being hold even when it should be on"
    annotation (Placement(transformation(extent={{20,-30},{40,-10}})));
  Buildings.Air.Systems.SingleZone.VAV.BaseClasses.HysteresisWithHold onHold_150sec(
    onHolDur =  150,
    offHolDur = 30,
    uLow =      0.05,
    uHigh =     0.15)
    "On signal being hold even when it should be off."
    annotation (Placement(transformation(extent={{20,-70},{40,-50}})));

equation
  connect(sinInp.y, onHold_150sec.u)
    annotation (Line(points={{-19,0},{0,0},{0,-60},{18,-60}}, color={0,0,127}));
  connect(sinInp.y, noHold.u)
    annotation (Line(points={{-19,0},{0,0},{0,60},{18,60}}, color={0,0,127}));
  connect(sinInp.y, offHold_300sec.u)
    annotation (Line(points={{-19,0},{-10,0},{0,0},{0,-20},{18,-20}},
      color={0,0,127}));
  connect(sinInp.y, onHold_30sec.u)
    annotation (Line(points={{-19,0},{0,0},{0,20},{18,20}}, color={0,0,127}));
  annotation (
  experiment(StopTime=1800,  Tolerance=1e-06),
  __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Air/Systems/SingleZone/VAV/BaseClasses/Validation/HysteresisWithHold.mos"
        "Simulate and plot"),
  Documentation(info="<html>
<p>
Validation test for the block 
<a href=\"modelica://Buildings.Air.Systems.SingleZone.VAV.BaseClasses.HysteresisWithHold\">
Buildings.Air.Systems.SingleZone.VAV.BaseClasses.HysteresisWithHold</a>.
</p>
<p>
The validation uses different instances to validate different hold durations.
</p>
<ul>
<li>
On hold duration time <code>onHolDur=0</code>, 
Off hold duration time <code>offHolDur=0</code>;
</li>
<li>
On hold duration time <code>onHolDur=30</code>, 
Off hold duration time <code>offHolDur=30</code>;
</li>
<li>
On hold duration time <code>onHolDur=30</code>, 
Off hold duration time <code>offHolDur=300</code>; The off hold period covers
the instance when it should be on.
</li>
<li>
On hold duration time <code>onHolDur=150</code>, 
Off hold duration time <code>offHolDur=30</code>; The on hold period covers
the instance when it should be off.
</li>
</ul>
</html>", revisions="<html>
<ul>
<li>
June 26, 2017, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"));
end HysteresisWithHold;
