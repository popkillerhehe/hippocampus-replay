function [new_data_1, new_data_2] = normalizeTwoData(data_1, data_2)
        length_1 = size(data_1.speed,2);
        length_2 = size(data_2.speed,2);
        
    if length_1 == length_2
        new_data_1 = data_1;
        new_data_2 = data_2;
        
    elseif length_1 > length_2

        offset = floor((length_1-length_2)/2);
        new_data_1.spike = data_1.spike(:, offset:offset+length_2-1);
        new_data_1.speed = data_1.speed(offset:offset+length_2-1);
        
        new_data_2 = data_2;

    else
        offset = floor((length_2-length_1)/2);
        new_data_2.spike = data_2.spike(:, offset:offset+length_1-1);
        new_data_2.speed = data_2.speed(offset:offset+length_1-1);
        
        new_data_1 = data_1;        
        
    end

end