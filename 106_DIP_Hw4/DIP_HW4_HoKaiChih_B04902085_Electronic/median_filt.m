function out_matrix = median_filt(window,in_matrix,x_num,y_num)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
out_matrix = zeros(x_num,y_num);
for i = 1:x_num               %odd
    for j = 1:y_num
        G_matrix = zeros(1,window*window);
        for r = -(int16(window/2) - 1):(int16(window/2) - 1)
            for s = -(int16(window/2) - 1):(int16(window/2) - 1)
                p = i + r;
                q = j + s;
                if(p > x_num || p < 1)
                    p = i - r;
                end
                if(q > y_num || q < 1)
                    q = j - s;
                end
                G_matrix( 1,((int16(window/2) + r - 1)*window + int16(window/2) + s) ) = in_matrix(p,q);
            end
        end
        out_matrix(i,j) = median(G_matrix);
    end
end
end

