within Buildings.Rooms.Examples;
package FFD "Package that tests the models for coupled simulation between Modelica and the Fast Fluid Dynamics"
  extends Modelica.Icons.ExamplesPackage;


annotation (Documentation(info="<html>
<p>
The coupled simulation of model
<a href=\"Buildings.Rooms.CFD\">Buildings.Rooms.CFD</a> with the Fast Fluid Dynamics program is tested in this package.
Different cases with various boundary conditions are evaluated. 
The models in this package do not represent realistic buildings, but
are rather designed to test the coupled simulation.
</p>
<p>
The source code of the FFD program is located at Resources/src/FastFluidDynamics.
To compile the code, 
</p>
<p>
To run the coupled simulation with FFD, the following files are needed that are given in the library:
<ul>
<li>
dynamicaly linked library files located at Resources/bin/: 
<ul>
<li>
Windows OS: FFD-DLL.dll and FFD-DLL.lib
</li>
<li>
Linux OS: FFD-DLL.so
</li>
</ul>
</li>
<li>
FFD input file for simulation parameter *.ffd located at Resources/Data/Rooms/FFD/
</li>
<li>
Geometry files *.cfd (mesh file) and *.dat (property of obstacles) genearted by SCI_FFD.
</li>
</ul>
</p> 
</html>", revisions="<html>
<ul>
<li>
January 21, 2014, by Wangda Zuo:<br/>
First implementation.
</li>
</ul>
</html>"));
end FFD;
