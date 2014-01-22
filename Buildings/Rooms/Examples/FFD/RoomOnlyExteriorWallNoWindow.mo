within Buildings.Rooms.Examples.FFD;
model RoomOnlyExteriorWallNoWindow
  "Natural convection in an empty room with only exterior walls without windows"
  extends Modelica.Icons.Example;
  extends Buildings.Rooms.Examples.FFD.BaseClasses.PartialRoom(
    nConExt=6,
    nConExtWin=0,
    nConPar=0,
    nConBou=0,
    nSurBou=0,
    roo(nConExt=nConExt, datConExt(
        name={"East Wall","West Wall","North Wall","South Wall","Floor","Ceiling"},
        layers={matLayRoo,matLayRoo,matLayRoo,matLayRoo,matLayRoo,matLayRoo},
        each A=1*1,
        til={Buildings.HeatTransfer.Types.Tilt.Wall,Buildings.HeatTransfer.Types.Tilt.Wall,
            Buildings.HeatTransfer.Types.Tilt.Wall,Buildings.HeatTransfer.Types.Tilt.Wall,
            Buildings.HeatTransfer.Types.Tilt.Floor,Buildings.HeatTransfer.Types.Tilt.Ceiling},
        boundaryCondition={Buildings.Rooms.Types.CFDBoundaryConditions.Temperature,
            Buildings.Rooms.Types.CFDBoundaryConditions.Temperature,Buildings.Rooms.Types.CFDBoundaryConditions.Temperature,
            Buildings.Rooms.Types.CFDBoundaryConditions.Temperature,Buildings.Rooms.Types.CFDBoundaryConditions.Temperature,
            Buildings.Rooms.Types.CFDBoundaryConditions.Temperature})));

  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            200,200}}), graphics),
    __Dymola_Commands(file=
          "modelica://Buildings/Resources/Scripts/Dymola/Rooms/Examples/FFD/RoomOnlyExteriorWallNoWindow.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
This model tests the cosimulation of 
<a href=\"modelica://Buildings.Rooms.FFD\">
Buildings.Rooms.FFD</a>
with the FFD program by simulating the natural convection in an empty room with only exterior walls and without windows.
</p>
</html>", revisions="<html>
<ul>
<li>
August 13, 2013, by Wangda Zuo:<br/>
First implementation.
</li>
</ul>
</html>"));
end RoomOnlyExteriorWallNoWindow;
