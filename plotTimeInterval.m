function []=plotTimeInterval(time_start, time_end, data, burst_event)



my_yellow = [234, 175, 53]./255;
my_blue = [16, 111, 178]./255;
my_red = [215, 83, 38]./255;

nimbus_cloud = [223, 223, 227]./255;

time_axis = (time_start:time_end)./1000;




subplot(2,1,1);
plot(time_axis, data.speed(time_start:time_end), 'Color', my_red);
ylabel('speed (cm/s)')
xlim([time_start/1000, time_end/1000]);
ylim([0 30])

%%%
subplot(2,1,2); 
hold all;

for j=1:size(burst_event,2)
    if (burst_event(2,j) > time_start) || (burst_event(1,j) < time_end)
        a_1 = burst_event(1,j) / 1000;
        b_1 = burst_event(2,j) / 1000;
        v_1 = [a_1 0; b_1 0; b_1 15; a_1 15];
        f = [1 2 3 4];
        patch('Faces',f,'Vertices',v_1,'FaceColor',[1 1 1]*0.75, 'EdgeColor', 'none');
        
    end
end

tt_CA = [2:5,7:9,14,16:21];   

for ttCount = 1:size(tt_CA,2)
    spikePos = find(data.spike(ttCount, time_start:time_end) ~= 0);
    for spikeCount = 1:length(spikePos)
        plot(([spikePos(spikeCount) spikePos(spikeCount)] + time_start).*0.001, ...
            [ttCount-0.4 ttCount+0.4], 'Color', [17, 116, 186]./255);
    end
end
xlim([time_start/1000, time_end/1000]);
ylim([0, size(tt_CA,2)+1]);
ylabel('tetrodes')
xlabel('time (s)')

end