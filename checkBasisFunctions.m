% Diese Funktion überprüft ob die Implementierung der Basisfunktionen
% korrekt ist.
% This function checks if the Implementation of the basis function is
% correct.

% Reset old plots
close all;
clear all;
clc;

% Festlegen der zu Plottenden Basisfunktion - darf verändert werden
% Set value of Basisfunction that should be plotted - can be changed
basis2plot = 4;

checkInterpolationFct();

checkDerInterpolationFct();

plotBasisFunct(basis2plot)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% Ab hier nicht verändern    %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% Do not Change from here on %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function checkInterpolationFct()
  
  % Setzen des bool Werts auf wahr
  % Set Boolean true
  test = true;

  % Erzeuge Punktpaare (xi,eta)
  % Create pointpair in (xi,eta)
  xi = [-1.0,1.0];
  eta = [-1.0,1.0];

  % Auswertung der Basisfunktionen an unterschiedlichen Punktepaaren (xi,eta)
  % Evaluate basisfunction at various Points (xi,eta)
  for i = 1: length(xi)
    for j = 1:length(eta)

      [phi, dPhidX] = evaluateBasisAndDerivatives(xi(i),eta(j));
      
      if (i ==1 && j ==1)
        if(phi(1) == 1 && phi(2) ==0 && phi(3) == 0 && phi(4) == 0)
          fprintf('Interpolationfunction 1 returns expected value.\n')
        else
          test = false;
          fprintf('ERROR: Interpolationfunction 1 returns not expected value.\n')
        end        
      elseif (i ==1 && j ==2)
        if(phi(1) == 0 && phi(2) ==0 && phi(3) == 0 && phi(4) == 1)
          fprintf('Interpolationfunction 4 returns expected value.\n')
        else
          test = false;
          fprintf('ERROR: Interpolationfunction 4 returns not expected value.\n')
        end        
      elseif (i ==2 && j ==1)
        if(phi(1) == 0 && phi(2) ==1 && phi(3) == 0 && phi(4) == 0)
          fprintf('Interpolationfunction 2 returns expected value.\n')
        else
          test = false;
          fprintf('ERROR: Interpolationfunction 2 returns not expected value.\n')
        end        
      elseif (i ==2 && j ==2)
        if(phi(1) == 0 && phi(2) ==0 && phi(3) == 1 && phi(4) == 0)
          fprintf('Interpolationfunction 3 returns expected value.\n')
        else
          test = false;
          fprintf('ERROR: Interpolationfunction 3 returns not expected value.\n')
        end        
      end

    end
  end
  
  % Check Partition of Unity at various points in domain.
  
   % Erzeuge Punktpaare (xi,eta)
  % Create pointpair in (xi,eta)
  xi = [-1.0:0.1:1.0];
  eta = [-1.0:0.1:1.0];

  % Auswertung der Basisfunktionen an unterschiedlichen Punktepaaren (xi,eta)
  % Evaluate basisfunction at various Points (xi,eta)
  for i = 1: length(xi)
    for j = 1:length(eta)
      
      [phi, dPhidX] = evaluateBasisAndDerivatives(xi(i),eta(j));

      sPhi = sum(phi);
      if abs(sPhi-1.0) > 10e-12
        test = false;
        fprintf('ERROR: Partition of unity is violated!.\n')
      end
      
    end
  end

end

function checkDerInterpolationFct()

  test = true;
  
  % First check two positions for dPhidXi | (0.5,-1)& (0.5,1)
  [phi, dPhidX] = evaluateBasisAndDerivatives(0.5,-1);
  if(dPhidX(1,1) ~= -0.5 || ...
     dPhidX(1,2) ~=  0.5 || ...
     dPhidX(1,3) ~=  0   || ...
     dPhidX(1,4) ~=  0)
      test = false;
      fprintf('ERROR: Derivatives dPhiDxi deviate from expected value!\n')  
  end
  [phi, dPhidX] = evaluateBasisAndDerivatives(0.5,1);
  if(dPhidX(1,1) ~=  0   || ...
     dPhidX(1,2) ~=  0   || ...
     dPhidX(1,3) ~=  0.5 || ...
     dPhidX(1,4) ~= -0.5)
      test = false;
      fprintf('ERROR: Derivatives dPhiDxi deviate from expected value!\n')  
  end
    % First check two positions for dPhidEta | (-1, 0.5)& (1, 0.5)
  [phi, dPhidX] = evaluateBasisAndDerivatives(-1, 0.5);
  if(dPhidX(2,1) ~= -0.5 || ...
     dPhidX(2,2) ~=  0   || ...
     dPhidX(2,3) ~=  0   || ...
     dPhidX(2,4) ~=  0.5)
      test = false;
      fprintf('ERROR: Derivatives dPhidEta deviate from expected value!\n')  
  end
  [phi, dPhidX] = evaluateBasisAndDerivatives(1, 0.5);
  if(dPhidX(2,1) ~=  0   || ...
     dPhidX(2,2) ~= -0.5 || ...
     dPhidX(2,3) ~=  0.5   || ...
     dPhidX(2,4) ~=  0)
      test = false;
      fprintf('ERROR: Derivatives dPhiDxi deviate from expected value!\n')  
  end
  
  if(test == true)
     fprintf('Derivatives dPhiDxi and dPhiDEta match expected values!\n')  
  end
  
end


function plotBasisFunct(basis2plot)

  % Erzeuge Punktpaare (xi,eta)
  % Create pointpair in (xi,eta)
  xi = [-1.0:0.2:1.0];
  eta = [-1.0:0.2:1.0];

  % Auswertung der Basisfunktionen an unterschiedlichen Punktepaaren (xi,eta)
  % Evaluate basisfunction at various Points (xi,eta)
  for i = 1: length(xi)
    for j = 1:length(eta)

      [phi, dPhidX] = evaluateBasisAndDerivatives(xi(i),eta(j));
      resultPhi((i-1)*length(eta) + j, :) =  phi;
      resultdPhidXi((i-1)*length(eta) + j, :) = dPhidX(1,:)';
      resultdPhidEta((i-1)*length(eta) + j, :) = dPhidX(2,:)';

    end
  end

  % Plot all basisfunction of element
  surf(eta,xi, reshape(resultPhi(:,basis2plot), length(xi), length(eta)))
  % Set title of plot
  title(['Basisfunktion ', num2str(basis2plot)]);
  % Set labels
  xlabel('\xi','FontSize', 14,'FontWeight','bold','Position', [-0.3 -1.5 0]);
  ylabel('\eta','FontSize', 14,'FontWeight','bold','Position', [-1.5 -0.3 0]);
  zlabel('\phi','FontSize', 14,'FontWeight','bold');
  % Set view for plot
  view(-45,25)

end
