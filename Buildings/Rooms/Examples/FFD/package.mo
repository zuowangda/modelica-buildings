within Buildings.Rooms.Examples;
package FFD "Package that tests the models for cosimulation with CFD"
  extends Modelica.Icons.ExamplesPackage;


annotation (Documentation(info="<html>
The thermal zone model 
<a href=\"Buildings.Rooms.FFD\">Buildings.Rooms.FFD</a>
allows the conditional declaration of constructions for
exterior walls without windows, for exterior walls with windows,
for partition walls, for interior surfaces,
and for interior surfaces.
The models in this package test if the model is well-defined
if such constructions are removed.
The models in this package do not represent realistic buildings, but
are rather designed to test the thermal zone model.
</html>", revisions="<html>
<ul>
<li>
January 21, 2014, by Wangda Zuo:<br/>
First implementation.
</li>
</ul>
</html>"));
end FFD;
