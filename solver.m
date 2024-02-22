% In dieser Datei wird das LGS gelöst. Dazu werden erst die Systemmatrix
% und die rechte Seite berechnet. Anschließend wird die Lösung geplottet.
%
% This file contains the solution of the LES. In a first step the system
% matrix and the right hand side are computed. The solution is then
% plotted.

function result = solver(parameter, mesh, T0, M, D)

  %%%% Aufbau des Gleichungssystems %%%%

  % Systemmatrix (Ändert sich waehrend der Zeitschritte nicht und kann daher
  % ausserhalb der Schleife berechnet werden)
  % Systemmatrix (Is constant over all time steps)

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %% Ergaenzen Sie den Code / Complete the code
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  K = M/parameter.dt + parameter.lambda * D;
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  % Initialisierung des Unbekanntenvektors mit der Anfangsbedingung.
  % Here the solution vector is initialized with the initial condition.
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %% Ergaenzen Sie den Code / Complete the code
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  T = T0;
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  % Berechnung der Lösung in jedem Zeitschritt.
  % Computation of the solution for every time step
  for t=0:parameter.dt:parameter.tEnd

    
      % Berechnung der rechten Seite f.
      % Computation of the right hand side vector f.
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      %% Ergaenzen Sie den Code / Complete the code
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      f = M/parameter.dt*T;
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

      % Lösung des Gleichungssystems mittels des cgs solvers.
      % Solving the LES with the cgs solver.
      % T: Output; K/f: Input
      [T, flag] = cgs( K, f, [], 50 ); 
      if (flag>0)
        error('Meldung aus Loeser:', 'Der iterative Gleichungsloeser divergiert.'); 
      end                             

      fprintf('t = %4.1f \n', t);
    
    % Plotten jedes vierten Zeitschritts
    % Plot only every 4th time step.
    if ( mod(t,parameter.dt*4)==0)
      plotResult(mesh, T, t);
    end
  end
  
  % Speichern der letzten Lösung in results.
  % Store final solution in result.
  result = T;

  display('Rechnung abgeschlossen.')

end
