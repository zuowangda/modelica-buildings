within Buildings.Rooms.Examples.TestConditionalConstructionsFFD;
model RayleighNumber "An ideal flow with Rayleigh number of 10E4"
  extends
    Buildings.Rooms.Examples.TestConditionalConstructionsFFD.OnlySurfaceBoundary(
    TEasWal(T=273.15),
    TWesWal(T=274.15),
    roo(
      cfdFilNam="Resources/Data/Rooms/FFD/RayleighNumber.ffd",
      T_start=273.15),
    system(T_ambient=273.15));

  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            200,200}}), graphics),
    __Dymola_Commands(file=
          "modelica://Buildings/Resources/Scripts/Dymola/Rooms/Examples/TestConditionalConstructionsFFD/RayleighNumber.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
This model tests the cosimulation of 
<a href=\"modelica://Buildings.Rooms.FFD\">
Buildings.Rooms.FFD</a>
with the FFD program by simulating the natural convection in a room with only surface boundaries.
</p>
<p>
To get a Rayleigh number of 1E4, the flow properties are mannually set.

The boundary conditions in this model are:
<li>
East wall: Fixed temperature at 0 degC, 
</li>
<li>
West wall: Fixed temperature at 1 degC,
</li>
<li>
North & South wall, Ceiling, Floor: Fixed heat flux at 0 W/m2.
</li>
<p>
More details of the case description can be found in 
<a href=\"#ZUOEtAl2011\">Zuo et al. (2011)</a>.
</p>
</p>
</html>", revisions="<html>
<ul>

<li>
August 13, 2013, by Wangda Zuo:<br/>
First implementation.
</li>
</ul>
<h4>References</h4>
<p>
<a NAME=\"ZuoEtAl2011\"/> 
Wangda Zuo, Mingang Jin, Qingyan Chen<br/>
<a href=\"modelica://Buildings/Resources/Images/Rooms/Examples/TestConditionalConstructionFFD/2011-Zuo-EACFD.pdf\">
Reduction of numerical viscosity in FFD model.</a><br/>
Journal of Engineering Applications of Computational Fluid Mechanics, 6(2), p. 234-247. 
</p>
</html>"));
end RayleighNumber;
