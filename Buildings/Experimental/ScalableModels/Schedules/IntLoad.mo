within Buildings.Experimental.ScalableModels.Schedules;
model IntLoad "Schedule for time varying internal loads"
  extends Modelica.Blocks.Sources.CombiTimeTable(
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    table=[0,0.1; 8*3600,1.0; 18*3600,0.1; 24*3600,0.1],
    columns={2});
end IntLoad;