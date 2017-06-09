within Buildings.Fluid.Air.BaseClasses.Examples;
model ReheatControl "Test model for reheater controller with hysteresis"
  extends Modelica.Icons.Example;
  Buildings.Fluid.Air.BaseClasses.ReheatControl heaCon(
    y1Low=0,
    y1Hig=0.05,
    y2Low=-0.5,
    y2Hig=0.5) "Heater on/off controller"
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Blocks.Sources.Sine sig1(
    freqHz=1/100,
    amplitude=0.3,
    offset=0.3) "Signal 1"
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Modelica.Blocks.Sources.Sine sig2(
    freqHz=1/100,
    amplitude=3,
    offset=273.15 + 15,
    phase=1.0471975511966) "Signal 2"
    annotation (Placement(transformation(extent={{-80,-38},{-60,-18}})));
  Modelica.Blocks.Sources.Constant set1(k=0.2) "Set point for signal 1"
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  Modelica.Blocks.Sources.Constant set2(k=273.15 + 16) "Set point for signal 2"
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  Modelica.Blocks.Math.Add add1(k1=+1, k2=-1)
    "Error between signal 1 and setpoint 1"
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Modelica.Blocks.Math.Add add2(k1=+1, k2=-1)
    "Error between signal 2 and setpoint 2"
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
equation
  connect(sig1.y, add1.u1) annotation (Line(points={{-59,50},{-52,50},{-52,36},{
          -22,36}}, color={0,0,127}));
  connect(set1.y, add1.u2) annotation (Line(points={{-59,10},{-52,10},{-52,24},{
          -22,24}}, color={0,0,127}));
  connect(add1.y, heaCon.y1)
    annotation (Line(points={{1,30},{20,30},{20,5},{38,5}}, color={0,0,127}));
  connect(sig2.y, add2.u1) annotation (Line(points={{-59,-28},{-52,-28},{-52,-44},
          {-22,-44}}, color={0,0,127}));
  connect(set2.y, add2.u2) annotation (Line(points={{-59,-70},{-52,-70},{-52,-56},
          {-22,-56}}, color={0,0,127}));
  connect(add2.y, heaCon.y2) annotation (Line(points={{1,-50},{20,-50},{20,-5},{
          38,-5}}, color={0,0,127}));
  annotation (experiment(Tolerance=1e-6, StopTime=100),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Fluid/Air/BaseClasses/Examples/ReheatControl.mos"
        "Simulate and Plot"),
    Documentation(info="<html>
<p>This example tests the reheater controller with two varing input error signals.</p>
</html>", revisions="<html>
<ul>
<li>
May 12, 2017 by Yangyang Fu:<br/>
First implementation.
</li>
</ul>
</html>"));
end ReheatControl;