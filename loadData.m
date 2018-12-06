function outputData = loadData(Root)

if exist('tt_CA','var') == 0
    run('Basic_Sheldon.m');
end


Basic_file = load(fullfile(Root, 'bdata.mat'));
Time = idivide(uint64(Basic_file.Time), uint64(1000));   % ms
Position = Basic_file.Position;

%% Speed
li_position_ms = interp1(double(Time),double(Position), double(Time(1):Time(end)));

sigma = 20;
sigma3 = 3*sigma;
gaussian_kernel = (1/sqrt(2*pi*sigma*sigma))* exp(-(-sigma3:1:sigma3).^2/(2*sigma*sigma));
gaussian_kernel = gaussian_kernel ./ sum(gaussian_kernel);

s_position_ms = conv(li_position_ms, gaussian_kernel);
s_position_ms = s_position_ms(sigma3+1:end-sigma3);


speed_ms = zeros(1, Time(end)-Time(1)+1);
window_size = 1;
for i=1+window_size:Time(end)-Time(1)+1-window_size
    speed_ms(i) = (s_position_ms(i+window_size) - s_position_ms(i-window_size))/(0.002*window_size);
end

%% Spike
%tt_CA = [2:5,7:9,14,16:21];                         % should check TTadjustment
                                                    % these are for Sheldon


spike_ms = zeros(size(tt_CA,2), Time(end)-Time(1)+1);
for tt = 1:size(tt_CA,2)
    %tt_CA(tt)
    
    data_name = sprintf('TT%d.spike', tt_CA(tt));
    spikeset = loadDotspike(fullfile(Root, data_name));
    
    
    
    all_waveform = mean(spikeset.waveforms,2);
    waveform_reasonable_idx = (max(all_waveform) - mean(all_waveform)) > (mean(all_waveform) - min(all_waveform));
    waveform_idx = reshape(waveform_reasonable_idx, size(waveform_reasonable_idx,3), 1);
    
    spike_times_ms = idivide(uint64(spikeset.primary.times(waveform_idx)), uint64(1000));
    
    for i = 1:size(spike_times_ms,2)
        if spike_times_ms(i) >= Time(1)
            idx_ms = spike_times_ms(i) - Time(1)+1;
            if idx_ms <= Time(end)-Time(1)+1
                spike_ms(tt,idx_ms) = spike_ms(tt,idx_ms) + 1;
            end
        end
    end
end

%% Output finalization
outputData.spike = spike_ms;
outputData.speed = abs(speed_ms);
outputData.position = s_position_ms;
end