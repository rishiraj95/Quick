close all
clear all

load('result_bin3.mat');%Cell array containing all dense clusters
load('bin3.mat'); %Indices of largest conncomp at t=50
allind=bin3(result{1});

figure(1)
clf
set(gcf,'Resize','off')
set(figure(1),'position',[7 12 1400 900])
ii=50;
part_x=ncread(fullfile('../',['output_' num2str(ii) '.nc']),'particle_x_position');
part_y=ncread(fullfile('../',['output_' num2str(ii) '.nc']),'particle_y_position');
plot(part_x(bin3),part_y(bin3),'k.','MarkerSize',4)
hold on
for i=1:length(result)
    ploti=bin3(result{i});
    plot(part_x(ploti),part_y(ploti),'bo','MarkerSize',6) 
    axis([1 9 1 9])
    allind=union(allind,ploti);
end
axis([0 10 0 10])
title('Dense clusters at ii=50 bin3')


tout=[60 80 100 120];
cntr=0;
figure(2)
clf
set(gcf,'Resize','off')
set(figure(2),'position',[7 12 1400 900])
for i=1:length(tout)
    ii=tout(i);
      hold off
    part_x=ncread(fullfile('../',['output_' num2str(ii) '.nc']),'particle_x_position');
    part_y=ncread(fullfile('../',['output_' num2str(ii) '.nc']),'particle_y_position');
    cntr=cntr+1;
    subplot(2,2,cntr)
    plot(part_x(bin3),part_y(bin3),'k.','MarkerSize',4)
    hold on
    plot(part_x(allind),part_y(allind),'bo','MarkerSize',4)
    axis([0 10 0 10])
    title([num2str(ii) 's'])
    xlabel('X')
    ylabel('Y')
    drawnow
    %pause(0.2)
end
    
    
    
    
    