
%% Loading data

%LoadBasicParameter();

date = 1;
[rw_root, vr_root] = Sheldon(date);

rw_data = loadData(rw_root);
vr_data = loadData(vr_root); % data in ms now

rw_unit_data = loadUnitData(rw_root);
vr_unit_data = loadUnitData(vr_root);




%% TT statistics
% in order to determine whether is active

bin_size = 40;  %ms

rw_data_bin = ms2Bin(rw_data, bin_size);
vr_data_bin = ms2Bin(vr_data, bin_size);

% rw_bin_spike_thrhld = mean(rw_data_bin.spike,2)+ 3*std(rw_data_bin.spike')';
% vr_bin_spike_thrhld = mean(vr_data_bin.spike,2)+ 3*std(vr_data_bin.spike')';

rw_avg_firing_rates = mean(rw_data_bin.spike,2);
vr_avg_firing_rates = mean(vr_data_bin.spike,2);

%% Histogram

plotDataInHisto(rw_data_bin, vr_data_bin, bin_size, '08_07');
plotDataInHistoTT2(rw_data_bin, vr_data_bin, bin_size, '08_07');
plotDataInHistoTT3(rw_data_bin, vr_data_bin, bin_size, '08_07');



%% Sliding windows
speed_thrhld = 5; % cm/s
location_thrhld = 5; % cm
window_size = 40; % ms

normalized_thrhld = 15;  % decided from the histogram
                         % rw=15, vr=10

rw_active_ms = sliding_window2(rw_data, window_size, rw_avg_firing_rates, speed_thrhld, location_thrhld, normalized_thrhld);
vr_active_ms = sliding_window2(vr_data, window_size, vr_avg_firing_rates, speed_thrhld, location_thrhld, normalized_thrhld);


%% Candidate event
window_gap = 20; %40; % ms
window_max = 400; % ms

rw_event = find_candidate_event(rw_active_ms, window_size, window_gap, window_max);
vr_event = find_candidate_event(vr_active_ms, window_size, window_gap, window_max);

save('rw_event.mat','rw_event');
save('vr_event.mat','vr_event');  

dlmwrite('rw_event.csv', rw_event, 'precision', '%i'); % output csv files that can be used beyond Matlab
dlmwrite('vr_event.csv', vr_event, 'precision', '%i');

%% Waveform

rw_event_waveform = waveform_of_events(rw_event, rw_root);
vr_event_waveform = waveform_of_events(vr_event, vr_root);

[rw_peak, rw_width] = waveform_process(rw_event_waveform);
[vr_peak, vr_width] = waveform_process(vr_event_waveform);


