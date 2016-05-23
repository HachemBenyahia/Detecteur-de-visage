function [M] = normalize(M)
    if(size(M, 3) == 3)
        M = rgb2gray(M);
    end
    M = im2double(M);
    mean = mean2(M);
    std = std2(M);
    M = (M - mean) / std;
end

