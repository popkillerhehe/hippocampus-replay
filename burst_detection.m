

rw_root = '\\WS4\Data\People\Tsang-Kai\RW\Sheldon\2012-08-06_16-29-50';
vr_root = '\\WS4\Data\People\Tsang-Kai\VR\Sheldon\2012-08-06_14-59-38';

rw_data = loadData(rw_root);
vr_data = loadData(vr_root);

[rw_data, vr_data] = normalizeTwoData(rw_data, vr_data);


bin_size = 40;  

rw_data_bin = ms2Bin(rw_data, bin_size);
vr_data_bin = ms2Bin(vr_data, bin_size);

plotDataInHisto(rw_data_bin, vr_data_bin, '08_06');

%% Detect burst

% go through the sliding window with width = 40ms
spike_threshold = 35;
burst_event = detectBurstEvent(rw_data, bin_size, spike_threshold);
%%


%% Test for Basic Data

plotTimeInterval(722000, 738000, rw_data, burst_event)
