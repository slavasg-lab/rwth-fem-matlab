% In dieser Funktion wird die Startbedingung auf der Plattengeometrie 
% gesetzt und sollte zum Zeitpunkt der Auswertung der E-Tests nicht
% geändert worden sein.
%
%
% In this function, the start condition is set on the plate geometry and 
% it should not have been changed at the point of evaluation of the E-Test.
%
function T0 = setInitialSolution(parameter, mesh)

  if(parameter.initial == 3)
    initialPath = 'InitialData/Initial1.mat';
    load(initialPath);
    idFromMatrix = [1,2];
    tmpT = [];
    for j=1:mesh.numEleInY+1 
      for i=1:mesh.numEleInX+1
        idPixel(1) = round((length(Minp)-1) - ((j-1)/mesh.numEleInY * (length(Minp)-1)));
        idPixel(2) = round(length(Minp) - ((i-1)/mesh.numEleInX * length(Minp)));
        if(idPixel(1) <= 0 )
         idPixel(1) = 1;
        end
        if(idPixel(2) <= 0 )
           idPixel(2) = 1;
        end
        if(double(Minp(idPixel(1),idPixel(2)))>=240);
          tmpV = 0.0;
        elseif(double(Minp(idPixel(1),idPixel(2)))<=10);
          tmpV = 0.5;
        else
          tmpV = 1.0;
        end
        tmpT = [tmpT, 20.0*double(tmpV)+280.0];        
      end
    end
    T0 = tmpT'; 
  elseif(parameter.initial == 1 | parameter.initial == 2);
    % Loop over every mesh Node
    for i=1:mesh.numNodes
     % Fallunterscheidung für Initialösung/ Distinction of case for initial solution
     if(parameter.initial == 2)
       %       % Vorberechnung von Koordinatenshift/ Precompute coordinate shift.
       xs = (mesh.nodes(i,1) - parameter.edgeLength/2);
       ys = (mesh.nodes(i,2) - parameter.edgeLength/2 + parameter.edgeLength/8);
       r = xs^2 + (ys-abs(xs)^(2/3))^2;
       % Setzten der initial Werte für T0/ Set initial values for T0
       if(r <= parameter.edgeLength/4)
        T0(i,1) = 300;
       else
        T0(i,1) = 280;
       end
     else(parameter.initial == 1 );
      % Vorberechnung von Koordinatenshift/ Precompute coordinate shift.
      xs = (mesh.nodes(i,1) - parameter.edgeLength/2);
      ys = (mesh.nodes(i,2) - parameter.edgeLength/2);
      rMax = sqrt((parameter.edgeLength/2)^2 + (parameter.edgeLength/2)^2);
      % Setzten der initial Werte für T0/ Set initial values for T0
      T0(i,1) = 280 + 20 * sin(pi/2* ( abs(sqrt(xs^2 + ys^2) - rMax )/rMax));
     end    
    end    
  end
 
end