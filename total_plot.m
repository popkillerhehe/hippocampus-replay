
% parameters
time_start = 196
RW = false;


% pyramidal neuron ptt > 0.4
% interneuron  ptt<0.4 and firing rate > 5 hz

% vr 536

%% Loading
% load global variables
if exist('tt_CA','var') == 0
    run('Basic_Sheldon.m');
end

if exist('rw_event','var') == 0
    load('rw_event.mat');
end

if exist('vr_event','var') == 0
    load('vr_event.mat');  
end



time_interval = time_start*1000:(time_start+1)*1000;



%% RW or VR

if RW
    % data
    data = rw_data;
    unit_data = rw_unit_data;
    event = rw_event;
    
    % color
    color_default = rw_color;
    color_light = rw_color_light;
    
    % output file name
    filename = sprintf('total_plot_rw_%d.pdf', time_start);
else
    data = vr_data;
    unit_data = vr_unit_data;
    event = vr_event;

    % color
    color_default = vr_color;
    color_light = vr_color_light;
        
    
    filename = sprintf('total_plot_vr_%d.pdf', time_start);
end



%%
active_idx = zeros(size(time_interval));

for i = 1:size(event, 1)
    for j = 1:size(time_interval, 2)
        if (time_interval(j) >= event(i,1)) && (time_interval(j) <= event(i,2))
            active_idx(j) = true;
        end
    end
end



%% Plot

h = figure;
set(h, 'Position', [360 ,  102,   560  , 630]);

%%%
subplot(3,1,1); 
hold all;

plot(time_interval(not(active_idx))./1000, data.position(time_interval(not(active_idx))), '.', 'Color', color_light)
plot(time_interval(find(active_idx))./1000, data.position(time_interval(find(active_idx))), '.', 'Color', color_default)

xlim([time_interval(1)/1000, time_interval(end)/1000]);
ylim([-5 225])
ylabel('Position (cm)')


%% TT
subplot(3,1,2); 
hold all;

for unitCount = 1:size(tt_CA,2)
    spikePos = find(data.spike(unitCount, time_interval) ~= 0);
    for spikeCount = 1:length(spikePos)
        %active_idx(spikeCount)
        if (active_idx(spikePos(spikeCount)) > 0)
            plot(([spikePos(spikeCount) spikePos(spikeCount)] + time_interval(1)).*0.001, ...
                [unitCount-0.4 unitCount+0.4], 'Color', color_default);
        else
            plot(([spikePos(spikeCount) spikePos(spikeCount)] + time_interval(1)).*0.001, ...
                [unitCount-0.4 unitCount+0.4], 'Color', grey);
        end
    end
end
xlim([time_interval(1)/1000, time_interval(end)/1000]);
ylim([0, size(tt_CA,2)+1]);
ylabel('Tetrodes')
xlabel('Time (s)')



%% neurons
subplot(3,1,3); 
hold all;

for unitCount = 1:unit_data.number
    spikePos = find(unit_data.spike(unitCount, time_interval) ~= 0);
    for spikeCount = 1:length(spikePos)
        %active_idx(spikeCount)
        if (active_idx(spikePos(spikeCount)) > 0)
            plot(([spikePos(spikeCount) spikePos(spikeCount)] + time_interval(1)).*0.001, ...
                [unitCount-0.4 unitCount+0.4], 'Color', color_default);
        else
            plot(([spikePos(spikeCount) spikePos(spikeCount)] + time_interval(1)).*0.001, ...
                [unitCount-0.4 unitCount+0.4], 'Color', grey);
        end
    end
end

xlim([time_interval(1)/1000, time_interval(end)/1000]);
ylim([0, unit_data.number+1]);
ylabel('Neurons')
xlabel('Time (s)')



%% output
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])

%print(h, filename, '-dpdf', '-r0')
