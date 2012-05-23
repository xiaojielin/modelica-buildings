within Buildings.HeatTransfer.Windows;
model SideFins
  "For a window with side fins, outputs the fraction of the area that is sun exposed"
  import Buildings;
  extends Buildings.HeatTransfer.Windows.BaseClasses.PartialShade_weatherBus;
// Side fin dimensions
  parameter Modelica.SIunits.Length h
    "Side fin height (measured vertically and parallel to wall plane)"
    annotation(Dialog(tab="General",group="Side fin"));
  parameter Modelica.SIunits.Length dep
    "Side fin depth (measured perpendicular to the wall plane)"
    annotation(Dialog(tab="General",group="Side fin"));
  parameter Modelica.SIunits.Length gap
    "Distance between side fin and window edge"
    annotation(Dialog(tab="General",group="Side fin"));

  Buildings.HeatTransfer.Windows.BaseClasses.SideFins fin(
    final dep=dep,
    final h=h,
    final gap=gap,
    final hWin=hWin,
    final wWin=wWin) "Window side fins"
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
equation
  connect(fin.fraSun, fraSun)          annotation (Line(
      points={{21,6.10623e-16},{88.25,6.10623e-16},{88.25,1.16573e-15},{95.5,
          1.16573e-15},{95.5,5.55112e-16},{110,5.55112e-16}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(walSolAzi.verAzi, fin.verAzi)            annotation (Line(
      points={{-39,-50},{-20,-50},{-20,4},{-2,4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(weaBus.sol.alt, fin.alt) annotation (Line(
      points={{-100,5.55112e-16},{-80,5.55112e-16},{-80,-4},{-2,-4}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(fin.fraSun, product.u2) annotation (Line(
      points={{21,6.10623e-16},{40,6.10623e-16},{40,54},{58,54}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(graphics), Icon(graphics={Bitmap(extent={{-92,92},{92,-92}},
            fileName="modelica://Buildings/Resources/Images/HeatTransfer/Windows/BaseClasses/SideFins.png")}),
            defaultComponentName="fin",
            Documentation(info="<html>
<p>
This block calculates the fraction of the total window area that is shaded by side fins.
The side fins are symmetrically placed above the vertical window centerline, 
and its length must be equal or greater than the window height.
This models can also be used for doors with side fins.
The figure below shows the parameters. The parameter <code>ht</code> is measured
from the bottom of the window to the top of the side fins, 
even in cases where the side fins extend below the window.
</p>
<p align=\"center\">
<img src=\"modelica://Buildings/Resources/Images/HeatTransfer/Windows/SideFins.png\" border=\"1\">
</p>
</p>
<h4>Limitations</h4>
<p>
The model assumes that 
<ul>
<li>
the side fins are placed symmetrically to the left and right of the window,
</li>
<li> 
the top of the side fins must be at an equal or greater height than the window, and
</li>
<li>
the bottom of the side fins must be at an equal or lower height than the 
bottom of the window.
</li>
</ul> 
</p>
<h4>Implementation</h4>
<p>
The detailed calculation method is explained in 
<a href=\"modelica://Buildings.HeatTransfer.Windows.BaseClasses.SideFins\">
Buildings.HeatTransfer.Windows.BaseClasses.SideFins</a>.
</p>
</html>",
revisions="<html>
<ul>
<li>
February 25, 2012, by Michael Wetter:<br>
Revised implementation.
</li>
<li>
Feb 01, 2012, by Kaustubh Phalak<br>
First implementation. 
</li>
</ul>
</html>"));
end SideFins;
