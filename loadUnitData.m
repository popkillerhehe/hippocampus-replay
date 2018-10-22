function outputData = loadUnitData(Root)

%% Calculate the number of unit

unit_number = 0;

for tt = 1:22
    for unit = 1:5
        data_name = sprintf('TT%d_u0%d.mat', tt, unit);
        fl = fullfile(Root, data_name);
        
        
        if(exist(fl, 'file'))
            unit_number = unit_number + 1;
        end
    end
end

%% Load data
Basic_file = load(fullfile(Root, 'bdata.mat'));
Time = idivide(uint64(Basic_file.Time), uint64(1000));   % ms
Time_duration = Time(end)-Time(1)+1;
spike_ms = zeros(unit_number, Time_duration);

unit_idx = 1;

for tt = 1:22
    for unit = 1:5
        data_name = sprintf('TT%d_u0%d.mat', tt, unit);
        fl = fullfile(Root, data_name);
        
        
        if(exist(fl, 'file'))
            
            Loaded_file = load(fl);
            %spike_times_ms = Loaded_file.spike_times;
            spike_times_ms = idivide(uint64(Loaded_file.spike_times), uint64(1000));

            for i = 1:size(spike_times_ms,1)
                if spike_times_ms(i) >= Time(1)
                    idx_ms = spike_times_ms(i) - Time(1)+1;
                    if idx_ms <= Time_duration
                        spike_ms(unit_idx, idx_ms) = spike_ms(unit_idx, idx_ms) + 1;
                    end
                end
            end
            
            unit_idx = unit_idx + 1;
        end
    end
end


%% Output finalization
outputData.spike = spike_ms;
outputData.number = unit_number;

end