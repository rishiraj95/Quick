clear all
close all
%tplot=[0 10 20 50 80 120];
tplot=80;
scale_factor=2048/10;
ii=0;
x=ncread(fullfile('../',['output_' num2str(ii) '.nc']),'X');
y=ncread(fullfile('../',['output_' num2str(ii) '.nc']),'Y');
[xx yy]=meshgrid(x,y);
%cntr=0;

vort=ncread(fullfile('../',['output_' num2str(ii) '.nc']),'vorticity');
part_x=ncread(fullfile('../',['output_' num2str(ii) '.nc']),'particle_x_position');
part_y=ncread(fullfile('../',['output_' num2str(ii) '.nc']),'particle_y_position');
ens=0.5*(vort.^2);
ens_now=interp2(x,y,ens',part_x,part_y,'spline');
ens_max0=max(ens_now);

figure(39)
set(gcf,'Resize','off')
set(figure(39),'position',[4 4 900 500])

%for i=1:length(tplot)
    ii=tplot;
    vort=ncread(fullfile('../',['output_' num2str(ii) '.nc']),'vorticity');
    ens=0.5*(vort.^2);
%     cntr=cntr+1;
%     subplot(3,2,cntr)
    %imagesc(x,flipud(y),ens'/ens_max0), shading flat
    imagesc(x,y,ens'/ens_max0), shading flat
    colormap hot
    caxis([0 1])
    hold on 
    
    title(num2str(ii))
    yticklabels(num2cell(10-yticks))
    xticklabels(num2cell((0:1:11)))
    set(gca,'FontSize',16)
    xlabel('x')
    ylabel('y')
    drawnow
    hold on
    part_x=ncread(fullfile('../',['output_' num2str(ii) '.nc']),'particle_x_position');
    part_y=ncread(fullfile('../',['output_' num2str(ii) '.nc']),'particle_y_position');
    for k=1:3
        load(['result_bin' num2str(k) '.mat']);%Cell array containing all dense clusters
        load(['bin' num2str(k) '.mat']); %Indices of largest conncomp at t=50
        allind=bin(result{1});
        for i=1:length(result)
            allind=union(allind,bin(result{i}));
        end
        plot(part_x(bin),part_y(bin),'g.','MarkerSize',4)
        plot(part_x(allind),part_y(allind),'bo','MarkerSize',4)
        
    end
%end
   
    
    
    
    