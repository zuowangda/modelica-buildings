within Buildings.Rooms.BaseClasses.Examples;
model CFDExchange "Test model for CFDExchange block"
  import Buildings;
  extends Modelica.Icons.Example;

  parameter Integer nWri=6 "Number of values to write";
  Buildings.Rooms.BaseClasses.CFDExchange cfd(
    nWri=nWri,
    uStart=fill(0, nWri),
    nRea=6,
    surIde=surIde,
    samplePeriod=2,
    flaWri={0,1,2,1,1,1},
    haveShade=false,
    haveSensor=true,
    sensorName={"Occupied zone air temperature","Velocity"},
    activateInterface=true,
    verbose=true,
    nC=0,
    cfdFilNam="Resources/Data/Rooms/FFD/FlowPorts.ffd",
    nSur=6,
    portName={"Inlet","Outlet"},
    nXi=1) "Block for data exchange with FFD"
    annotation (Placement(transformation(extent={{0,0},{20,20}})));

  Modelica.Blocks.Sources.Clock u[nWri] "Input to FFD"
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  parameter Buildings.Rooms.BaseClasses.CFDSurfaceIdentifier surIde[nWri](
    name={"East Wall","West Wall","North Wall","South Wall","Floor","Ceiling"},
    A={0.9,0.9,1,1,1,1},
    til={Buildings.HeatTransfer.Types.Tilt.Wall,Buildings.HeatTransfer.Types.Tilt.Wall,
         Buildings.HeatTransfer.Types.Tilt.Wall,Buildings.HeatTransfer.Types.Tilt.Wall,
         Buildings.HeatTransfer.Types.Tilt.Floor,Buildings.HeatTransfer.Types.Tilt.Ceiling},
    each bouCon=Buildings.Rooms.Types.CFDBoundaryConditions.Temperature)
    "Surface identifier"
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
equation
  connect(u.y, cfd.u) annotation (Line(
      points={{-39,10},{-2,10}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics),
    Documentation(info="<html>
<p>
This example tests the FFD exchange block for the configuration where 
the actual exchange with FFD is disabled.
</p>
</html>", revisions="<html>
<ul>
<li>
July 26, 2013, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
    experiment(StopTime=10),
    __Dymola_Commands(file=
          "modelica://Buildings/Resources/Scripts/Dymola/Rooms/BaseClasses/Examples/CFDExchange.mos"
        "Simulate and plot"));
end CFDExchange;
