  % In dieser Funktion wird die Jacobi-Matrix des Finiten Elements mit der
  % Element nummer elementId berechnet.
  % This function computes the Jacobian and its determinant of every Finite
  % Element with the element ID elementId.
  function [detJ, J] = computeJacobian(mesh)
    
    % Berechnung der Einträge der Jacobi-Matrix.
    % Compute entries for Jacobian matrix.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%% Ergaenzen Sie den Code / Complete the code%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    J(1,1) = mesh.dx / 2;
    J(2,1) = 0;
    J(1,2) = 0;
    J(2,2) = mesh.dy / 2;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Berechnung der Determinante der Jacobi-Matrix
    % Compute the determinant of the Jacobian.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%% Ergaenzen Sie den Code / Complete the code%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    detJ = mesh.dx * mesh.dy / 4;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  end
