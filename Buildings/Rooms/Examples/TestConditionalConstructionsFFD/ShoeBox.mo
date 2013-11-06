within Buildings.Rooms.Examples.TestConditionalConstructionsFFD;
model ShoeBox "A shoe box room model with only walls"
  extends Modelica.Icons.Example;
  package MediumA = Buildings.Media.GasesConstantDensity.MoistAirUnsaturated (T_default = 283.15)
    "Medium model";

  inner Modelica.Fluid.System system(T_ambient=283.15)
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));

  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic matLayRoo(final
      nLay=1, material={HeatTransfer.Data.Solids.Concrete(x=0.0001)})
    "Construction material for roof"
    annotation (Placement(transformation(extent={{20,140},{40,160}})));

  parameter Integer nConExtWin=0 "Number of constructions with a window";
  parameter Integer nConBou=6
    "Number of surface that are connected to constructions that are modeled inside the room";
  parameter Integer nSurBou=0
    "Number of surface that are connected to the room air volume";

  Buildings.Rooms.FFD roo(
    redeclare package Medium = MediumA,
    nConBou=nConBou,
    nSurBou=nSurBou,
    sensorName={"Occupied zone air temperature","Velocity"},
    useFFD=true,
    startTime=0,
    nConPar=0,
    nConExtWin=0,
    AFlo=1*1,
    hRoo=1,
    cfdFilNam="Resources/Data/Rooms/FFD/ShoeBox.ffd",
    nConExt=0,
    datConBou(
      name={"East Wall","West Wall","North Wall","South Wall","Floor","Ceiling"},
      layers={matLayRoo,matLayRoo,matLayRoo,matLayRoo,matLayRoo,matLayRoo},
      each A=1*1,
      til={Buildings.HeatTransfer.Types.Tilt.Wall,Buildings.HeatTransfer.Types.Tilt.Wall,
          Buildings.HeatTransfer.Types.Tilt.Wall,Buildings.HeatTransfer.Types.Tilt.Wall,
          Buildings.HeatTransfer.Types.Tilt.Floor,Buildings.HeatTransfer.Types.Tilt.Ceiling}),
    linearizeRadiation=true,
    samplePeriod=100,
    lat=0.00022318989969804) "Room model"
    annotation (Placement(transformation(extent={{46,20},{86,60}})));

  Modelica.Blocks.Sources.Constant qConGai_flow(k=0) "Convective heat gain"
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.Blocks.Sources.Constant qRadGai_flow(k=0) "Radiative heat gain"
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  Modelica.Blocks.Routing.Multiplex3 multiplex3_1
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Modelica.Blocks.Sources.Constant qLatGai_flow(k=0) "Latent heat gain"
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    filNam="Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos",
    TDryBulSou=Buildings.BoundaryConditions.Types.DataSource.Parameter,
    TDryBul=293.15)
    annotation (Placement(transformation(extent={{160,140},{180,160}})));

  Buildings.HeatTransfer.Sources.FixedTemperature TWalRes[nConBou - 1](each T=283.15)
    "Boundary condition for the rest of walls"
                                          annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={110,-30})));

  Buildings.HeatTransfer.Sources.FixedTemperature TEasWal(each T=293.15)
    "Temperature of east wall"            annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={110,10})));
equation
  connect(qRadGai_flow.y, multiplex3_1.u1[1]) annotation (Line(
      points={{-39,90},{-32,90},{-32,57},{-22,57}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(qConGai_flow.y, multiplex3_1.u2[1]) annotation (Line(
      points={{-39,50},{-22,50}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(qLatGai_flow.y, multiplex3_1.u3[1]) annotation (Line(
      points={{-39,10},{-32,10},{-32,43},{-22,43}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(multiplex3_1.y, roo.qGai_flow) annotation (Line(
      points={{1,50},{20,50},{20,48},{44,48}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(weaDat.weaBus, roo.weaBus) annotation (Line(
      points={{180,150},{190,150},{190,57.9},{83.9,57.9}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None));
  for i in 1: nConBou-1 loop
    connect(TWalRes[i].port, roo.surf_conBou[i+1])
    annotation (Line(
      points={{100,-30},{72,-30},{72,24}},
      color={191,0,0},
      smooth=Smooth.None));

  end for;


  connect(TEasWal.port, roo.surf_conBou[1]) annotation (Line(
      points={{100,10},{72,10},{72,24}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{200,
            200}}),     graphics),
    __Dymola_Commands(file=
          "modelica://Buildings/Resources/Scripts/Dymola/Rooms/Examples/TestConditionalConstructionsFFD/ShoeBox.mos"
        "Simulate and plot"),
    Documentation(info="<html>
<p>
This model tests whether 
<a href=\"modelica://Buildings.Rooms.FFD\">
Buildings.Rooms.FFD</a>
can conduct cosimulation with FFD program with only interior walls. 
The dimension of the room is 1m x 1m x 1m.
The temperature of east wall is set to 10 degC and the rest walls are 0 degC.
The initial temperature of indoor air is 0 degC and it will increase due to the warm wall on the east.
</p>
<p>
<b>Note:</b> This model has an unrealistic geometry as it is used only 
to test the correctness of cosimulaton with walls.
</p>
</html>", revisions="<html>
<ul>
<li>
August 13, 2013, by Wangda Zuo:<br/>
First implementation.
</li>
</ul>
</html>"),
    experiment(
      StopTime=1000,
      __Dymola_fixedstepsize=0.1,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end ShoeBox;
