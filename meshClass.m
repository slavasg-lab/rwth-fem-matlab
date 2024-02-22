% Diese Datei enthält die Definition der Klasse "MeshStrct" und sollte zum 
% Zeitpunkt der Auswertung der E-Tests nicht geändert worden sein. Die 
% Datei enthält alle für das Mesh relevanten Variablen und Methoden. Auf 
% die unter 'properties' aufgeführten Variablen kann über 
% mesh.variabelnname zugegriffen werden, wenn ein Objekt vom Typ 
% "MeshStrct" verfügbar ist.
%
%
% This file contains the definition of the class "MeshStrct" and should not
% have been changed at the point of evaluation of the E-Tests. The file
% contains all variables and methods relevant for the mesh. The variables 
% listed under 'properties' can be accessed using mesh.variabelnname
% whenever an object of type "MeshStrct" is available.
%
classdef meshClass
    
  % Gitter bezogene Variabel/ Mesh related variables
  properties
    numElements % Anzahl an Elementen/ number of elements
    numNodes    % Anzahl an Knoten/ number of nodes
    numEleNodes = 4 % Anzahl an Knoten pro Element/ number of element nodes
    
    numEleInX % Anzahl an Elementen in x-Richtung/ number of elements in x-direction
    numEleInY % Anzahl an Elementen in y-Richtung/ number of elements in y-direction
    
    dx % Elementbreite in x-Richtung/ element length in x-direction
    dy % Elementbreite in y-Richtung/ element length in y-direction
        
    nodes % Elementknoten (x,y)/ element nodes (x,y)
       
  end
  
   % Gitter bezogene Funktionen/ Mesh related functions.
  methods
    
    % Constructor: Ein Gitter wird aus einem Set aus gegebenen Parametern 
    % erstellt/ Creates mesh given a set of parameter describing the
    % geometry of the domain.
    function mesh = meshClass(parameter)
      
      mesh.numEleInX = parameter.numEleInX;
      mesh.numEleInY = parameter.numEleInY;

      % Berechnung der totalen Anzahl an Elementen
      % Computation of total number of elements
      mesh.numElements = mesh.numEleInX * mesh.numEleInY;

      % Berechnung der Elementlänge und Breite
      % Computation of element length and width
      mesh.dx = parameter.edgeLength/parameter.numEleInX;
      mesh.dy = parameter.edgeLength/parameter.numEleInY;

      % Berechnung der totalen Anzahl an Gitterpunkten.
      % Total number of mesh nodes in mesh.
      mesh.numNodes = (mesh.numEleInX + 1)*(mesh.numEleInY + 1);

      % Initialize empty gitter.Knoten array of type double.
      mesh.nodes = [];

      % Speichern der Gitterknotenkoordinaten
      % Store all mesh coordinates
      for i = 0:mesh.numEleInY
        for j = 0:mesh.numEleInX
          % Berechnung neuer Knotenkoordinate.
          % Computation of new node coordinates.
          x_new(1,1) = j*mesh.dx;
          x_new(1,2) = i*mesh.dy;
          % Hinzufügen des neuen Knoten zur Liste der Knoten.
          % Add new node to the array of nodes.
          mesh.nodes = [mesh.nodes; x_new];

        end
      end
      
    end  
  end
end