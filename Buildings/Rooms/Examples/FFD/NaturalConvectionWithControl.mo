within Buildings.Rooms.Examples.FFD;
model NaturalConvectionWithControl
  "A case of natural convection with feedback loop control"
  extends NaturalConvection(                matLayRoo(
                                            material= {Buildings.HeatTransfer.Data.Solids.Concrete(x=0.0001)}), roo(
        nPorts=0,
      useCFD=true,
      samplePeriod=30));
  HeatTransfer.Sources.PrescribedHeatFlow preHeatFlo
    annotation (Placement(transformation(extent={{40,80},{60,100}})));
  Controls.Continuous.LimPID conPID(
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=120,
    yMax=1,
    k=0.001)                       annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={90,130})));
  Modelica.Blocks.Sources.Constant const(k=275.15)
                                                annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={130,130})));
initial equation
  roo.air.yCFD[1]=273.15;

equation
  connect(roo.yCFD[1], conPID.u_m) annotation (Line(
      points={{87,51.5},{90,51.5},{90,118}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const.y, conPID.u_s) annotation (Line(
      points={{119,130},{102,130}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(preHeatFlo.port, roo.heaPorAir) annotation (Line(
      points={{60,90},{72,90},{72,40},{65,40}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(conPID.y, preHeatFlo.Q_flow) annotation (Line(
      points={{79,130},{20,130},{20,90},{40,90}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{200,
            200}}),            graphics),
    __Dymola_Commands(file=
          "modelica://Buildings/Resources/Scripts/Dymola/Rooms/Examples/FFD/NaturalConvectionWithControl.mos"
        "Simulate and plot"),
   Documentation(info="<html>
<p>
This model tests the coupled simulation of 
<a href=\"modelica://Buildings.Rooms.CFD\">
Buildings.Rooms.CFD</a>
with the FFD program by simulating natural convection in an empty room with a PI controller and a heater to maintain the temperature at room center to be 2 degC.
</p>
<p>
Configuration of the simulation is the same as 
<a href=\"modelica://Buildings.Rooms.Examples.FFD.NaturalConvection\">
Buildings.Rooms.Examples.FFD.NaturalConvection</a>, except that a heater with PI controller is added to maintain the desire room temperature. 
</p>
<p>
The temperature at the room center is provided by FFD and sent to the PI controller as measured temperature. 
The heat is injected into the room through the heat port as convective heat flow. 
After receving the heat flow from Modelica, the FFD uniformly distributes it into the space.
</p>
<p>
Figure (a) shows the velocity vectors and temperature [degC] on the X-Z plane at Y = 0.5m simulated by the FFD 
</ul>
<p align=\"center\">
<img alt=\"image\" src=\"modelica://Buildings/Resources/Images/Rooms/Examples/FFD/NaturalConvectionWithControl.png\" border=\"1\"/>
</p>
<p align=\"center\">
Figure (a)
</p>
<p>       
</html>", revisions="<html>
<ul>
<li>
May 7, 2014, by Tian Wei:<br/>
First implementation.
</li>
</ul>
</html>"));
end NaturalConvectionWithControl;
