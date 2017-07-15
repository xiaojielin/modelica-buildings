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
    maxRes=37) annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
  CDL.Logical.Constant con(k=true)
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  Modelica.Blocks.Sources.Sine sine(freqHz=1/1800, amplitude=6)
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  CDL.Continuous.Abs abs
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  CDL.Continuous.Truncation tru
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  TrimRespondLogic trimRespondLogic1(
    iniSet=120,
    minSet=37,
    maxSet=370,
    delTim=300,
    timSte=120,
    numIgnReq=2,
    triAmo=-10,
    resAmo=15,
    maxRes=37) annotation (Placement(transformation(extent={{40,40},{60,60}})));
  Modelica.Blocks.Sources.Sine sine1(
                                    freqHz=1/1800, amplitude=6)
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  CDL.Continuous.Abs abs1
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  CDL.Continuous.Truncation tru1
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  CDL.Sources.BooleanPulse booPul(period=3600, width=0.18333333)
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
equation
  connect(con.y, trimRespondLogic.uDevSta) annotation (Line(points={{-19,-10},{
          20,-10},{20,-23},{38,-23}},
                             color={255,0,255}));
  connect(sine.y, abs.u)
    annotation (Line(points={{-79,-50},{-62,-50}},           color={0,0,127}));
  connect(abs.y, tru.u)
    annotation (Line(points={{-39,-50},{-22,-50}},           color={0,0,127}));
  connect(tru.y, trimRespondLogic.numOfReq) annotation (Line(points={{1,-50},{
          20,-50},{20,-37},{38,-37}},
                                    color={255,127,0}));
  connect(sine1.y, abs1.u)
    annotation (Line(points={{-79,30},{-62,30}}, color={0,0,127}));
  connect(abs1.y, tru1.u)
    annotation (Line(points={{-39,30},{-22,30}}, color={0,0,127}));
  connect(tru1.y, trimRespondLogic1.numOfReq) annotation (Line(points={{1,30},{
          20,30},{20,43},{38,43}}, color={255,127,0}));
  connect(booPul.y, not1.u)
    annotation (Line(points={{-59,70},{-22,70}}, color={255,0,255}));
  connect(not1.y, trimRespondLogic1.uDevSta) annotation (Line(points={{1,70},{
          20,70},{20,57},{38,57}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TrimRespond;
