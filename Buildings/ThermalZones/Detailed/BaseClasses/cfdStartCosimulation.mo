within Buildings.ThermalZones.Detailed.BaseClasses;
function cfdStartCosimulation "Start the coupled simulation with CFD"
  input String cfdFilNam "CFD input file name";
  input String[nSur] name "Surface names";
  input Modelica.SIunits.Area[nSur] A "Surface areas";
  input Modelica.SIunits.Angle[nSur] til "Surface tilt";
  input Buildings.ThermalZones.Detailed.Types.CFDBoundaryConditions[nSur] bouCon
    "Type of boundary condition";
  input Integer nPorts(min=0)
    "Number of fluid ports for the HVAC inlet and outlets";
  input String portName[nPorts]
    "Names of fluid ports as declared in the CFD input file";
  input Boolean haveSensor "Flag, true if the model has at least one sensor";
  input String sensorName[nSen]
    "Names of sensors as declared in the CFD input file";
  input Boolean haveShade "Flag, true if the windows have a shade";
  input Integer nSur "Number of surfaces";
  input Integer nSen(min=0)
    "Number of sensors that are connected to CFD output";
  input Integer nConExtWin(min=0) "number of exterior construction with window";
  input Integer nXi(min=0) "Number of independent species";
  input Integer nC(min=0) "Number of trace substances";
  input Modelica.SIunits.Density rho_start "Density at initial state";
  input String libPat "Path to the FFD libraries";
  output Integer retVal
    "Return value of the function (0 indicates CFD successfully started.)";
external"C" retVal = cfdStartCosimulation(
    cfdFilNam,
    name,
    A,
    til,
    bouCon,
    nPorts,
    portName,
    haveSensor,
    sensorName,
    haveShade,
    nSur,
    nSen,
    nConExtWin,
    nXi,
    nC,
    rho_start,
    libPat) annotation (Include="#include <cfdStartCosimulation.c>",
      IncludeDirectory="modelica://Buildings/Resources/C-Sources");

  annotation (Documentation(info="<html>
<p>
This function calls a C function to start the coupled simulation with CFD.
</p>
</html>",
        revisions="<html>
<ul>
<li>
February 08, 2017, by Thierry S. Nouidui:<br/>
Added the path to the FFD libraries to address a JModelica simulation error
which occurs when JModelica tries to import the FFD libraries.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/612\">issue 612</a>.
</li>
<li>
August 16, 2013, by Wangda Zuo:<br/>
First implementation.
</li>
</ul>
</html>"));

end cfdStartCosimulation;
