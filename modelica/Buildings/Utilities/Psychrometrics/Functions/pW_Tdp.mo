within Buildings.Utilities.Psychrometrics.Functions;
function pW_Tdp
  "Function to compute the water vapor partial pressure for a given dew point temperature of moist air"

  input Modelica.SIunits.Temperature T "Dew point temperature";
  output Modelica.SIunits.Pressure p_w "Water vapor partial pressure";
protected
  constant Real C8=-5.800226E3;
  constant Real C9=1.3914993E0;
  constant Real C10=-4.8640239E-2;
  constant Real C11=4.1764768E-5;
  constant Real C12=-1.4452093E-8;
  constant Real C13=6.5459673E0;

algorithm
  p_w := Modelica.Math.exp(C8/T + C9 + T*(C10 + T*(C11 + T*C12)) + C13*
    Modelica.Math.log(T));
  annotation (
    Documentation(info="<html>
<p>
Dew point temperature calculation for moist air above freezing temperature.
</p>
<p>
The correlation used in this model is valid for dew point temperatures between 
<tt>0 degC</tt> and <tt>200 degC</tt>. It is the correlation from 2005
ASHRAE Handbook, p. 6.2. In an earlier version of this model, the equation from
Peppers has been used, but this equation yielded about 15 Kelvin lower dew point 
temperatures.
</p>
</html>", revisions="<html>
<ul>
<li>
February 17, 2010 by Michael Wetter:<br>
Renamed function from <code>dewPointTemperature</code> to <code>pW_Tdp</code>.
</li>
<li>
February 6, 2010 by Michael Wetter:<br>
Fixed derivative implementation.
</li>
<li>
September 4, 2008 by Michael Wetter:<br>
Changed from causal to acausal ports, needed, for example, for
<a href=\"modelica://Buildings.Fluid.Examples.MixingVolumeMoistAir\">
Buildings.Fluid.Examples.MixingVolumeMoistAir</a>.
</li>
<li>
August 7, 2008 by Michael Wetter:<br>
First implementation.
</li>
</ul>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}), graphics),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics),
    smoothOrder=1,
    derivative=BaseClasses.der_pW_Tdp);
end pW_Tdp;