within Buildings.Fluid.HeatExchangers.Boreholes;
model UTube "Single U-tube borehole heat exchanger"
  extends Buildings.Fluid.Interfaces.PartialTwoPortInterface(
    show_T=true);
  extends Buildings.Fluid.Interfaces.TwoPortFlowResistanceParameters(final
      computeFlowResistance=false, final linearizeFlowResistance=false);
  extends Buildings.Fluid.Interfaces.LumpedVolumeDeclarations;

  parameter Modelica.SIunits.Radius rTub=0.02 "Radius of the tubes"
    annotation(Dialog(group="Tubes"));
  parameter Modelica.SIunits.ThermalConductivity kTub=0.5
    "Thermal conductivity of the tube" annotation (Dialog(group="Tubes"));
  parameter Modelica.SIunits.Length eTub=0.002 "Thickness of a tube"
    annotation (Dialog(group="Tubes"));

  replaceable parameter Buildings.HeatTransfer.Data.BoreholeFillings.Generic
    matFil "Thermal properties of the borehole filling"
    annotation (choicesAllMatching=true, Dialog(group="Borehole"));
  parameter Modelica.SIunits.Height hBor "Total height of the borehole"
    annotation(Dialog(group="Borehole"));
  parameter Integer nVer=10
    "Number of segments used for discretization in the vertical direction"
      annotation(Dialog(group="Borehole"));
  parameter Modelica.SIunits.Radius rBor=0.1 "Radius of the borehole";

  replaceable parameter Buildings.HeatTransfer.Data.Soil.Generic
    matSoi[nVer] "Thermal properties of the soil"
    annotation (choicesAllMatching=true, Dialog(group="Soil"));

  parameter Modelica.SIunits.Radius rExt=3
    "Radius of the soil used for the external boundary condition"
    annotation (Dialog(group="Soil"));
  parameter Integer nHor(min=1) = 10
    "Number of state variables in each horizontal layer of the soil"
    annotation (Dialog(group="Soil"));

  parameter Modelica.SIunits.Temperature TExt0_start=283.15
    "Initial far field temperature"
    annotation (Dialog(tab="Initial temperature", group="Soil"));
  parameter Modelica.SIunits.Temperature TExt_start[nVer]={if z[i] >= z0 then
      TExt0_start + (z[i] - z0)*dT_dz else TExt0_start for i in 1:nVer}
    "Temperature of the undisturbed ground"
    annotation (Dialog(tab="Initial temperature", group="Soil"));

  parameter Modelica.SIunits.Temperature TFil0_start=TExt0_start
    "Initial temperature of the filling material for h = 0...z0"
    annotation (Dialog(tab="Initial temperature", group="Filling material"));
  parameter Modelica.SIunits.Temperature TFil_start[nVer]=TExt_start
    "Temperature of the undisturbed ground"
    annotation (Dialog(tab="Initial temperature", group="Filling material"));

  parameter Modelica.SIunits.Height z0=10
    "Depth below which the temperature gradient starts"
    annotation (Dialog(tab="Initial temperature", group="Temperature profile"));
  parameter Real dT_dz(unit="K/m") = 0.01
    "Vertical temperature gradient of the undisturbed soil for h below z0"
    annotation (Dialog(tab="Initial temperature", group="Temperature profile"));

  parameter Modelica.SIunits.Time samplePeriod
    "Sample period for the external boundary condition"
    annotation (Dialog(group="Soil"));
  parameter Modelica.SIunits.Length xC=0.05
    "Shank spacing, defined as the distance between the center of a pipe and the center of the borehole"
    annotation(Dialog(group="Borehole"));
  parameter Real B0=17.44 "Shape coefficient for grout resistance"
    annotation(Dialog(group="Borehole"));
  parameter Real B1=-0.605 "Shape coefficient for grout resistance"
    annotation(Dialog(group="Borehole"));
  Buildings.Fluid.HeatExchangers.Boreholes.BaseClasses.BoreholeSegment borHol[nVer](
    redeclare each final package Medium = Medium,
    final matSoi=matSoi,
    each final matFil=matFil,
    each final hSeg=hBor/nVer,
    each final samplePeriod=samplePeriod,
    each final rTub=rTub,
    each final rBor=rBor,
    each final rExt=rExt,
    each final xC=xC,
    each final eTub=eTub,
    each final kTub=kTub,
    each final B0=B0,
    each final B1=B1,
    each final nSta=nHor,
    each final m_flow_nominal=m_flow_nominal,
    each final m_flow_small=m_flow_small,
    final dp_nominal={if i == 1 then dp_nominal else 0 for i in 1:nVer},
    TExt_start=TExt_start,
    TFil_start=TExt_start,
    each final homotopyInitialization=homotopyInitialization,
    each final show_V_flow=show_V_flow,
    each final show_T=show_T,
    each final computeFlowResistance=computeFlowResistance,
    each final from_dp=from_dp,
    each final linearizeFlowResistance=linearizeFlowResistance,
    each final deltaM=deltaM,
    each final energyDynamics=energyDynamics,
    each final massDynamics=massDynamics,
    each final p_start=p_start,
    each T_start=T_start,
    each X_start=X_start,
    each C_start=C_start,
    each C_nominal=C_nominal,
    each allowFlowReversal=allowFlowReversal) "Discretized borehole segments"
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));

  Modelica.SIunits.Temperature Tdown[nVer] "Medium temperature in pipe 1";
  Modelica.SIunits.Temperature Tup[nVer] "Medium temperature in pipe 2";
protected
  parameter Modelica.SIunits.Height z[nVer]={hBor/nVer*(i - 0.5) for i in 1:
      nVer} "Distance from the surface to the considered segment";
equation
  Tdown[:] = borHol[:].pipFil.vol1.heatPort.T;
  Tup[:] = borHol[:].pipFil.vol2.heatPort.T;
  connect(port_a, borHol[1].port_a1) annotation (Line(
      points={{-100,5.55112e-16},{-60,5.55112e-16},{-60,6},{-20,6}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(port_b, borHol[1].port_b2) annotation (Line(
      points={{100,5.55112e-16},{20,5.55112e-16},{20,-40},{-40,-40},{-40,-6},{
          -20,-6}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(borHol[nVer].port_b1, borHol[nVer].port_a2) annotation (Line(
      points={{5.55112e-16,6},{10,6},{10,-6},{5.55112e-16,-6}},
      color={0,127,255},
      smooth=Smooth.None));
  for i in 1:nVer - 1 loop
    connect(borHol[i].port_b1, borHol[i + 1].port_a1) annotation (Line(
        points={{5.55112e-16,6},{5.55112e-16,20},{-20,20},{-20,6}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(borHol[i].port_a2, borHol[i + 1].port_b2) annotation (Line(
        points={{5.55112e-16,-6},{5.55112e-16,-20},{-20,-20},{-20,-6}},
        color={0,127,255},
        smooth=Smooth.None));
  end for;
    annotation (
    defaultComponentName="borehole",
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2},
        initialScale=0.5), graphics={
        Rectangle(
          extent={{-70,80},{70,-80}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={95,95,95},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-62,-52},{62,-60}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-62,58},{62,54}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-62,6},{62,0}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{54,92},{46,-88}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-54,-88},{-46,92}},
          lineColor={0,0,255},
          pattern=LinePattern.None,
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-72,80},{-62,-80}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{62,80},{72,-80}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Backward)}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2},
        initialScale=0.5)),
    Documentation(info="<html>
<p>
Model of a single U-tube borehole heat exchanger. 
The borehole heat exchanger is vertically discretized into <i>n<sub>seg</sub></i>
elements of height <i>h=h<sub>Bor</sub>&frasl;n<sub>seg</sub></i>.
Each segment contains a model for the heat transfer in the borehole, 
for heat transfer in the soil and for the far-field boundary condition.
</p>
<p>
The heat transfer in the borehole is computed using a convective heat transfer coefficient
that depends on the fluid velocity, a heat resistance between the two pipes, and
a heat resistance between the pipes and the circumference of the borehole.
The heat capacity of the fluid, and the heat capacity of the grout, is taken into account.
All thermal mass is assumed to be at the two bulk temperatures of the down-flowing 
and up-flowing fluid.
</p>
<p>
The heat transfer in the soil is computed using transient heat conduction in cylindrical
coordinates for the spatial domain <i>r<sub>bor</sub> &le; r &le; r<sub>ext</sub></i>. 
In the radial direction, the spatial domain is discretized into 
<i>n<sub>hor</sub></i> segments with uniform material properties.
Thermal properties can be specified separately for each horizontal layer.
The vertical heat flow is assumed to be zero, and there is assumed to be 
no ground water flow. 
</p>
<p>
The far-field temperature, i.e., the temperature at the radius 
<i>r<sub>ext</sub></i>, is computed using a power-series solution
to a line-source heat transfer problem. This temperature boundary condition
is updated every <i>t<sub>sample</sub></i> seconds.
</p>
<p>
The initial far-field temperature <i>T<sub>ext,start</sub></i>, which
is the temperature of the soil at a radius <i>r<sub>ext</sub></i>,
is computed 
as a function of the depth <i>z &gt; 0</i>. 
For a depth between <i>0 &le; z &le; z<sub>0</sub></i>, the temperature
is set to <i>T<sub>ext,0,start</sub></i>. 
The value of <i>z<sub>0</sub></i> is a parameter with a default of 10 meters.
However, there is large variability in the depth where the undisturbed soil temperature
starts.
For a depth of <i>z<sub>0</sub> &le; z &le; h<sub>bor</sub></i>,
the temperature is computed as
</p>
<p align=\"center\" style=\"font-style:italic;\">
  T<sup>i</sup><sub>ext,start</sub> = T<sub>ext,0,start</sub> + (z<sup>i</sup> - z<sub>0</sub>)  dT &frasl; dz
</p>
<p>
with <i>i &isin; {1, ..., n<sub>ver</sub>}</i>,
where the temperature gradient <i>dT &frasl; dz &ge; 0</i> is a parameter.
As with <i>z<sub>0</sub></i>, there is large variability in 
<i>dT &frasl; dz &ge; 0</i>. The default value is set to <i>1</i> Kelvin per 100 meters.
For the temperature of the grout, the same equations are applied, with
<i>T<sub>ext,0,start</sub></i> replaced with
<i>T<sub>fil,0,start</sub></i>, and 
<i>T<sup>i</sup><sub>ext,start</sub></i> replaced with
<i>T<sup>i</sup><sub>fil,start</sub></i>. 
The default setting uses the same temperature for the soil and the filling material.
</p>
<h4>Implementation</h4>
<p>
Each horizontal layer is modeled using an instance of
<a href=\"modelica://Buildings.Fluid.HeatExchangers.Boreholes.BaseClasses.BoreholeSegment\">
Buildings.HeatExchangers.Fluid.Boreholes.BaseClasses.BoreholeSegment</a>.
This model is composed of the model
<a href=\"modelica://Buildings.Fluid.HeatExchangers.Boreholes.BaseClasses.HexInternalElement\">
Buildings.Fluid.HeatExchangers.Boreholes.BaseClasses.HexInternalElement</a> which computes
the heat transfer in the pipes and the borehole filling,
of the model
<a href=\"modelica://Buildings.HeatTransfer.Conduction.SingleLayerCylinder\">
Buildings.HeatTransfer.Conduction.SingleLayerCylinder</a> which computes
the heat transfer in the soil, and
of the model
<a href=\"modelica://Buildings.Fluid.HeatExchangers.Boreholes.BaseClasses.TemperatureBoundaryCondition\">
Buildings.Fluid.HeatExchangers.Boreholes.BaseClasses.TemperatureBoundaryCondition</a> which computes
the far-field temperature boundary condition.
</p>
</html>", revisions="<html>
<ul>
<li>
August 2011, by Pierre Vigouroux:<br/>
First implementation.
</li>
</ul>
</html>"));
end UTube;
