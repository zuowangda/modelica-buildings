within Buildings.Rooms.Examples.TestConditionalConstructionsFFD;
model OnlyInteriorWall
  "Buoyancy force driven natural convection in a room with only interior walls"
  extends Modelica.Icons.Example;
  extends
    Buildings.Rooms.Examples.TestConditionalConstructionsFFD.BaseClasses.PartialOnlyInteriorWall;

  Buildings.HeatTransfer.Sources.FixedTemperature TWesWal(each T=283.15)
    "Boundary condition for the west wall" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={110,-30})));

  HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow[nConBou - 2](each Q_flow=0)
    annotation (Placement(transformation(extent={{6,-24},{26,-4}})));
equation
  for i in 1:nConBou - 2 loop
    connect(fixedHeatFlow[i].port, roo.surf_conBou[i + 2]) annotation (Line(
        points={{26,-14},{72,-14},{72,24}},
        color={191,0,0},
        smooth=Smooth.None));
  end for;

  connect(TWesWal.port, roo.surf_conBou[2]) annotation (Line(
      points={{100,-30},{72,-30},{72,24}},
      color={191,0,0},
      smooth=Smooth.None));

  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            200,200}}), graphics),
    __Dymola_Commands(file=
          "modelica://Buildings/Resources/Scripts/Dymola/Rooms/Examples/TestConditionalConstructionsFFD/OnlyInteriorWall.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
This model tests the cosimulation of 
<a href=\"modelica://Buildings.Rooms.FFD\">
Buildings.Rooms.FFD</a>
with the FFD program by simulating the natural convection in a room with only interior walls.
</p>
<p>
The difference between this model and the <a href=\"modelica://Buildings.Rooms.Examples.TestConditionalConstructionsFFD.OnlyInteriorWallOnlyTemperature\">
Buildings.Rooms.Examples.TestConditionalConstructionsFFD.OnlyInteriorWallOnlyTemperature</a> is the boundary conditions.
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
</p>
</html>", revisions="<html>
<ul>
<li>
August 13, 2013, by Wangda Zuo:<br/>
First implementation.
</li>
</ul>
</html>"));
end OnlyInteriorWall;
