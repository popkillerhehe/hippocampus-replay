function []=plotDataInHisto(rw_data_bin, vr_data_bin, data_str)


vr_spike_count_bin = sum(vr_data_bin.spike,1);
rw_spike_count_bin = sum(rw_data_bin.spike,1);

h = figure;

h2 = histogram(vr_spike_count_bin(vr_data_bin.speed <= 5));
h2.BinWidth = 1;
h2.FaceColor = [236, 176, 53]./255;
h2.FaceAlpha = 0.4;

hold on;

h1 = histogram(rw_spike_count_bin(rw_data_bin.speed <= 5));
h1.BinWidth = 1;
h1.FaceColor = [17, 116, 186]./255;
h1.FaceAlpha = 0.4;

legend([h1 h2],{'RW','VR'})
axis([0 60 0 7000])
set(gca,'YScale','log')
xlabel('spikes in 20 ms time bin')
ylabel('# of time bins')

set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
filename = sprintf('histo_%s_stationary.pdf', data_str);
print(h,filename,'-dpdf','-r0')

h = figure;

h2 = histogram(vr_spike_count_bin(vr_data_bin.speed > 5));
h2.BinWidth = 1;
h2.FaceColor = [236, 176, 53]./255;
h2.FaceAlpha = 0.4;

hold on;

h1 = histogram(rw_spike_count_bin(rw_data_bin.speed > 5));
h1.BinWidth = 1;
h1.FaceColor = [17, 116, 186]./255;
h1.FaceAlpha = 0.4;

legend([h1 h2],{'RW','VR'})
axis([0 60 0 7000])
set(gca,'YScale','log')
xlabel('spikes in 20 ms time bin')
ylabel('# of time bins')

set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
filename = sprintf('histo_%s_mobile.pdf', data_str);
print(h,filename,'-dpdf','-r0')


end