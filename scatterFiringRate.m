

speed_thrhld = 5; % cm/s
tt_CA = [2:5,7:9,14,16:21];    



rw_immobile_firing_rate = [];
rw_mobile_firing_rate = [];
vr_immobile_firing_rate = [];
vr_mobile_firing_rate = [];



%% Load data
for date = [31, 1,6,7,13,14,16,20,21]
    date
    [rw_root, vr_root] = Sheldon(date);
    
    rw_data = loadData(rw_root);
    vr_data = loadData(vr_root); % data in ms now
    
    bin_size = 40;
    
    rw_data_bin = ms2Bin(rw_data, bin_size);
    vr_data_bin = ms2Bin(vr_data, bin_size);
    
    
    
    rw_immobile_idx = rw_data_bin.speed < speed_thrhld;
    vr_immobile_idx = vr_data_bin.speed < speed_thrhld;
    
    for tt = 1:size(tt_CA,2)
        rw_immobile_firing_rate = [rw_immobile_firing_rate, sum(sum(rw_data_bin.spike(tt, rw_immobile_idx))) / (sum(rw_immobile_idx)*bin_size/1000)];
        rw_mobile_firing_rate = [rw_mobile_firing_rate, sum(sum(rw_data_bin.spike(tt, not(rw_immobile_idx)))) / (sum(not(rw_immobile_idx))*bin_size/1000)];
        vr_immobile_firing_rate = [vr_immobile_firing_rate, sum(sum(vr_data_bin.spike(tt, vr_immobile_idx))) / (sum(vr_immobile_idx)*bin_size/1000)];
        vr_mobile_firing_rate = [vr_mobile_firing_rate, sum(sum(vr_data_bin.spike(tt, not(vr_immobile_idx)))) / (sum(not(vr_immobile_idx))*bin_size/1000)];
        
    end
end




%% Begin a plot
h = figure;


scatter(rw_immobile_firing_rate, vr_immobile_firing_rate5)

scatter(rw_mobile_firing_rate, vr_mobile_firing_rate)


xlabel('RW TT firing rate (Hz)')
ylabel('VR TT firing rate (Hz)')
set(gca,'xscale','log')
set(gca,'yscale','log')


set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
filename = 'TT_firing_immobile.pdf';
print(h,filename,'-dpdf','-r0')