within Buildings.Experimental.OpenBuildingControl.ASHRAE.G36.Atomic.Validation;
model TrimRespond
  extends Modelica.Icons.Example;
  TrimRespondLogic trimRespondLogic(
    iniSet=120,
    minSet=37,
    maxSet=370,
    delTim=300,
    timSte=120,
    numIgnReq=2,
    triAmo=-10,
    resAmo=15,
    maxRes=37) annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  CDL.Logical.Constant con(k=true)
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Blocks.Sources.Sine sine(freqHz=1/1800, amplitude=6)
    annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
  CDL.Continuous.Abs abs
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  CDL.Continuous.Truncation tru
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
equation
  connect(con.y, trimRespondLogic.uDevSta) annotation (Line(points={{-19,10},{6,
          10},{6,7},{38,7}}, color={255,0,255}));
  connect(sine.y, abs.u)
    annotation (Line(points={{-79,-20},{-62,-20},{-62,-20}}, color={0,0,127}));
  connect(abs.y, tru.u)
    annotation (Line(points={{-39,-20},{-22,-20},{-22,-20}}, color={0,0,127}));
  connect(tru.y, trimRespondLogic.numOfReq) annotation (Line(points={{1,-20},{
          16,-20},{16,-7},{38,-7}}, color={255,127,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TrimRespond;
