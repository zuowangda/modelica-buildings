within Buildings.BoundaryConditions.WeatherData;
expandable connector Bus "Data bus that stores weather data"
  extends Modelica.Icons.SignalBus;

  annotation (
    defaultComponentName="weaBus",
    Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics={Rectangle(
          extent={{-20,2},{22,-2}},
          lineColor={255,204,51},
          lineThickness=0.5)}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}}), graphics),
    Documentation(info="<HTML>
<p>
This component is a bus that contains the weather data.
</p>
</HTML>
", revisions="<html>
<ul>
<li>
June 25, 2010, by Wangda Zuo:<br>
First implementation.
</li>
</ul>
</html>"));
end Bus;