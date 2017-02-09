within Buildings.ThermalZones.Detailed.BaseClasses;
function detectOperatingSystem
  "Detect the operating system and return 0 for Windows 64, 
  1 for Windows 32, 2 for Linux 64, and 3 for Linux32"
  output Integer retVal "Return value of the function";
  external "C";
  annotation (Include=
        "#include <detectOperatingSystem.c>", IncludeDirectory=
        "modelica://Buildings/Resources/C-Sources");

end detectOperatingSystem;
