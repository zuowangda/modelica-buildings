within Buildings.Rooms.Examples.FFD;
model RoomFlowPorts "Mixed convection in an empty room with inlet and outlet"
  extends Modelica.Icons.Example;
  extends Buildings.Rooms.Examples.FFD.BaseClasses.PartialRoom(roo(
      linearizeRadiation=false,
      samplePeriod=60,
      surBou(
        name={"East Wall","West Wall","North Wall","South Wall","Floor","Ceiling"},
        A={0.9,0.9,1,1,1,1},
        til={Buildings.HeatTransfer.Types.Tilt.Wall,Buildings.HeatTransfer.Types.Tilt.Wall,
            Buildings.HeatTransfer.Types.Tilt.Wall,Buildings.HeatTransfer.Types.Tilt.Wall,
            Buildings.HeatTransfer.Types.Tilt.Floor,Buildings.HeatTransfer.Types.Tilt.Ceiling},
        each absIR=1e-5,
        each absSol=1e-5,
        boundaryCondition={Buildings.Rooms.Types.CFDBoundaryConditions.Temperature,
            Buildings.Rooms.Types.CFDBoundaryConditions.Temperature,Buildings.Rooms.Types.CFDBoundaryConditions.HeatFlowRate,
            Buildings.Rooms.Types.CFDBoundaryConditions.HeatFlowRate,
            Buildings.Rooms.Types.CFDBoundaryConditions.HeatFlowRate,
            Buildings.Rooms.Types.CFDBoundaryConditions.HeatFlowRate}),
      nPorts=2,
      portName={"Inlet","Outlet"},
      cfdFilNam="C:/Users/Wangda/Documents/FFD-Modelica/modelica/modelica-buildings/Buildings/Resources/Data/Rooms/FFD/FlowPorts.ffd"),
      nSurBou=6);

  Buildings.HeatTransfer.Sources.FixedTemperature TWesWal(each T=303.15)
    "Boundary condition for the west wall" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={110,-30})));

  HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow[nSurBou - 2](each Q_flow=0)
    annotation (Placement(transformation(extent={{28,-24},{48,-4}})));
  HeatTransfer.Sources.FixedTemperature TEasWal(each T=303.15)
    "Temperature of east wall" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={110,10})));
  Fluid.Sources.FixedBoundary bouOut(nPorts=1, redeclare package Medium =
        MediumA)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Fluid.Sources.MassFlowSource_T bounIn(
    nPorts=1,
    redeclare package Medium = MediumA,
    T=283.15) annotation (Placement(transformation(extent={{0,20},{20,40}})));
equation
  for i in 1:nSurBou - 2 loop
    connect(fixedHeatFlow[i].port, roo.surf_surBou[i + 2]) annotation (Line(
        points={{48,-14},{62.2,-14},{62.2,26}},
        color={191,0,0},
        smooth=Smooth.None));
  end for;

  connect(TEasWal.port, roo.surf_surBou[1]) annotation (Line(
      points={{100,10},{62.2,10},{62.2,26}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(TWesWal.port, roo.surf_surBou[2]) annotation (Line(
      points={{100,-30},{62.2,-30},{62.2,26}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(bounIn.ports[1], roo.ports[1]) annotation (Line(
      points={{20,30},{51,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(bouOut.ports[1], roo.ports[2]) annotation (Line(
      points={{20,0},{36,0},{36,30},{51,30}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            200,200}}), graphics),
    __Dymola_Commands(file=
          "modelica://Buildings/Resources/Scripts/Dymola/Rooms/Examples/FFD/RoomFlowPorts.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
This model tests the cosimulation of 
<a href=\"modelica://Buildings.Rooms.FFD\">
Buildings.Rooms.FFD</a>
with the FFD program by simulating the mixed convection in an empty room with fluid ports.
</p>
<p>
The boundary conditions in this model are:
<li>
East wall: Fixed temperature at 40 degC, 
</li>
<li>
West wall: Fixed temperature at 10 degC,
</li>
<li>
North & South wall, Ceiling, Floor: Fixed heat flux at 0 W/m2. 
</li>
<li>

</p>
</html>", revisions="<html>
<ul>
<li>
December 31, 2013, by Wangda Zuo:<br/>
First implementation.
</li>
</ul>
</html>"));
end RoomFlowPorts;
