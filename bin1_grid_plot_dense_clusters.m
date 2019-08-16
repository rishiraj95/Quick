clear all

data_dir='/RAID2/mmstastn/aguos_particles/output_grid_eps40/';
load('result_grid_eps40_y0_3_t51_bin1.mat');%Cell array containing all dense clusters
load('bin1_grid_ip_t51.mat'); %Indices of largest conncomp at t=50
allind=bin1_grid_ip(result{1});

for i=1:length(result)
    ploti=bin1_grid_ip(result{i});
    allind=union(allind,ploti);
end


tout=([0 10 25 50]);

cntr=0;
figure(1)
clf
set(gcf,'Resize','off')
set(figure(1),'position',[7 12 700 600])
for i=1:length(tout)
    ii=tout(i)
      hold off
    part_x=ncread(fullfile(data_dir,['output_' num2str(ii) '.nc']),'particle_x_position');
    part_y=ncread(fullfile(data_dir,['output_' num2str(ii) '.nc']),'particle_y_position');
    cntr=cntr+1;
    subplot(2,2,cntr)
    plot(part_x(bin1_grid_ip),part_y(bin1_grid_ip),'k.','MarkerSize',4)
    hold on
    plot(part_x(allind),part_y(allind),'bo','MarkerSize',4)
    axis([0 10 0 10])
    title([num2str(ii)])
    drawnow
    xlabel('X')
    ylabel('Y')
end

