% In dieser Funktion werden die Basisfunktionen und ihre Ableitungen an dem
% Gausspunkt mit den Koordinaten (xi,eta) ausgewertet.
% Within this function the basis functions and their derivatives are
% evaluated at the Gausspoint with the coordinates (xi,eta)
% 
%       (eta)^ 
%     (4)    |   (3)       (n+nEleInRow) | .      | (n+1+nEleInRow)
%       o--------o                     --o--------o--
%       |    |   |         (Transfo)     |        |
%    ---|--------|----->     <--->       |        |
%       |    |   |    (xi)               |        |
%       o--------o                     --o--------o--
%     (1)    |   (2)                  (n)|        | (n+1)
%
% Referenzelement                        Element in Omega
%

function [phi, dPhidXi] = evaluateBasisAndDerivatives(xi,eta)

  % Berechnen Sie die Werte der Basisfunktion für Xi und Eta
  % Compute the values of the basis functions at xi and eta
  phi(1) = 0.25 * (1 - xi) * (1 - eta); % TODO: Ergaenzen Sie hier
  phi(2) = 0.25 * (1 + xi) * (1 - eta); % TODO: Ergaenzen Sie hier
  phi(3) = 0.25 * (1 + xi) * (1 + eta); % TODO: Ergaenzen Sie hier
  phi(4) = 0.25 * (1 - xi) * (1 + eta); % TODO: Ergaenzen Sie hier
  
  % Berechnen Sie die Ableitung der Basisfunktionen nach xi, dPhidXi(:,1)
  % Compute the derivatives of the basis with respecht to xi, dPhidXi(:,1)
  dPhidXi(1,1) = -0.25 * (1 - eta);  % TODO: Ergaenzen Sie hier
  dPhidXi(1,2) = 0.25 * (1 - eta); % TODO: Ergaenzen Sie hier
  dPhidXi(1,3) = 0.25 * (1 + eta); % TODO: Ergaenzen Sie hier
  dPhidXi(1,4) = -0.25 * (1 + eta); % TODO: Ergaenzen Sie hier
  
  % Berechnen Sie die Ableitung der Basisfunktionen nach eta, dPhidXi(:,2)
  % Compute the derivatives of the basis with respecht to eta, dPhidXi(:,2)
  dPhidXi(2,1) = -0.25 * (1 - xi);  % TODO: Ergaenzen Sie hier
  dPhidXi(2,2) = -0.25 * (1 + xi); % TODO: Ergaenzen Sie hier
  dPhidXi(2,3) = 0.25 * (1 + xi); % TODO: Ergaenzen Sie hier
  dPhidXi(2,4) = 0.25 * (1 - xi); % TODO: Ergaenzen Sie hier
  
end
