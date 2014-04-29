within Buildings.Rooms.Examples.FFD;
model NaturalConvectionWithControl
  "A case of natural convection with feedback loop control"
  extends NaturalConvection(                matLayRoo(
                                            material= {Buildings.HeatTransfer.Data.Solids.Concrete(x=0.0001)}), roo(
        nPorts=0,
      useCFD=true,
      samplePeriod=30));
  HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{26,76},{46,96}})));
  Controls.Continuous.LimPID conPID(
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=120,
    Td=10,
    k=0.5)                         annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={90,140})));
  Modelica.Blocks.Sources.Constant const(k=275.15)
                                                annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={148,118})));
  Modelica.Blocks.Math.Gain gain(k=1*1*1*0.01) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={8,108})));
equation
  connect(prescribedHeatFlow.port, roo.heaPorAir) annotation (Line(
      points={{46,86},{58,86},{58,52},{65,52},{65,40}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(conPID.y, gain.u) annotation (Line(
      points={{79,140},{44,140},{44,130},{8,130},{8,120}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gain.y, prescribedHeatFlow.Q_flow) annotation (Line(
      points={{8,97},{8,86},{26,86}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const.y, conPID.u_s) annotation (Line(
      points={{137,118},{122,118},{122,138},{102,138},{102,140}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(roo.yCFD[1], conPID.u_m) annotation (Line(
      points={{87,51.5},{96,51.5},{96,128},{90,128}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{200,200}}), graphics));
end NaturalConvectionWithControl;
