within Buildings.Experimental.OpenBuildingControl.CDL.Logical.Composite;
block OnOffHold "The block introduces a minimal offset between the input signal rising and falling edge"

  parameter Modelica.SIunits.Time holdDuration
    "Time duration during which the output cannot change";
  parameter Real equTor = 1e-10 "Torelance used for equality evaluation";

  Interfaces.BooleanInput u "Boolean input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-122,-10},{-102,10}})));
  Interfaces.BooleanOutput y "Boolean output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}}),
        iconTransformation(extent={{100,-10},{120,10}})));

  Logical.Timer timer "Timer to measure time elapsed after the output signal edge"
    annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));
  Modelica.Blocks.Logical.Pre pre "Introduces infinitesimally small time delay"
    annotation (Placement(transformation(extent={{40,-20},{60,0}})));
  Logical.Not not1 "Not block"
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Logical.Or or2 "Or block"
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Logical.And andBeforeTimerAndSwitch "And block"
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  Logical.LogicalSwitch logSwi "Logical switch"
    annotation (Placement(transformation(extent={{60,20},{80,40}})));
  Logical.GreaterThreshold greThr(final threshold=holdDuration)
    annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
  Logical.Change cha1 "Change block"
    annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
  Logical.Not not3 "Not block" annotation (Placement(transformation(extent={{60,-70},
            {80,-50}})));
  Logical.Xor xor "Xor block" annotation (Placement(transformation(extent={{-40,60},
            {-20,80}})));
  Logical.Not not2 "Not block" annotation (Placement(transformation(extent={{-10,60},
            {10,80}})));
  LessThreshold lesEqu(threshold = iniZer+equTor)
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  GreaterThreshold greEqu(threshold = iniZer-equTor)
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  And and2 annotation (Placement(transformation(extent={{-20,0},{0,20}})));

protected
  parameter Real iniZer = 0;

equation

  connect(or2.y, andBeforeTimerAndSwitch.u2) annotation (Line(points={{1,-30},{
          12,-30},{12,62},{18,62}}, color={255,0,255}));
  connect(andBeforeTimerAndSwitch.y, logSwi.u2) annotation (Line(points={{41,70},
          {41,70},{50,70},{50,30},{58,30}},                 color={255,0,255}));
  connect(u, logSwi.u1) annotation (Line(points={{-120,0},{-88,0},{-88,38},{58,
          38}},    color={255,0,255}));
  connect(logSwi.y, pre.u) annotation (Line(points={{81,30},{88,30},{88,10},{30,
          10},{30,-10},{38,-10}},
                 color={255,0,255}));
  connect(logSwi.u3, pre.y) annotation (Line(points={{58,22},{20,22},{20,-28},{
          80,-28},{80,-10},{61,-10}},
                 color={255,0,255}));
  connect(pre.y, not1.u) annotation (Line(points={{61,-10},{92,-10},{92,88},{
          -88,88},{-88,70},{-82,70}},
                color={255,0,255}));
  connect(or2.u2, greThr.y) annotation (Line(points={{-22,-38},{-30,-38},{-30,
          -60},{-39,-60}},
                      color={255,0,255}));
  connect(timer.y, greThr.u) annotation (Line(points={{-39,-100},{-30,-100},{
          -30,-80},{-70,-80},{-70,-60},{-62,-60}},
                                               color={0,0,127}));
  connect(pre.y, cha1.u) annotation (Line(points={{61,-10},{80,-10},{80,-40},{
          10,-40},{10,-60},{18,-60}},
                                   color={255,0,255}));
  connect(timer.u, not3.y) annotation (Line(points={{-62,-100},{-70,-100},{-70,
          -112},{86,-112},{86,-60},{81,-60}},   color={255,0,255}));
  connect(cha1.y, not3.u)
    annotation (Line(points={{41,-60},{46,-60},{58,-60}},
                                                 color={255,0,255}));
  connect(not1.y, xor.u1) annotation (Line(points={{-59,70},{-42,70}},
                color={255,0,255}));
  connect(u, xor.u2) annotation (Line(points={{-120,0},{-88,0},{-88,38},{-52,38},
          {-52,62},{-42,62}},
        color={255,0,255}));
  connect(xor.y, not2.u)
    annotation (Line(points={{-19,70},{-19,70},{-12,70}}, color={255,0,255}));
  connect(andBeforeTimerAndSwitch.u1, not2.y)
    annotation (Line(points={{18,70},{18,70},{11,70}},
                                              color={255,0,255}));
  connect(greEqu.y, and2.u1) annotation (Line(points={{-39,20},{-32,20},{-32,10},
          {-22,10}}, color={255,0,255}));
  connect(lesEqu.y, and2.u2) annotation (Line(points={{-39,-10},{-32,-10},{-32,
          2},{-22,2}}, color={255,0,255}));
  connect(and2.y, or2.u1) annotation (Line(points={{1,10},{6,10},{6,-14},{-30,
          -14},{-30,-30},{-22,-30}}, color={255,0,255}));
  connect(logSwi.y, y) annotation (Line(points={{81,30},{88,30},{88,0},{110,0}},
        color={255,0,255}));
  connect(timer.y, greEqu.u) annotation (Line(points={{-39,-100},{-30,-100},{-30,
          -80},{-70,-80},{-70,20},{-62,20}}, color={0,0,127}));
  connect(timer.y, lesEqu.u) annotation (Line(points={{-39,-100},{-30,-100},{-30,
          -80},{-70,-80},{-70,-10},{-62,-10}}, color={0,0,127}));
  annotation (Icon(graphics={    Rectangle(
          extent={{-100,100},{100,-100}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          borderPattern=BorderPattern.Raised,
          lineColor={0,0,0}),
          Line(points={{-84,10},{-50,10},{-50,54},{-18,54},{-18,10},{-18,10}},
              color={255,0,255}),
          Line(points={{-78,-46},{-48,-46},{-48,-2},{-24,-2},{-24,-46},{-24,-46}}),
          Line(points={{-24,-46},{6,-46},{6,-2},{44,-2},{44,-46},{74,-46}}),
          Line(points={{-18,10},{14,10},{14,54},{46,54},{46,10},{66,10}},
              color={255,0,255}),
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          lineColor={0,0,255}),
        Text(
          extent={{-90,-62},{96,-90}},
          lineColor={0,0,255},
          textString="%holdDuration")}),                               Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-120},{100,100}})),
              Documentation(info="<html>
<p>
Block that holds an on or off signal constant for at least a defined time period.
</p>
<p>
Whenever the input <code>u</code> switches, the output <code>y</code>
switches and remains at that value for at least <code>holdDuration</code>
seconds, where <code>holdDuration</code> is a parameter.
After <code>holdDuration</code> elapsed, the output will be
<code>y = u</code>.
If this change required changing the value of <code>y</code>,
then <code>y</code> will remain at that value for at least <code>holdDuration</code>.
Otherwise, <code>y</code> will change immediately whenever <code>u</code>
changes.
</p>
<p>
This block could for example be used to disable an economizer,
and not re-enable it for 10 minutes, and vice versa.
</p>
<p>
Simulation results of a typical example with the block default
on off hold time of 15 min is shown in the next figure.
</p>

<p align=\"center\">
<img src=\"modelica://Buildings/Resources/Images/Experimental/OpenBuildingControl/CDL/Logical/Composite/OnOffHold.png\"
alt=\"Input and output of the block\"/>
</p>

</html>", revisions="<html>
<ul>
<li>
May 24, 2017, by Milica Grahovac:<br/>
First implementation.
</li>
</ul>
</html>"));
end OnOffHold;
