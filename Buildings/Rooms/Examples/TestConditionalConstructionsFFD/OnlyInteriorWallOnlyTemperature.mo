within Buildings.Rooms.Examples.TestConditionalConstructionsFFD;
model OnlyInteriorWallOnlyTemperature
  "Buoyancy force driven natural convection in a room with only interior walls and only temperature B.C."
  extends Modelica.Icons.Example;
  extends
    Buildings.Rooms.Examples.TestConditionalConstructionsFFD.BaseClasses.PartialOnlyInteriorWall;

  Buildings.HeatTransfer.Sources.FixedTemperature TWalRes[nConBou - 1](each T=
        283.15) "Boundary condition for the rest of walls" annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={110,-30})));

equation
  for i in 1:nConBou - 1 loop
    connect(TWalRes[i].port, roo.surf_conBou[i + 1]) annotation (Line(
        points={{100,-30},{72,-30},{72,24}},
        color={191,0,0},
        smooth=Smooth.None));

  end for;

  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            200,200}}), graphics),
    __Dymola_Commands(file=
          "modelica://Buildings/Resources/Scripts/Dymola/Rooms/Examples/TestConditionalConstructionsFFD/OnlyInteriorWallOnlyTemperature.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
This model tests the cosimulation of 
<a href=\"modelica://Buildings.Rooms.FFD\">
Buildings.Rooms.FFD</a>
with the FFD program by simulating the natural convection in a room with only interior walls and only temperature b.c. defined in Modelica.
</p>
<p>
The dimensions of the room are 1m x 1m x 1m.
The temperature of the east wall is set to 40 degC and the rest walls are 10 degC.
The initial temperature of room air is 10 degC and it will increase due to the warm wall on the east.
Two sensors are placed in the room center (0.5m, 0.5m, 0.5m) that measure the temperature and the velocity.
</p>
</html>", revisions="<html>
<ul>
<li>
August 13, 2013, by Wangda Zuo:<br/>
First implementation.
</li>
</ul>
</html>"));
end OnlyInteriorWallOnlyTemperature;
