within Buildings.Fluid.Sensors.Examples;
model WetBulbTemperature
  import Buildings;

    annotation (Diagram(coordinateSystem(preserveAspectRatio=true,  extent={{-100,
            -100},{100,100}}),
                        graphics),
                         Commands(file=
            "WetBulbTemperature.mos" "run"),
    Documentation(info="<html>
This examples is a unit test for the wet bulb sensor.
The problem setup is such that the moisture concentration and
the dry bulb temperature are varied simultaneously in such a way
that the wet bulb temperature is constant.
This wet bulb temperature is checked against a constant value with
an assert statement.
In case this assert is triggered, then either the wet bulb sensor or
the medium model got broken (assuming that the inputs remained unchanged).
</html>", revisions="<html>
<ul>
<li>
May 6, 2008 by Michael Wetter:<br>
First implementation.
</li>
</ul>
</html>"));

 package Medium = Buildings.Media.PerfectGases.MoistAir "Medium model" 
           annotation (choicesAllMatching = true);

    Modelica.Blocks.Sources.Ramp p(
    duration=1,
    offset=101325,
    height=250)  annotation (Placement(transformation(extent={{60,60},{80,80}},
          rotation=0)));
  Buildings.Fluid.Sources.Boundary_pT sin(             redeclare package Medium
      = Medium,
    use_p_in=true,
    nPorts=1,
    T=293.15)                                       annotation (Placement(
        transformation(extent={{74,10},{54,30}}, rotation=0)));
  Buildings.Fluid.Sensors.TemperatureWetBulb senWetBul(redeclare package
      Medium = Medium) "Wet bulb temperature sensor" 
    annotation (Placement(transformation(extent={{0,10},{20,30}},  rotation=0)));
  Buildings.Fluid.Sources.MassFlowSource_T massFlowRate(            redeclare
      package Medium = Medium, m_flow=1,
    use_T_in=true,
    use_X_in=true,
    nPorts=1)                            annotation (Placement(transformation(
          extent={{-30,10},{-10,30}}, rotation=0)));
    Modelica.Blocks.Sources.Ramp TDB(
    height=10,
    duration=1,
    offset=273.15 + 30) "Dry bulb temperature" 
                 annotation (Placement(transformation(extent={{-100,40},{-80,60}},
          rotation=0)));
    Modelica.Blocks.Sources.Ramp XHum(
    duration=1,
    height=(0.0133 - 0.0175),
    offset=0.0175) "Humidity concentration" 
                 annotation (Placement(transformation(extent={{-100,-60},{-80,
            -40}}, rotation=0)));
  Modelica.Blocks.Sources.Constant const annotation (Placement(transformation(
          extent={{-100,-20},{-80,0}}, rotation=0)));
  Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(
          extent={{-68,-20},{-48,0}}, rotation=0)));
  Buildings.Utilities.Diagnostics.AssertEquality assertEquality(threShold=0.05) 
    annotation (Placement(transformation(extent={{30,60},{50,80}},   rotation=0)));
  Modelica.Blocks.Sources.Constant TWBExp(k=273.15 + 25)
    "Expected wet bulb temperature" annotation (Placement(transformation(extent={{-8,66},
            {12,86}},           rotation=0)));
  inner Modelica.Fluid.System system 
    annotation (Placement(transformation(extent={{80,-100},{100,-80}})));
  Buildings.Fluid.Sensors.MassFraction masFra(
                      redeclare package Medium = Medium) "Mass fraction" 
    annotation (Placement(transformation(extent={{-50,50},{-30,70}})));
equation
  connect(TDB.y, massFlowRate.T_in) annotation (Line(points={{-79,50},{-60,50},
          {-60,24},{-32,24}}, color={0,0,127}));
  connect(const.y, feedback.u1) annotation (Line(points={{-79,-10},{-66,-10}},
        color={0,0,127}));
  connect(XHum.y, feedback.u2) annotation (Line(points={{-79,-50},{-58,-50},{
          -58,-18}}, color={0,0,127}));
  connect(XHum.y, massFlowRate.X_in[1]) annotation (Line(points={{-79,-50},{-40,
          -50},{-40,16},{-32,16}},       color={0,0,127}));
  connect(feedback.y, massFlowRate.X_in[2]) annotation (Line(points={{-49,-10},
          {-44,-10},{-44,16},{-32,16}},       color={0,0,127}));
  connect(p.y, sin.p_in) annotation (Line(points={{81,70},{92,70},{92,28},{76,
          28}}, color={0,0,127}));
  connect(massFlowRate.ports[1], senWetBul.port_a) annotation (Line(
      points={{-10,20},{0,20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(senWetBul.port_b, sin.ports[1]) annotation (Line(
      points={{20,20},{54,20}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(TWBExp.y, assertEquality.u1) annotation (Line(
      points={{13,76},{28,76}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(senWetBul.T, assertEquality.u2) annotation (Line(
      points={{10,31},{10,44},{20,44},{20,64},{28,64}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(senWetBul.port_a, masFra.port) annotation (Line(
      points={{0,20},{0,40},{-40,40},{-40,50}},
      color={0,127,255},
      smooth=Smooth.None));
end WetBulbTemperature;
