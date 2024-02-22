% In dieser Funktion werden die Systemmatrizen in jedem finiten Element
% aufgestellt. Dazu werden die Simulationsparameter und die Gitterdaten
% benötigt.
%
% In this function all system matrices are assembled. The simulation
% parameter and the mesh data is used for this purpose.

function [M, D] = assembly(parameter, mesh)

  % Anlegen der Systemmatrizen M und D
  % Allocation of the system matrices M und D
  M = zeros(mesh.numNodes);
  D = zeros(mesh.numNodes);
  
      
  % Berechnung der Jacobi-Determinante für die Elemente.
  % Compute the Jacobian of this element
  [detJ, J] = computeJacobian(mesh);

  % Diese Funktion liefert die lokalen Koordinaten der Gausspunkte die bei
  % der numerischen Integration notwendig sind.
  % This function returns the local coordinates of the Gauss points which
  % are required for the numerial integration.
  [numGaussPoints, Gausspoints] = getGausspoints();
  
  % Der Beitrag jedes Finiten Elements zur Systemmatrix wird berechnet.
  % Compute the contribution of every finite element to the system matrix.
  for i = 1 : mesh.numElements
    
    % Identifizieren der globalen Elementsknotennummern
    % Idetntify the global element node IDs
    [nodeIDs] = getEleNodesIDs(i,mesh);
       
    % Für jedes element werden die Elementmatrizen aufaddiert.
    % The element matrices are add up for every element individually
    Me = zeros(4);
    De = zeros(4);
    
    % Auswerten der integralen Ausdrücke für die Systemmatrizen mittels Gaussquadratur
    % Evaluate integral expressions for system matrices via Gaussquadrature
    % [vgl. Numerik für Ingenieure und Naturwissenschaftler, W. Dahmen und A. Reusken, Kapitel 10.3]
    
    for igp = 1:numGaussPoints % Loop über alle Gausspunkte/ Loop over every Gauspoint.
      
      % Auswerten der Basisfunktionen und ihrer Ableitungen für jeden Quadraturpunkt
      % Evaluate basisfunctions and their derivatives at every quadrature point
      [phi, dPhidXi] = evaluateBasisAndDerivatives(Gausspoints(igp,1), Gausspoints(igp,2));          
           
      % Berechnung der Elementmatrizen Me und De/ 
      % Compute the element matrices Me and De:
      for i = 1:mesh.numEleNodes
        for j = 1:mesh.numEleNodes
          
          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          %% Ergaenzen Sie den Code / Complete code here
          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          % Aufstellen der Massenmatrix M
          Me(i,j) = Me(i,j) + phi(i) * phi(j) * abs(detJ);
          
          % Aufstellen der Matrix D
          De(i,j) = De(i,j) + ((inv(J))'*dPhidXi(:,j))'*((inv(J))' * dPhidXi(:, i))*abs(detJ);
          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          
        end
      end        
           
    end
    
    % Assemblierung der Elementmatrix in die globale Systemmatrix
    % Assembling the element contribution to the global system matrix
    [M,D]= assembleLocal2Global(i, nodeIDs ,Me , De, M, D);
    
  end
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%% Ab hier nicht mehr bearbeiten!      %%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%% Do not change after this comment!   %%%%%%%%%%%%%%%%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  % Diese Funktion liefert die globalen IDs der Elementknoten
  % This function return the global IDs of the element nodes
  function [nodeIDs] = getEleNodesIDs(eleID,mesh)
    
    % Get 1. node ID
    nodeIDs(1) = eleID + floor((eleID+1)/(mesh.numEleInX+1));
    %Get 2. node ID
    nodeIDs(2) = eleID + floor((eleID+1)/(mesh.numEleInX+1)) + 1;
    %Get 2. node ID
    nodeIDs(3) = eleID + floor((eleID+1)/(mesh.numEleInX+1)) + (mesh.numEleInX + 2);
    %Get 4. node ID
    nodeIDs(4) = eleID + floor((eleID+1)/(mesh.numEleInX+1)) + (mesh.numEleInX + 1);
       
  end
  
  % Diese Funktion liefert die Gausspunkte zur Auswertung eines 2D Integrals
  % This function returns the Gausspoints for the evaluation of a 2D integral

  function [numGausspoints, Gausspoints] = getGausspoints()
    
    % Im 2d Fall mit linearen Basisfunktionen reichen 4 Gausspunkte pro Element
    % In the 2d case with linear basis functions 2 Gausspoints per element are sufficient
    numGausspoints = 4;
    
    Gausspoints(1,1) = -0.57735026919;
    Gausspoints(1,2) =  0.57735026919;
    Gausspoints(2,1) =  0.57735026919;
    Gausspoints(2,2) =  0.57735026919;
    Gausspoints(3,1) =  0.57735026919;
    Gausspoints(3,2) = -0.57735026919;
    Gausspoints(4,1) = -0.57735026919;
    Gausspoints(4,2) = -0.57735026919;
        
  end

  % Diese Funktion sortiert die lokalen Elementmatrizen in die Globalen M
  % und D.
  % This function assembles the local elementmatrices into global M and D.
  function [M,D] = assembleLocal2Global(eleID, nodeIDs, Me, De, M, D)
    
    % Alle 4x4 Einträge der lokalen Elementmatrizen werden in den globalen
    % M und D aufaddiert.
    % All 4x4 entries of the local elementmatrices are assembled into the
    % global M and D.
    for i = 1:length(nodeIDs)
      for j = 1:length(nodeIDs)
        
        M(nodeIDs(i),nodeIDs(j)) = M(nodeIDs(i),nodeIDs(j)) + Me(i,j);
        D(nodeIDs(i),nodeIDs(j)) = D(nodeIDs(i),nodeIDs(j)) + De(i,j);
        
      end
    end
        
  end

end
