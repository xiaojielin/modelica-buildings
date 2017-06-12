within Buildings.Experimental.OpenBuildingControl.CDL.Logical.Validation;
model Toggle "Validation model for the Toggle block"
extends Modelica.Icons.Example;

  Buildings.Experimental.OpenBuildingControl.CDL.Sources.BooleanPulse booPul1(
    width = 0.5,
    period = 1.5)
    "Block that outputs cyclic on and off"
    annotation (Placement(transformation(extent={{-26,6},{-6,26}})));

  Buildings.Experimental.OpenBuildingControl.CDL.Sources.BooleanPulse booPul2(
     width = 0.5,
     period = 5)
     "Block that outputs cyclic on and off"
     annotation (Placement(transformation(extent={{-26,-28},{-6,-8}})));
  Buildings.Experimental.OpenBuildingControl.CDL.Logical.Toggle toggle1
    annotation (Placement(transformation(extent={{26,-10},{46,10}})));

equation
  connect(booPul1.y, toggle1.u) annotation (Line(points={{-5,16},{10,16},{10,0},
          {25,0}}, color={255,0,255}));
  connect(booPul2.y, toggle1.u0) annotation (Line(points={{-5,-18},{10,-18},{10,
          -6},{25,-6}},  color={255,0,255}));
  annotation (
  experiment(StopTime=10.0, Tolerance=1e-06),
  __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Experimental/OpenBuildingControl/CDL/Logical/Validation/Toggle.mos"
          "Simulate and plot"),
    Documentation(info="<html>
<p>
Validation test for the block
<a href=\"modelica://Buildings.Experimental.OpenBuildingControl.CDL.Logical.Toggle\">
Buildings.Experimental.OpenBuildingControl.CDL.Logical.Toggle</a>.
</p>
<p>
The <code>latch</code> input <code>u</code> cycles from OFF to ON, with cycle period of <code>1.5 s</code> and <code>50%</code> ON time.
The <code>clr</code> input <code>u0</code> cycles from OFF to ON, with cycle period of <code>5 s</code> and <code>50%</code> ON time.
</p>
</html>", revisions="<html>
<ul>
<li>
March 31, 2017, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"));
end Toggle;
