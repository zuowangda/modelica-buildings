within Buildings.Rooms.BaseClasses;
function cfdStartCosimulation "Start the cosimulation with CFD"
  input String cfdFilNam "CFD input file name";
  input String[nSur] name "Surface names";
  input Modelica.SIunits.Area[nSur] A "Surface areas";
  input Modelica.SIunits.Angle[nSur] til "Surface tilt";
  input Buildings.Rooms.Types.CFDBoundaryConditions[nSur] bouCon
    "Type of boundary condition";
  input Integer nPorts(min=0)
    "Number of fluid ports for the HVAC inlet and outlets";
  input String portName[nPorts]
    "Names of fluid ports as declared in the CFD input file";
  input Boolean haveSensor "Flag, true if the model has at least one sensor";
  input String sensorName[nSen]
    "Names of sensors as declared in the CFD input file";
  input Boolean haveShade "Flag, true if the windows have a shade";
  input Integer nSur "Number of surfaces";
  input Integer nSen(min=0)
    "Number of sensors that are connected to CFD output";
  input Integer nConExtWin(min=0) "number of exterior construction with window";
  input Integer nX(min=0) "number of species";
  input Integer nC(min=0) "number of trace substances";

  output Integer retVal
    "Return value of the function (0 indicates CFD successfully started.)";
external"C" retVal = cfdStartCosimulation(
    cfdFilNam,
    name,
    A,
    til,
    bouCon,
    nPorts,
    portName,
    haveSensor,
    sensorName,
    haveShade,
    nSur,
    nSen,
    nConExtWin,
    nX,
    nC) annotation (Include="#include <cfdStartCosimulation.c>",
      IncludeDirectory="modelica://Buildings/Resources/C-Sources");

  annotation (Documentation(info="<html>
<p>
This function calls a C function to start cosimulation with CFD.</html>",
        revisions="<html>
<ul>
<li>
August 16, 2013, by Wangda Zuo:<br/>
First implementation.
</li>
</ul>
</html>"));

end cfdStartCosimulation;