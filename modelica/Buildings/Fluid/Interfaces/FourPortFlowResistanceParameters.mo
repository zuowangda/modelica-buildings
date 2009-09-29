within Buildings.Fluid.Interfaces;
record FourPortFlowResistanceParameters
  "Parameters for flow resistance for models with four ports"

annotation (Documentation(info="<html>
This class contains parameters that are used to
compute the pressure drop in components that have two fluid streams.
Note that the nominal mass flow rate is not declared here because
the model 
<a href=\"Modelica:Buildings.Fluid.Interfaces.PartialStaticFourPortInterface\">
PartialStaticFourPortInterface</a>
already declares it.
</html>",
revisions="<html>
<ul>
<li>
April 13, 2009, by Michael Wetter:<br>
First implementation.
</li>
</ul>
</html>"));

  parameter Boolean computeFlowResistance1 = true
    "=true, compute flow resistance. Set to false to assume no friction" 
    annotation (Evaluate=true, Dialog(tab="Flow resistance", group="Medium 1"), choices(__Dymola_checkBox=true));

  parameter Boolean from_dp1 = true
    "= true, use m_flow = f(dp) else dp = f(m_flow)" 
    annotation (Evaluate=true, Dialog(enable = computeFlowResistance1,
                tab="Flow resistance", group="Medium 1"),
                choices(__Dymola_checkBox=true));
  parameter Modelica.SIunits.Pressure dp1_nominal(min=0, displayUnit="Pa")
    "Pressure" annotation(Dialog(group = "Nominal condition"));
  parameter Boolean linearizeFlowResistance1 = false
    "= true, use linear relation between m_flow and dp for any flow rate" 
    annotation(Dialog(enable = computeFlowResistance1,
               tab="Flow resistance", group="Medium 1"),
               choices(__Dymola_checkBox=true));
  parameter Real deltaM1 = 0.1
    "Fraction of nominal flow rate where flow transitions to laminar" 
    annotation(Dialog(enable = computeFlowResistance1,
                      tab="Flow resistance", group="Medium 1"));
  parameter Boolean computeFlowResistance2 = true
    "=true, compute flow resistance. Set to false to assume no friction" 
    annotation (Evaluate=true, Dialog(tab="Flow resistance", group="Medium 2"), choices(__Dymola_checkBox=true));

  parameter Boolean from_dp2 = true
    "= true, use m_flow = f(dp) else dp = f(m_flow)" 
    annotation (Evaluate=true, Dialog(enable = computeFlowResistance2,
                tab="Flow resistance", group="Medium 2"),
                choices(__Dymola_checkBox=true));
  parameter Modelica.SIunits.Pressure dp2_nominal(min=0, displayUnit="Pa")
    "Pressure" annotation(Dialog(group = "Nominal condition"));
  parameter Boolean linearizeFlowResistance2 = false
    "= true, use linear relation between m_flow and dp for any flow rate" 
    annotation(Dialog(enable = computeFlowResistance2,
               tab="Flow resistance", group="Medium 2"),
               choices(__Dymola_checkBox=true));
  parameter Real deltaM2 = 0.1
    "Fraction of nominal flow rate where flow transitions to laminar" 
    annotation(Dialog(enable = computeFlowResistance2,
                      tab="Flow resistance", group="Medium 2"));
end FourPortFlowResistanceParameters;
