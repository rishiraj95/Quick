%% This code is a tutorial code for application of the QUICK dense sub-cluster algorithm

% uncoimment if you want to clear graphics and workspace
%clear all, close all


% These paramaters set the output at which we want to see the clusters
tout=50;
% This is for finding the clusters, and sets the number of clusters you want to find
lbin=6;
% This sets the data directory
%data_dir='/RAID2/mmstastn/aguos_particles/output_grid_ip_eps40/';
data_dir='/RAID2/mmstastn/aguos_particles/';
%data_dir='/RAID2/mmstastn/aguos_particles/output_grid_eps40/';
% set the number of particles and initialize matrix
numps=ncread(fullfile([data_dir 'output_101.nc']),'num_particles');
numps=double(numps);
cum_adjmat=sparse(numps,numps);

% loop over outputs to cacluate the cumulative adjacency matrix
for ii=1:tout
  load(fullfile('../Adjacency/eps_40%',['adjmat_' num2str(ii) '.mat']));
  %load(fullfile('../Adjacency/eps_60%',['adjmat_' num2str(ii) '.mat']));
  cum_adjmat=double(cum_adjmat|myadj);
end
cum_adjmat=cum_adjmat-diag(diag(cum_adjmat));
% build the graph
G=graph(cum_adjmat);
%% This is for computing the clusters live
%{
bins=conncomp(G);
startbinsi=cell(lbin,1);

maxbins=max(bins);
for i=1:maxbins
    binpop(i)=sum(bins==i);
end
[binsort,binsorti]=sort(binpop,'descend');

for topi=1:lbin
 binnowi=find(bins==binsorti(topi));
 startbinsi{topi}=binnowi;
end

partnow=startbinsi{1};
%}
%% This assumes you've done and stored the computation already
load('cluster1_eps40.mat');
Gnow=subgraph(G,partnow);
disp(length(partnow));
% These are the key parameters for the Quick algorithm
minsize=20;
gamma=0.3;

% This is what you need to make Quick run
X=[];
deg=degree(Gnow);
candX=find(deg>=(gamma*(minsize-1)));

[result,check]=Quick(Gnow,X,candX,gamma,minsize);
% add a commented out save command here

%% This is for plotting
ii=50;
part_x=ncread(fullfile('../',['output_' num2str(ii) '.nc']),'particle_x_position');
part_y=ncread(fullfile('../',['output_' num2str(ii) '.nc']),'particle_y_position');
figure(2)
clf
plot(part_x(partnow),part_y(partnow),'k.','MarkerSize',4)
hold on
for i=1:length(result)
ploti=partnow(result{i});
plot(part_x(ploti),part_y(ploti),'bo','MarkerSize',6)
%axis([1.75 8.25 2.5 7.5])
grid on
end
drawnow

