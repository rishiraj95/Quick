clear all
close all

data_dir='/RAID2/mmstastn/aguos_particles/';


load('result_bin1.mat');%Cell array containing all dense bins
load('bin1.mat'); %Indices of largest conncomp at t=50
bin1_dc=bin(result{1});

for i=1:length(result)
    bin1_dc=union(bin1_dc,bin(result{i}));
end

load('result_bin2.mat');%Cell array containing all dense bins
load('bin2.mat'); %Indices of largest conncomp at t=50
bin2_dc=bin(result{1});

for i=1:length(result)
    bin2_dc=union(bin2_dc,bin(result{i}));
end


load('result_bin3.mat');%Cell array containing all dense bins
load('bin3.mat'); %Indices of largest conncomp at t=50
bin3_dc=bin(result{1});   

for i=1:length(result)
    bin3_dc=union(bin3_dc,bin(result{i}));
end

trange=50:140;
%pd stands for particle displacement
bin1_pd=zeros(length(bin1_dc),length(trange));
bin2_pd=zeros(length(bin2_dc),length(trange));
bin3_pd=zeros(length(bin3_dc),length(trange));

part_x50=ncread(fullfile([data_dir 'output_50.nc']),'particle_x_position');
part_y50=ncread(fullfile([data_dir 'output_50.nc']),'particle_y_position');
cntr=0;

for ii=trange
    cntr=cntr+1;
    part_x=ncread(fullfile([data_dir ['output_' num2str(ii) '.nc']]),'particle_x_position');
    part_y=ncread(fullfile([data_dir ['output_' num2str(ii) '.nc']]),'particle_y_position');
    x_disp=min(abs(part_x-part_x50),10-abs(part_x-part_x50));
    y_disp=min(abs(part_y-part_y50),10-abs(part_y-part_y50));
   
   bin1_pd(:,cntr)=sqrt(x_disp(bin1_dc).^2+y_disp(bin1_dc).^2);
   bin2_pd(:,cntr)=sqrt(x_disp(bin2_dc).^2+y_disp(bin2_dc).^2);
   bin3_pd(:,cntr)=sqrt(x_disp(bin3_dc).^2+y_disp(bin3_dc).^2);
end


figure(1)

plot(trange,mean(bin1_pd,1),'r','LineWidth',2)
hold on
plot(trange,mean(bin2_pd,1),'b','LineWidth',2)
plot(trange,mean(bin3_pd,1),'k','LineWidth',2)
xlabel('Output time')
ylabel('Displacement averaged over particles')
legend('DC 1','DC 2', 'DC3','location','southeast')




    



