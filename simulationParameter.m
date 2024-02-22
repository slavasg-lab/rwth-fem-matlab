% In dieser Datei können alle Parameter gesetzt werden, die das
% Temperaturproblem beschreiben. Weiter werden alle Material und
% Zeitparameter definiert.
%
% In this file all parameters can be set which describe the temperature
% problem. Furthermore, all material and time parameters are defined.

% Gitter Parameter / Mesh parameter:
parameter.edgeLength = 3;  % Kantenlänge der Platte / Edge length of plate.
parameter.numEleInX = 20;  % Anzahl Elemente in x-Richtung/ number of elements in x-direction
parameter.numEleInY = 20;  % Anzahl Elemente in y-Richtung/ number of elements in y-direction

% Zeit parameter / Time parameter :
parameter.dt = 0.2;       % Zeitschrittweite / Time step size
parameter.tEnd = 20;      % Endpunkt Simulation/ Time at end of simulation

% Materialparameter/ material parameter:
parameter.lambda = 0.02;   % Wärmeleitkoeffizient / Heatconduction coefficient

% Anfangsbedingung [1/2/3] / Use Initial Solution [1/2/3]
parameter.initial = 1;

