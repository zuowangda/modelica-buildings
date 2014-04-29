within Buildings.Rooms.Examples.FFD;
model NaturalConvection
  "An ideal natural convection flow with Rayleigh number of 1E5"
  extends Buildings.Rooms.Examples.FFD.RoomOnlySurfaceBoundary(
    TEasWal(T=273.15),
    TWesWal(T=274.15),
    roo(cfdFilNam="Resources/Data/Rooms/FFD/NaturalConvection.ffd", T_start=273.15),
    system(T_ambient=273.15));

  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            200,200}}), graphics),
    __Dymola_Commands(file=
          "modelica://Buildings/Resources/Scripts/Dymola/Rooms/Examples/FFD/NaturalConvection.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
This model tests the cosimulation of 
<a href=\"modelica://Buildings.Rooms.CFD\">
Buildings.Rooms.CFD</a>
with the FFD program by simulating the natural convection in an empty room with only surface boundaries.
</p>
<p>
The Rayleigh number is a dimensionless number associated with natural convection, defined as 
<p align=\"center\" style=\"font-style:italic;\">
  R<sub>a</sub> = g &beta; (T<sub>w</sub>-T<sub>e</sub>)L<sup>3</sup> &frasl; (&nu; &alpha;)
</p>

To get a Rayleigh number of 1E5, the flow properties are mannually set as
acceleration due to gravity <i>g<sub>z</sub>=-0.01</i> m/s2, 
thermal expansion coefficient <i>&beta;=3e-3</i> 1/K, 
kinematic viscosity <i>&nu;=1.5e-5</i> m2/s, 
thermal diffusivity <i>&alpha;=2e-5</i> m2/s,
characteristic length <i>L=1</i> m. 

The boundary conditions are:
<ul>
<li>
East wall: Fixed temperature at <i>T<sub>e</sub>=0</i> degC, 
</li>
<li>
West wall: Fixed temperature at <i>T<sub>w</sub>=1</i> degC,
</li>
<li>
North & South wall, Ceiling, Floor: Fixed heat flux at 0 W/m2.
</li>
</ul>
<p align=\"center\">
<img alt=\"image\" src=\"modelica://Buildings/Resources/Images/Rooms/Examples/FFD/NaturalConvection.png\" border=\"1\"/>
</p>
<p align=\"left\">
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
<a href=\"modelica://Buildings/Resources/Images/Rooms/Examples/FFD/2011-Zuo-EACFD.pdf\">
Reduction of numerical viscosity in FFD model.</a><br/>
Journal of Engineering Applications of Computational Fluid Mechanics, 6(2), p. 234-247. 
</p>
</html>"));
end NaturalConvection;
