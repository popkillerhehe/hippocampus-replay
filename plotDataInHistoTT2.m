function []=plotDataInHistoTT2(rw_data_bin, vr_data_bin, bin_size, data_str)
%% Loading
% load global variables
if exist('tt_CA','var') == 0
    run('Basic_Sheldon.m');
end

%%

speed_thrhld = 5; % cm/s

rw_immobile_idx = rw_data_bin.speed < speed_thrhld;
vr_immobile_idx = vr_data_bin.speed < speed_thrhld;
    
rw_spike_count_bin = sum(rw_data_bin.spike,1);
vr_spike_count_bin = sum(vr_data_bin.spike,1);

edges = 0:0.4:30;

%% Stationary/Immobile

h = figure;

vr_immobile_firing_rate = mean(vr_data_bin.spike(:,vr_immobile_idx),2);
vr_immobile_normalized_firing_rate = mean(vr_data_bin.spike(:,vr_immobile_idx) ./ repmat(vr_immobile_firing_rate, 1, sum(vr_immobile_idx)));

[vr_values, vr_edges] = histcounts(vr_immobile_normalized_firing_rate, edges);

vr_center = diff(vr_edges)*0.5+vr_edges(1:length(vr_edges)-1);
vr_values = vr_values/( (bin_size/1000) *(sum(vr_immobile_idx)));   % normalization
h2 = bar(vr_center, vr_values);

h2.EdgeColor = 'none';
h2.FaceColor = vr_color; %[236, 176, 53]./255;
h2.FaceAlpha = 0.5;
h2.EdgeColor = [1, 1, 1].*0.2;

hold on;

rw_immobile_firing_rate = mean(rw_data_bin.spike(:,rw_immobile_idx),2);
rw_immobile_normalized_firing_rate = mean(rw_data_bin.spike(:,rw_immobile_idx) ./ repmat(rw_immobile_firing_rate, 1, sum(rw_immobile_idx)));

[rw_values, rw_edges] = histcounts(rw_immobile_normalized_firing_rate, edges);


rw_center = diff(rw_edges)*0.5+rw_edges(1:length(rw_edges)-1);
rw_values = rw_values/( (bin_size/1000) *(sum(rw_immobile_idx)));
h1 = bar(rw_center, rw_values);

h1.EdgeColor = 'none';
h1.FaceColor = rw_color; %[17, 116, 186]./255;
h1.FaceAlpha = 0.5;
h1.EdgeColor = [1, 1, 1].*0.2;

rw_legend = sprintf('RW');
vr_legend = sprintf('VR');
legend([h1 h2],{rw_legend,vr_legend})
axis([0 30 0 10])
set(gca,'YScale','log')



xlabel('normalized firing rate')
ylabel('appearance rate (Hz)')

set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
filename = sprintf('histo2_%s_stationary.pdf', data_str);
print(h,filename,'-dpdf','-r0')


%% Mobile

h_mobile = figure;


vr_mobile_firing_rate = mean(vr_data_bin.spike(:,not(vr_immobile_idx)),2);
vr_mobile_normalized_firing_rate = mean(vr_data_bin.spike(:,not(vr_immobile_idx)) ./ repmat(vr_mobile_firing_rate, 1, sum(not(vr_immobile_idx))));

[vr_values, vr_edges] = histcounts(vr_mobile_normalized_firing_rate, edges);

vr_center = diff(vr_edges)*0.5+vr_edges(1:length(vr_edges)-1);
vr_values = vr_values/( (bin_size/1000) *(sum(not(vr_immobile_idx))));
h2 = bar(vr_center, vr_values);

h2.EdgeColor = 'none';
h2.FaceColor = vr_color; %[236, 176, 53]./255;
h2.FaceAlpha = 0.5;
h2.EdgeColor = [1, 1, 1].*0.2;



hold on;

rw_mobile_firing_rate = mean(rw_data_bin.spike(:,not(rw_immobile_idx)),2);
rw_mobile_normalized_firing_rate = mean(rw_data_bin.spike(:,not(rw_immobile_idx)) ./ repmat(rw_mobile_firing_rate, 1, sum(not(rw_immobile_idx))));

[rw_values, rw_edges] = histcounts(rw_mobile_normalized_firing_rate, edges);

rw_center = diff(rw_edges)*0.5+rw_edges(1:length(rw_edges)-1);
rw_values = rw_values/( (bin_size/1000) *(sum(not(rw_immobile_idx))));
h1 = bar(rw_center, rw_values);

h1.EdgeColor = 'none';
h1.FaceColor = rw_color;  %[17, 116, 186]./255;
h1.FaceAlpha = 0.5;
h1.EdgeColor = [1, 1, 1].*0.2;

rw_legend = sprintf('RW');
vr_legend = sprintf('VR');
legend([h1 h2],{rw_legend,vr_legend})
axis([0 30 0 10])
set(gca,'YScale','log')


xlabel('normalized firing rate')
ylabel('appearance rate (Hz)')

set(h_mobile,'Units','Inches');
pos = get(h_mobile,'Position');
set(h_mobile,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
filename = sprintf('histo2_%s_mobile.pdf', data_str);
print(h_mobile,filename,'-dpdf','-r0')


end


