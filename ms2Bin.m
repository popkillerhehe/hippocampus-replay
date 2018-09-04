
function outputData = ms2Bin(data, bin_size)

tt_CA = [2:5,7:9,14,16:21];    

bin_number = floor(size(data.speed, 2)/bin_size);  

spike_bin = zeros(size(tt_CA,2), bin_number);
speed_bin = zeros(1, bin_number);

for i = 1:bin_number
    spike_bin(:,i) = sum(data.spike(:,bin_size*(i-1)+1:bin_size*i),2);
    speed_bin(i) = mean(data.speed(bin_size*(i-1)+1:bin_size*i));
end

outputData.spike = spike_bin;
outputData.speed = speed_bin;

end
