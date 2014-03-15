within Buildings.Rooms.Examples.FFD;
model ForcedConvection "Ventilation with forced convection in an empty room"
  extends Modelica.Icons.Example;
  extends Buildings.Rooms.Examples.FFD.BaseClasses.PartialRoom(
    roo(
      linearizeRadiation=false,
      samplePeriod=60,
      surBou(
        name={"East Wall","West Wall","North Wall","South Wall","Ceiling","Floor"},
        A={0.9,0.9,1,1,1,1},
        til={Buildings.HeatTransfer.Types.Tilt.Wall,
            Buildings.HeatTransfer.Types.Tilt.Wall,
            Buildings.HeatTransfer.Types.Tilt.Wall,
            Buildings.HeatTransfer.Types.Tilt.Wall,
            Buildings.HeatTransfer.Types.Tilt.Ceiling,
            Buildings.HeatTransfer.Types.Tilt.Floor},
        each absIR=1e-5,
        each absSol=1e-5,
        each boundaryCondition= Buildings.Rooms.Types.CFDBoundaryConditions.Temperature),
      nPorts=2,
      portName={"Inlet","Outlet"},
      cfdFilNam="Resources/Data/Rooms/FFD/ForcedConvection.ffd"),
      nSurBou=6);

  HeatTransfer.Sources.FixedTemperature TWal[nSurBou](each T=283.15)
    "Temperature of other walls"
                               annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={110,10})));
  Fluid.Sources.FixedBoundary bouOut(nPorts=1, redeclare package Medium =
        MediumA)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Fluid.Sources.MassFlowSource_T bounIn(
    nPorts=1,
    redeclare package Medium = MediumA,
    m_flow=0.01,
    T=283.15) annotation (Placement(transformation(extent={{0,20},{20,40}})));
equation
  for i in 1:nSurBou loop
    connect(TWal[i].port, roo.surf_surBou[i])    annotation (Line(
      points={{100,10},{62.2,10},{62.2,26}},
      color={191,0,0},
      smooth=Smooth.None));
  end for;

    connect(bounIn.ports[1], roo.ports[1]) annotation (Line(
      points={{20,30},{51,30}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(bouOut.ports[1], roo.ports[2]) annotation (Line(
      points={{20,0},{36,0},{36,30},{51,30}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{200,
            200}}),     graphics),
    __Dymola_Commands(file=
          "modelica://Buildings/Resources/Scripts/Dymola/Rooms/Examples/FFD/ForcedConvection.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
This model tests the co-simulation of 
<a href=\"modelica://Buildings.Rooms.FFD\">
Buildings.Rooms.FFD</a>
with the FFD program by simulating the ventilation with forced convection in an empty room.
The following figure shows streamlines and contour of horizontal velocity U simulated by the FFD. 
</p>
<p align=\"center\">
<img alt=\"image\" src=\"modelica://Buildings/Resources/Images/Rooms/Examples/FFD/ForcedConvection.png\" border=\"1\"/>
</p>
<p align=\"left\">
</html>", revisions="<html>
<ul>
<li>
December 31, 2013, by Wangda Zuo:<br/>
First implementation.
</li>
</ul>
</html>"));
end ForcedConvection;