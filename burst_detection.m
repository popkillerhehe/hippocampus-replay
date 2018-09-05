

rw_root = '\\WS4\Data\People\Tsang-Kai\RW\Sheldon\2012-08-06_16-29-50';
vr_root = '\\WS4\Data\People\Tsang-Kai\VR\Sheldon\2012-08-06_14-59-38';

rw_data = loadData(rw_root);
vr_data = loadData(vr_root);

[rw_data, vr_data] = normalizeTwoData(rw_data, vr_data);


bin_size = 40;  

rw_data_bin = ms2Bin(rw_data, bin_size);
vr_data_bin = ms2Bin(vr_data, bin_size);

plotDataInHisto(rw_data_bin, vr_data_bin, '08_21');

%% Detect burst

% go through the sliding window with width = 40ms
speed_threshold = 5;
spike_threshold = 40;

bin_burst = [];

for i = 1:length(rw_data.speed) - bin_size + 1
    if mean(rw_data.speed(:,i: i + bin_size - 1)) <= speed_threshold
        if sum(sum(rw_data.spike(:,i: i + bin_size - 1))) > spike_threshold
            bin_burst = [bin_burst, i];
        end
    end
    
end


event_start = bin_burst([1,find(diff(bin_burst) > 40)+1]);
event_end = bin_burst([find(diff(bin_burst) > 40), end]);

%%


%% Test for Basic Data

time_start = 11500;%9399;
time_end = 17500;%9432;

my_yellow = [234, 175, 53]./255;
my_blue = [16, 111, 178]./255;
my_red = [215, 83, 38]./255;

nimbus_cloud = [223, 223, 227]./255;

time_axis = (time_start:time_end)./1000;



subplot(2,1,1);
plot(time_axis, rw_data.speed(time_start:time_end), 'Color', my_red);
ylabel('speed (cm/s)')
xlim([time_start/1000, time_end/1000]);
ylim([0 10])

%%%
subplot(2,1,2); 
hold all;

a_1 = 11798 / 1000;
b_1 = 11820 / 1000;
v_1 = [a_1 0; b_1 0; b_1 15; a_1 15];
f = [1 2 3 4];
patch('Faces',f,'Vertices',v_1,'FaceColor',[1 1 1]*0.5, 'EdgeColor', 'none');


a_1 = 15849 / 1000;
b_1 = 15894 / 1000;
v_1 = [a_1 0; b_1 0; b_1 15; a_1 15];
f = [1 2 3 4];
patch('Faces',f,'Vertices',v_1,'FaceColor',[1 1 1]*0.5, 'EdgeColor', 'none');


a_1 = 16939 / 1000;
b_1 = 16944 / 1000;
v_1 = [a_1 0; b_1 0; b_1 15; a_1 15];
f = [1 2 3 4];
patch('Faces',f,'Vertices',v_1,'FaceColor',[1 1 1]*0.5, 'EdgeColor', 'none');

for ttCount = 1:size(tt_CA,2)
    spikePos = find(rw_data.spike(ttCount, time_start:time_end) ~= 0);
    for spikeCount = 1:length(spikePos)
        plot(([spikePos(spikeCount) spikePos(spikeCount)] + time_start).*0.001, ...
            [ttCount-0.4 ttCount+0.4], 'Color', [17, 116, 186]./255);
    end
end
xlim([time_start/1000, time_end/1000]);
ylim([0, size(tt_CA,2)+1]);
ylabel('tetrodes')
xlabel('time (s)')