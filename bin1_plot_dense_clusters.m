close all
clear all

load('result_bin1.mat');%Cell array containing all dense clusters
load('bin1.mat'); %Indices of largest conncomp at t=50
allind=bin(result{1});

figure(1)
clf
%set(gcf,'Resize','off')
%set(figure(1),'position',[7 12 1400 900])
ii=50;
part_x=ncread(fullfile('../',['output_' num2str(ii) '.nc']),'particle_x_position');
part_y=ncread(fullfile('../',['output_' num2str(ii) '.nc']),'particle_y_position');
plot(part_x(bin),part_y(bin),'k.','MarkerSize',4)
hold on
for i=1:length(result)
    ploti=bin(result{i});
    plot(part_x(ploti),part_y(ploti),'bo','MarkerSize',6) 
    
    allind=union(allind,ploti);
end
%axis([0 10 0 10])
title('Dense clusters Cluster1 $\epsilon=40\%$ $t=50$ $\gamma=0.25$','interpreter','latex')


%{
tout=[60 80 100 120];
cntr=0;
figure(2)
clf
set(gcf,'Resize','off')
set(figure(2),'position',[7 12 900 700])
for i=1:length(tout)
    ii=tout(i)
      hold off
    part_x=ncread(fullfile('../',['output_' num2str(ii) '.nc']),'particle_x_position');
    part_y=ncread(fullfile('../',['output_' num2str(ii) '.nc']),'particle_y_position');
    cntr=cntr+1;
    subplot(2,2,cntr)
    plot(part_x(bin),part_y(bin),'k.','MarkerSize',4)
    hold on
    plot(part_x(allind),part_y(allind),'bo','MarkerSize',4)
    axis([0 10 0 10])
    title(num2str(ii))
    xlabel('X')
    ylabel('Y')
    set(gca, 'FontSize', 10)
    drawnow
    pause(0.2)
end
%}    
    
    
    
    
