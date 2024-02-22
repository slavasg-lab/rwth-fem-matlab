%Finite Elemente Demonstrator

% Diese Funktion ist die "Hauptfunktion" und sollte zur Auswertung der
% E-Test nicht verändert worden sein.

% This function is the "main function" and should stay untouched for the
% evaluation of the E-test.


% Matlab commands:
clear all % Löschen des Workspaces und Schließen aller geöffneten Plotfenster.
close all % Clear the workspace and close all old plot windows.

% Laden der Simulationsparamter
% Loading the simulation paramters
simulationParameter;

% Hier wird das Rechengitter generiert.
% Creating the Finite Element mesh.
mesh = meshClass(parameter);

% Berechnung des Systemmatrizen
% Assmbly of the systemmatrices
[M, D] = assembly(parameter, mesh);

%%

% Setzen der Startbedingung
% Set initial solution for simulation
T0 = setInitialSolution(parameter,mesh);

% Visualisierung der Anfangsbedingung
% Plot the inital condition
 plotResult(mesh, T0, 0);
%%

% Loesung und Assemblierung der linearen Gleichungssystem (LGS)
% Solve and assembly of the linear equation system (LES)
[T] = solver (parameter, mesh, T0, M, D);
% 
% % Visualisierung der Lösung
% % Plot the solution
 plotResult(mesh, T, parameter.tEnd);