%clear all

data_dir='/RAID2/mmstastn/aguos_particles/output_perturbed_ip_eps40/';
load('result_pip_eps40_y0_3_t52_bin1.mat');%Cell array containing all dense clusters
load('bin1_perturbed_ip_t52.mat'); %Indices of largest conncomp at t=50
allind=bin1_perturbed_ip(result{1});

for i=1:length(result)
    ploti=bin1_perturbed_ip(result{i});
    allind=union(allind,ploti);
end


tout=([0 10 25 50]);

cntr=0;
figure(2)
clf
set(gcf,'Resize','off')
set(figure(2),'position',[7 12 700 600])
for i=1:length(tout)
    ii=tout(i)
      hold off
    part_x=ncread(fullfile(data_dir,['output_' num2str(ii) '.nc']),'particle_x_position');
    part_y=ncread(fullfile(data_dir,['output_' num2str(ii) '.nc']),'particle_y_position');
    cntr=cntr+1;
    subplot(2,2,cntr)
    plot(part_x(bin1_perturbed_ip),part_y(bin1_perturbed_ip),'k.','MarkerSize',4)
    hold on
    plot(part_x(allind),part_y(allind),'bo','MarkerSize',4)
    axis([0 10 0 10])
    title([num2str(ii)])
    drawnow
    xlabel('X')
    ylabel('Y')
end


