within Buildings.Rooms.Examples.FFD;
model MixedConvectionWithControl
  "A case of mixed convection with feedback loop control"
  extends Rooms.Examples.FFD.MixedConvection;
  Controls.Continuous.LimPID conPID(
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=120,
    k=0.05,
    yMax=1)                        annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={84,136})));
  Modelica.Blocks.Math.Gain gain(k=10)         annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={2,104})));
  HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{20,72},{40,92}})));
  Modelica.Blocks.Sources.Constant const(k=310) annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={142,114})));
equation
  connect(roo.yCFD[1], conPID.u_m) annotation (Line(
      points={{87,51.5},{84,51.5},{84,124}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const.y, conPID.u_s) annotation (Line(
      points={{131,114},{114,114},{114,136},{96,136}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(conPID.y, gain.u) annotation (Line(
      points={{73,136},{38,136},{38,116},{2,116}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(gain.y, prescribedHeatFlow.Q_flow) annotation (Line(
      points={{2,93},{2,82},{20,82}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(prescribedHeatFlow.port, roo.heaPorAir) annotation (Line(
      points={{40,82},{62,82},{62,78},{65,78},{65,40}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{200,200}}), graphics));
end MixedConvectionWithControl;
