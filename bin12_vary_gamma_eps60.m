clear all
close all

data_dir='/RAID2/mmstastn/aguos_particles/';
ii=50;
figure(25)
set(gcf,'Resize','off')
set(figure(25),'position',[7 12 800 500])
subplot(2,2,1)
load('result_eps60_y0_4_bin1.mat');%Cell array containing all dense clusters
load('bin1.mat'); %Indices of largest conncomp at t=50

part_x=ncread(fullfile(data_dir,['output_' num2str(ii) '.nc']),'particle_x_position');
part_y=ncread(fullfile(data_dir,['output_' num2str(ii) '.nc']),'particle_y_position');
plot(part_x(bin),part_y(bin),'k.','MarkerSize',4)
hold on
for i=1:length(result)
    ploti=bin(result{i});
    plot(part_x(ploti),part_y(ploti),'bo','MarkerSize',4)
end
axis([0 10 1.5 8.5])
title(['Cluster 1, ', '$\gamma=0.4$'],'interpreter','latex','fontsize',16)
drawnow
xlabel('X')
ylabel('Y')



subplot(2,2,2)
load('result_eps60_y0_4_bin2.mat');%Cell array containing all dense clusters
load('bin2.mat');
part_x=ncread(fullfile(data_dir,['output_' num2str(ii) '.nc']),'particle_x_position');
part_y=ncread(fullfile(data_dir,['output_' num2str(ii) '.nc']),'particle_y_position');

plot(part_x(bin),part_y(bin),'k.','MarkerSize',4)
hold on
for i=1:length(result)
    ploti=bin(result{i});
    plot(part_x(ploti),part_y(ploti),'bo','MarkerSize',4)
end
axis([0 10 1.5 8.5])
title(['Cluster 2, $\gamma=0.4$'],'interpreter','latex','fontsize',16)
drawnow
xlabel('X')
ylabel('Y')

figure(25)
set(gcf,'Resize','off')
set(figure(25),'position',[7 12 700 600])
subplot(2,2,3)
load('result_eps60_y0_3_bin1.mat');%Cell array containing all dense clusters
load('bin1.mat'); %Indices of largest conncomp at t=50

part_x=ncread(fullfile(data_dir,['output_' num2str(ii) '.nc']),'particle_x_position');
part_y=ncread(fullfile(data_dir,['output_' num2str(ii) '.nc']),'particle_y_position');
plot(part_x(bin),part_y(bin),'k.','MarkerSize',4)
hold on
for i=1:length(result)
    ploti=bin(result{i});
    plot(part_x(ploti),part_y(ploti),'bo','MarkerSize',4)
end
axis([0 10 1.5 8.5])
title(['Cluster 1, $\gamma=0.3$'],'interpreter','latex','fontsize',16)
drawnow
xlabel('X')
ylabel('Y')




subplot(2,2,4)
load('result_eps60_y0_3_bin2.mat');%Cell array containing all dense clusters
load('bin2.mat');
part_x=ncread(fullfile(data_dir,['output_' num2str(ii) '.nc']),'particle_x_position');
part_y=ncread(fullfile(data_dir,['output_' num2str(ii) '.nc']),'particle_y_position');

plot(part_x(bin),part_y(bin),'k.','MarkerSize',4)
hold on
for i=1:length(result)
    ploti=bin(result{i});
    plot(part_x(ploti),part_y(ploti),'bo','MarkerSize',4)
end
axis([0 10 1.5 8.5])
title(['Cluster 2, ','$\gamma=0.3$'],'interpreter','latex','fontsize',16)
drawnow
xlabel('X')
ylabel('Y')


