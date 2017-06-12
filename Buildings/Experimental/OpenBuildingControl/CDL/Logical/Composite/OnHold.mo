within Buildings.Experimental.OpenBuildingControl.CDL.Logical.Composite;
block OnHold "Block that holds a signal on for a requested time period"

  parameter Modelica.SIunits.Time holdDuration "Time duration of the ON hold.";

  Interfaces.BooleanInput u "Boolean input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
        iconTransformation(extent={{-120,-10},{-100,10}})));
  Interfaces.BooleanOutput y "Boolean output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}}),
        iconTransformation(extent={{100,-10},{120,10}})));

  Logical.LessThreshold les1(final threshold=holdDuration) "Less than threshold"
    annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  Continuous.Constant Zero(final k=0) "Constant equals zero"
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  Logical.Timer timer "Timer to measure time elapsed after the output signal rising edge"
    annotation (Placement(transformation(extent={{20,10},{40,30}})));
  Logical.Pre pre "Introduces infinitesimally small time delay"
    annotation (Placement(transformation(extent={{50,40},{70,60}})));
  Logical.Not not1 "Not block"
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Logical.Or or2 "Or block" annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  Logical.And and2 "And block" annotation (Placement(transformation(extent={{20,40},{40,60}})));

  GreaterEqual greEqu
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  LessEqual lesEqu
    annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
  And and1 annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
equation
  connect(timer.u,pre. y) annotation (Line(points={{18,20},{14,20},{14,0},{80,0},
          {80,50},{71,50}},
                      color={255,0,255}));
  connect(u, or2.u1) annotation (Line(points={{-120,0},{-90,0},{-90,70},{-22,70}},
        color={255,0,255}));
  connect(les1.y, and2.u2) annotation (Line(points={{1,10},{10,10},{10,42},{18,
          42}},      color={255,0,255}));
  connect(and2.y, pre.u) annotation (Line(points={{41,50},{48,50}},
                 color={255,0,255}));
  connect(or2.y, y) annotation (Line(points={{1,70},{1,70},{90,70},{90,0},{110,0}},
        color={255,0,255}));
  connect(timer.y, les1.u) annotation (Line(points={{41,20},{60,20},{60,-12},{
          -30,-12},{-30,10},{-22,10}},        color={0,0,127}));
  connect(or2.y, and2.u1) annotation (Line(points={{1,70},{10,70},{10,50},{18,50}},
        color={255,0,255}));
  connect(not1.y, or2.u2) annotation (Line(points={{-39,30},{-30,30},{-30,62},{
          -22,62}},
                color={255,0,255}));
  connect(Zero.y, greEqu.u1)
    annotation (Line(points={{-79,-50},{-42,-50}}, color={0,0,127}));
  connect(Zero.y, lesEqu.u1) annotation (Line(points={{-79,-50},{-60,-50},{-60,
          -90},{-42,-90}}, color={0,0,127}));
  connect(timer.y, greEqu.u2) annotation (Line(points={{41,20},{60,20},{60,-12},
          {-52,-12},{-52,-58},{-42,-58}}, color={0,0,127}));
  connect(timer.y, lesEqu.u2) annotation (Line(points={{41,20},{60,20},{60,-12},
          {-52,-12},{-52,-98},{-42,-98}}, color={0,0,127}));
  connect(lesEqu.y, and1.u2) annotation (Line(points={{-19,-90},{-12,-90},{-12,
          -78},{-2,-78}}, color={255,0,255}));
  connect(greEqu.y, and1.u1) annotation (Line(points={{-19,-50},{-12,-50},{-12,
          -70},{-2,-70}}, color={255,0,255}));
  connect(and1.y, not1.u) annotation (Line(points={{21,-70},{40,-70},{40,-20},{
          -72,-20},{-72,30},{-62,30}}, color={255,0,255}));
  annotation (Icon(graphics={    Rectangle(
          extent={{-100,100},{100,-100}},
          fillColor={210,210,210},
          lineThickness=5.0,
          fillPattern=FillPattern.Solid,
          borderPattern=BorderPattern.Raised),
          Line(points={{-72,18},{-48,18},{-48,62},{52,62},{52,18},{80,18}},
              color={255,0,255}),
          Line(points={{-68,-46},{-48,-46},{-48,-2},{22,-2},{22,-46},{78,-46}}),
        Text(
          extent={{-150,150},{150,110}},
          textString="%name",
          lineColor={0,0,255}),
        Text(
          extent={{-90,-62},{96,-90}},
          lineColor={0,0,255},
          textString="%holdDuration")}),                         Diagram(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
              Documentation(info="<html>
<p>
Block that holds a true signal for a defined time period.
</p>
<p>
A rising edge of the Boolean input <code>u</code> starts a timer and
the Boolean output <code>y</code> stays <code>true</code> for the time
period provided as a parameter. After that the block evaluates the Boolean
input <code>u</code> and if the input is <code>true</code>,
the timer gets started again, but if the input is <code>false</code>, the output becomes
<code>false</code>. If the output value is <code>false</code>, it will become
<code>true</code> with the first rising edge of the inputs signal. In other words,
any <code>true</code> signal is evaluated either at the rising edge time of the input or at
the rising edge time plus the time period. The output can only be <code>false</code>
if at the end of the time period the input is <code>false</code>.
</p>
<p>
Simulation results of a typical example with a hold time of 1 hour
is shown in the next figure.
</p>

<p align=\"center\">
<img src=\"modelica://Buildings/Resources/Images/Experimental/OpenBuildingControl/CDL/Logical/Composite/OnHold.png\"
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
end OnHold;
