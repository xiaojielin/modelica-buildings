within Buildings.Electrical.Transmission.LowVoltageCables;
record PvcAl70_ECM "Aluminum cable 70mm^2"
    extends Buildings.Electrical.Transmission.LowVoltageCables.Generic(
    material=Types.Material.Al,
    RCha=0.488e-003,
    XCha=0.072e-003);
  annotation (Documentation(info="<html>
<p>
Aluminium cable with a cross-sectional area of 70mm^2, ECM type.
This type of cable has the following properties
</p>
<pre>
RCha = 0.488e-003 // Characteristic resistance [Ohm/m] 
XCha = 0.072e-003 // Characteristic reactance [Ohm/m] 
</pre>
</html>", revisions="<html>
<ul>
<li>
Sept 19, 2014, by Marco Bonvini:<br/>
Added User's guide.
</li>
</ul>
</html>"));
end PvcAl70_ECM;
