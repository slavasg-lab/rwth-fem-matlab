% Die Funktion plottet die Lsg zum aktuellen Zeitschritt
% This function is used to plot the solution at the current time step
function plotResult(mesh, T, t)

% Erstellen eines Plots
% Create Figure
figure(33);
% Setzen der geplotteten Werte/ Set name of plottet value
set(33,'Name','Solution')

% Make it a surface plot
surf( reshape(mesh.nodes(:,1), mesh.numEleInX + 1,mesh.numEleInY + 1),reshape(mesh.nodes(:,2), mesh.numEleInX + 1,mesh.numEleInY + 1), reshape(T, mesh.numEleInX + 1,mesh.numEleInY + 1));

% Achsenbeschriftung/ Set labels
xlabel('X-Direction');
ylabel('Y-Direction');
title(['Temperature field: t=' num2str(t) 's']);
colorbar('location','eastoutside');
caxis([280 300])
zlim([279,301])

AZ=0; EL=90;
view(AZ,EL);
drawnow

end