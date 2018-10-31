
function active_ms = sliding_window(data, window_size, speed_thrhld, location_thrhld, bin_spike_thrhld)

active_ms = zeros(size(data.spike,2), 1);   % for plot

for t = 1:size(data.spike,2)-window_size+1
        
    % speed
    if max(data.speed(:, t:t+window_size-1)) < speed_thrhld
        
        %window_position = data.position(:, t:t+window_size-1);
        window_position = data.position(t:t+window_size-1);
        % position: close enough to the end points
        if max(max(min(window_position, 220 - window_position))) <= location_thrhld

            % active TT: at least 1/3 TT is active
            if sum(sum(data.spike(:, t:t+window_size-1),2) > bin_spike_thrhld) > 5 %%%%%% THRESHOLD!!!!!
                active_ms(t) = 1;
            end
        end
        
    end 
end
end
