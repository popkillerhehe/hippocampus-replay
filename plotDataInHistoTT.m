function []=plotDataInHistoTT(rw_data_bin, vr_data_bin, bin_size)



edges = 0:100;


tt_CA = [2:5,7:9,14,16:21];                         % should check TTadjustment


for i = 1: length(tt_CA)
    vr_spike_count_bin = vr_data_bin.spike(i,:);
    rw_spike_count_bin = rw_data_bin.spike(i,:);
    
    h = figure;
    
    subplot(2,1,1);

    
    [vr_values, vr_edges] = histcounts(vr_spike_count_bin(vr_data_bin.speed <= 5), edges);
    vr_center = diff(vr_edges)*0.5+vr_edges(1:length(vr_edges)-1);
    vr_values = vr_values/( (bin_size/1000) *(sum(vr_data_bin.speed <= 5)));
    h2 = bar(vr_center, vr_values);
    
    h2.EdgeColor = [1,1,1] * 0;
    h2.FaceColor = [236, 176, 53]./255;
    h2.FaceAlpha = 0.4;
    h2.EdgeColor = [1, 1, 1].*0.2;

    hold on;
    
    [rw_values, rw_edges] = histcounts(rw_spike_count_bin(rw_data_bin.speed <= 5), edges);
    rw_center = diff(rw_edges)*0.5+rw_edges(1:length(rw_edges)-1);
    rw_values = rw_values/( (bin_size/1000) *(sum(rw_data_bin.speed <= 5)));
    h1 = bar(rw_center, rw_values);
    
    % h1 = histogram(rw_spike_count_bin(rw_data_bin.speed <= 5));
    % h1.BinWidth = 1;
    h1.EdgeColor = [1,1,1] * 0;
    h1.FaceColor = [17, 116, 186]./255;
    h1.FaceAlpha = 0.4;
    h1.EdgeColor = [1, 1, 1].*0.2;

    
    legend([h1 h2],{'RW','VR'})
    axis([0 20 0 60])
    set(gca,'YScale','log')
    
    
    xlabel('# of spikes in 40 ms time bin')
    ylabel('appearance rate (Hz)')

    
    title_str = sprintf('TT%d\n stationary', tt_CA(i));
    title(title_str)
    
    subplot(2,1,2);

    
    [vr_values, vr_edges] = histcounts(vr_spike_count_bin(vr_data_bin.speed > 5), edges);
    vr_center = diff(vr_edges)*0.5+vr_edges(1:length(vr_edges)-1);
    vr_values = vr_values/( (bin_size/1000) *(sum(vr_data_bin.speed > 5)));
    h2 = bar(vr_center, vr_values);
    
    h2.EdgeColor = [1,1,1] * 0;
    h2.FaceColor = [236, 176, 53]./255;
    h2.FaceAlpha = 0.4;
    
    hold on;
    
    [rw_values, rw_edges] = histcounts(rw_spike_count_bin(rw_data_bin.speed > 5), edges);
    rw_center = diff(rw_edges)*0.5+rw_edges(1:length(rw_edges)-1);
    rw_values = rw_values/( (bin_size/1000) *(sum(rw_data_bin.speed > 5)));
    h1 = bar(rw_center, rw_values);
    
    h1.EdgeColor = [1,1,1] * 0;
    h1.FaceColor = [17, 116, 186]./255;
    h1.FaceAlpha = 0.4;
    
    legend([h1 h2],{'RW','VR'})
    axis([0 20 0 60])
    set(gca,'YScale','log')
    
    
    xlabel('# of spikes in 40 ms time bin')
    ylabel('appearance rate (Hz)')
      
    title('mobile')

    

    
    set(h,'Units','Inches');
    pos = get(h,'Position');
    set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
    filename = sprintf('TT%d.pdf', tt_CA(i));
    print(h,filename,'-dpdf','-r0')

    
end


end


