
function candidate_event = find_candidate_event(active_ms, window_size, window_gap, window_max)

active_ms_idx = find(active_ms==1);

candidate_event = zeros(size(active_ms_idx,1), 2);

candidate_event(1,1) = active_ms_idx(1);
i = 1;
for t = 2:size(active_ms_idx,1)
    if active_ms_idx(t) - active_ms_idx(t-1) > 2*window_gap
        candidate_event(i,2) = active_ms_idx(t-1) + window_size - 1;
        i = i+1;
        candidate_event(i,1) = active_ms_idx(t);
    end
end
candidate_event(i,2) = active_ms_idx(t) + window_size - 1;


ce_parameter = sum(candidate_event(:,1) ~= 0);
candidate_event = candidate_event(1:ce_parameter, :);

candidate_event = candidate_event(find((candidate_event(:,2) - candidate_event(:,1) ) < window_max), :);
end
