
function active_ms = sliding_window2(data, window_size, avg_firing_rates, speed_thrhld, location_thrhld, normalized_thrhld)

active_ms = zeros(size(data.spike,2), 1);   % for plot

for t = 1:size(data.spike,2)-window_size+1
        
    % speed
    if max(data.speed(:, t:t+window_size-1)) < speed_thrhld
        
        %window_position = data.position(:, t:t+window_size-1);
        window_position = data.position(t:t+window_size-1);
        % position: close enough to the end points
        if max(max(min(window_position, 220 - window_position))) <= location_thrhld

            if mean(sum(data.spike(:, t:t+window_size-1),2) ./ avg_firing_rates) > normalized_thrhld
            %data.spike(:, t:t+window_size-1) ./ repmat(avg_firing_rates, 1, window_size);
            % active TT: at least 1/3 TT is active
            %if sum(sum(data.spike(:, t:t+window_size-1),2) > bin_spike_thrhld) > 5 %%%%%% THRESHOLD!!!!!
                active_ms(t) = 1;
            end
        end
        
    end 
end
end
