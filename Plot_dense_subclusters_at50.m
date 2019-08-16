close all
clear all

figure(1)
clf
set(gcf,'Resize','off')
set(figure(1),'position',[7 12 900 600])

for cntr=1:4
    load(['result_bin' num2str(cntr) '.mat']);%Cell array containing all dense clusters
    load(['bin' num2str(cntr) '.mat']); %Indices of largest conncomp at t=50
    
    allind=bin(result{1});
    ii=50;
    part_x=ncread(fullfile('../',['output_' num2str(ii) '.nc']),'particle_x_position');
    part_y=ncread(fullfile('../',['output_' num2str(ii) '.nc']),'particle_y_position');
    subplot(2,2,cntr)
    plot(part_x(bin),part_y(bin),'k.','MarkerSize',4)
    hold on
    for i=1:length(result)
        ploti=bin(result{i});
        plot(part_x(ploti),part_y(ploti),'bo','MarkerSize',6) 
        axis([1 9 1 9])
        allind=union(allind,ploti);
    end
    axis([0 10 0 10])
    title(['Dense subclusters at t=50 in cluster' num2str(cntr)])
    %set(gca,'FontSize',10)
    xlabel('X')
    ylabel('Y')
end
