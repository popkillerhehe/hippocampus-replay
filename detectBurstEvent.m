function burst_event = detectBurstEvent(data, bin_size, spike_threshold)

speed_threshold = 5;
bin_burst = [];

for i = 1:length(data.speed) - bin_size + 1
    if mean(data.speed(:,i: i + bin_size - 1)) <= speed_threshold
        if sum(sum(data.spike(:,i: i + bin_size - 1))) > spike_threshold
            bin_burst = [bin_burst, i];
        end
    end
    
end

% merge overlap event
event_start = bin_burst([1,find(diff(bin_burst) > 40)+1]);
event_end = bin_burst([find(diff(bin_burst) > 40), end])+ bin_size - 1;

% exclude short event
idx = find(event_end-event_start > 80);
event_start = event_start(idx);
event_end = event_end(idx);

burst_event = [event_start; event_end];



end
