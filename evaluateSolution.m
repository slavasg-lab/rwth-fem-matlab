% Diese Funktion wird zur Auswertung der Lösung im E-Test benötigt. Die
% Lösung wird dazu aus dem Lösungsvektor an der Stelle x, y interpoliert.
% This function is needed for evaluating the solution within the E-Test. 
% The solution is therefore interpolated from the solution fiel at position x,y.
function evaluateSolution(mesh, T, x, y)

  % Zuerst wird das Element identifiziert in welchem sich die Position
  % (x,y) befindet. Anschließend werden die Ids der Elementknoten und xi/eta
  % im Referenzelement bestimmt.
  % idetify Element number of x/y and return nodeIDs of element
  [nodeIDs, xi, eta] = getElementInfo(mesh, x, y); 
  
  % Auswerten der Interpolationsfunktionen an berechneten Koordinaten (xi,eta)
  % Evaluate basisfunctions at position of computed (xi,eta)
  [phi, dPhidXi] = evaluateBasisAndDerivatives(xi, eta);
  
  % Interpolieren des Temperaturwerts an der Stelle (x,y) mit den
  % ausgewerteten Interpolationsfunktionen und den Temperaturwerten an den
  % Elementknoten.
  % Interpolate temperature T at position (x,y) with computed
  % basisfunctions and values of T at element nodes.
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%% Ergaenzen Sie den Code/ Complete code  %%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  Teval = T(nodeIDs)*phi;
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%% Ab hier nicht mehr bearbeiten!      %%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%% Do not change after this comment!   %%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  
  % Abrunden der Lösung auf 2 Dezimalstellen (Nicht Verändern!!!)
  % Round solution to two decimal values (Do not change!!!)
  Teval = round(Teval,2); 
  
  fprintf('T(%.2f,%.2f) = %.2f\n', x,y,Teval);
  
  
  % Diese Funktion liefert die globalen IDs der Elementknoten
  % This function return the global IDs of the element nodes
  function [nodeIDs, xi, eta] = getElementInfo(mesh, x, y)
    
    % Berechnung der ElementId
    % Determine element ID.
    eleIdX = int32(floor(x/mesh.dx));
    eleIdY = int32(floor(y/mesh.dy));
    
    if(eleIdX == mesh.numEleInX)
      eleIdX = eleIdX - 1;
    end
    
    if(eleIdY == mesh.numEleInY)
      eleIdY = eleIdY - 1;
    end
        
    eleID = mesh.numEleInX*(eleIdY) + eleIdX + 1;
    
    % Berechnung von xi und eta für Stelle (x,y)
    % Compute Xi and eta coordinate for position (x,y)
    xi = -1.0 + 2*(x - mesh.dx*double(eleIdX))/mesh.dx;
    eta = -1.0+ 2*(y - mesh.dy*double(eleIdY))/mesh.dy;
    
    
    % Get 1. node ID
    nodeIDs(1) = eleID + floor((eleID+1)/(mesh.numEleInX+1));
    %Get 2. node ID
    nodeIDs(2) = eleID + floor((eleID+1)/(mesh.numEleInX+1)) + 1;
    %Get 2. node ID
    nodeIDs(3) = eleID + floor((eleID+1)/(mesh.numEleInX+1)) + (mesh.numEleInX + 2);
    %Get 4. node ID
    nodeIDs(4) = eleID + floor((eleID+1)/(mesh.numEleInX+1)) + (mesh.numEleInX + 1);
       
  end

end
