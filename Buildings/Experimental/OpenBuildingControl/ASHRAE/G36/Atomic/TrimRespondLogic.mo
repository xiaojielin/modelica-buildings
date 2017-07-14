within Buildings.Experimental.OpenBuildingControl.ASHRAE.G36.Atomic;
block TrimRespondLogic "Block to inplement trim-respond logic"

  parameter Real iniSet  "Initial setpoint";
  parameter Real minSet  "Minimum setpoint";
  parameter Real maxSet  "Maximum setpoint";
  parameter Modelica.SIunits.Time delTim  "Delay time";
  parameter Modelica.SIunits.Time timSte  "Time step";
  parameter Integer numIgnReq  "Number of ignored requests";
  parameter Real triAmo  "Trim amount";
  parameter Real resAmo  "Respond amount (must be opposite in to triAmo";
  parameter Real maxRes  "Maximum response per time interval (same sign as resAmo)";

  CDL.Interfaces.IntegerInput numOfReq "Number of requests from zones/systems"
    annotation (Placement(transformation(extent={{-140,-90},{-100,-50}})));



  CDL.Interfaces.RealOutput y "Setpoint that have been reset"
    annotation (Placement(transformation(extent={{200,-10},{220,10}}),
        iconTransformation(extent={{100,-10},{120,10}})));
  CDL.Interfaces.BooleanInput uDevSta "On/Off status of the associated device"
    annotation (Placement(transformation(extent={{-140,50},{-100,90}})));
  CDL.Continuous.Constant iniSetCon(k=iniSet) "Initial setpoint"
    annotation (Placement(transformation(extent={{0,80},{20,100}})));
  CDL.Logical.Timer tim
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  CDL.Logical.GreaterEqualThreshold delTimCon(threshold=delTim)
    "Reset logic shall be actived in delay time after device start"
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  CDL.Continuous.Constant numIgnReqCon(k=numIgnReq)
    "Number of ignored requests"
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  CDL.Conversions.IntegerToReal intToRea
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  CDL.Continuous.Add difReqIgnReq(k1=-1)
    "Difference between ignored request number and the real request number"
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  CDL.Logical.GreaterThreshold greThr
    "Check if the real requests is more than ignored requests setting"
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  CDL.Continuous.Constant triAmoCon(k=triAmo) "Trim amount constant"
    annotation (Placement(transformation(extent={{-40,-90},{-20,-70}})));
  CDL.Logical.Switch netRes "Net setpoint reset value"
    annotation (Placement(transformation(extent={{120,-60},{140,-40}})));
  CDL.Continuous.Constant resAmoCon(k=resAmo) "Respond amount constant"
    annotation (Placement(transformation(extent={{-40,-120},{-20,-100}})));
  CDL.Continuous.Product pro
    annotation (Placement(transformation(extent={{0,-120},{20,-100}})));
  CDL.Continuous.Constant maxResCon(k=maxRes)
    "Maximum response per time interval"
    annotation (Placement(transformation(extent={{-40,-150},{-20,-130}})));
  CDL.Continuous.Min min
    annotation (Placement(transformation(extent={{40,-120},{60,-100}})));
  CDL.Continuous.Add add2
    annotation (Placement(transformation(extent={{80,-120},{100,-100}})));
  CDL.Continuous.Add add1
    annotation (Placement(transformation(extent={{20,10},{40,30}})));
  CDL.Discrete.UnitDelay uniDel(
    samplePeriod=timSte,
    startTime=timSte,
    y_start=iniSet)
    annotation (Placement(transformation(extent={{-20,10},{0,30}})));
  CDL.Logical.Switch swi
    annotation (Placement(transformation(extent={{100,80},{120,60}})));
  CDL.Continuous.Constant maxSetCon(k=maxSet) "Maximum setpoint constant"
    annotation (Placement(transformation(extent={{20,-20},{40,0}})));
  CDL.Continuous.Min min1
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
equation
  connect(uDevSta, tim.u)
    annotation (Line(points={{-120,70},{-82,70}}, color={255,0,255}));
  connect(tim.y, delTimCon.u)
    annotation (Line(points={{-59,70},{-50.5,70},{-42,70}}, color={0,0,127}));
  connect(numOfReq, intToRea.u) annotation (Line(points={{-120,-70},{-90,-70},{-82,
          -70}}, color={255,127,0}));
  connect(intToRea.y, difReqIgnReq.u2) annotation (Line(points={{-59,-70},{-52,-70},
          {-52,-56},{-42,-56}}, color={0,0,127}));
  connect(numIgnReqCon.y, difReqIgnReq.u1) annotation (Line(points={{-59,-30},{-52,
          -30},{-52,-44},{-42,-44}}, color={0,0,127}));
  connect(difReqIgnReq.y, greThr.u)
    annotation (Line(points={{-19,-50},{-2,-50}}, color={0,0,127}));
  connect(greThr.y, netRes.u2)
    annotation (Line(points={{21,-50},{21,-50},{118,-50}}, color={255,0,255}));
  connect(resAmoCon.y, pro.u2) annotation (Line(points={{-19,-110},{-10,-110},{-10,
          -116},{-2,-116}}, color={0,0,127}));
  connect(difReqIgnReq.y, pro.u1) annotation (Line(points={{-19,-50},{-10,-50},{
          -10,-104},{-2,-104}}, color={0,0,127}));
  connect(pro.y, min.u1) annotation (Line(points={{21,-110},{30,-110},{30,-104},
          {38,-104}}, color={0,0,127}));
  connect(maxResCon.y, min.u2) annotation (Line(points={{-19,-140},{30,-140},{30,
          -116},{38,-116}}, color={0,0,127}));
  connect(min.y, add2.u2) annotation (Line(points={{61,-110},{70,-110},{70,-116},
          {78,-116}}, color={0,0,127}));
  connect(triAmoCon.y, netRes.u3) annotation (Line(points={{-19,-80},{-19,-80},{
          70,-80},{70,-58},{118,-58}}, color={0,0,127}));
  connect(triAmoCon.y, add2.u1) annotation (Line(points={{-19,-80},{70,-80},{70,
          -104},{78,-104}}, color={0,0,127}));
  connect(add2.y, netRes.u1) annotation (Line(points={{101,-110},{108,-110},{108,
          -42},{118,-42}}, color={0,0,127}));
  connect(netRes.y, add1.u2) annotation (Line(points={{141,-50},{160,-50},{160,
          -30},{10,-30},{10,14},{18,14}},
                                     color={0,0,127}));
  connect(delTimCon.y, swi.u2)
    annotation (Line(points={{-19,70},{98,70},{98,70}}, color={255,0,255}));
  connect(iniSetCon.y, swi.u3) annotation (Line(points={{21,90},{50,90},{80,90},
          {80,78},{98,78}}, color={0,0,127}));
  connect(swi.y, y) annotation (Line(points={{121,70},{180,70},{180,0},{210,0}},
        color={0,0,127}));
  connect(maxSetCon.y, min1.u2) annotation (Line(points={{41,-10},{48,-10},{48,
          -6},{58,-6}}, color={0,0,127}));
  connect(add1.y, min1.u1) annotation (Line(points={{41,20},{41,20},{48,20},{48,
          6},{58,6}}, color={0,0,127}));
  connect(min1.y, swi.u1)
    annotation (Line(points={{81,0},{88,0},{88,62},{98,62}}, color={0,0,127}));
  connect(uniDel.y, add1.u1)
    annotation (Line(points={{1,20},{8,20},{8,26},{18,26}}, color={0,0,127}));
  connect(min1.y, uniDel.u) annotation (Line(points={{81,0},{88,0},{88,40},{-40,
          40},{-40,20},{-22,20}}, color={0,0,127}));
  annotation (Icon(graphics={    Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={223,211,169},
        lineThickness=5.0,
        borderPattern=BorderPattern.Raised,
        fillPattern=FillPattern.Solid)}),                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-160},{200,100}})));
end TrimRespondLogic;
