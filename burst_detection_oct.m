
%% Loading data


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

rw_bin_spike_thrhld = mean(rw_data_bin.spike,2)+ 3*std(rw_data_bin.spike')';
vr_bin_spike_thrhld = mean(vr_data_bin.spike,2)+ 3*std(vr_data_bin.spike')';



%% Sliding windows
speed_thrhld = 5; % cm/s
location_thrhld = 5; % cm
window_size = 40; % ms

rw_active_ms = sliding_window(rw_data, window_size, speed_thrhld, location_thrhld, rw_bin_spike_thrhld);
vr_active_ms = sliding_window(vr_data, window_size, speed_thrhld, location_thrhld, vr_bin_spike_thrhld);


%% Candidate event
window_gap = 40; % ms
window_max = 400; % ms

rw_event = find_candidate_event(rw_active_ms, window_size, window_gap, window_max);
vr_event = find_candidate_event(vr_active_ms, window_size, window_gap, window_max);

