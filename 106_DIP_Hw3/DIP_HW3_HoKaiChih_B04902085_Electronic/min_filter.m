function outputArg1 = min_filter(matrix, num, window)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
outputArg1 = zeros(num,num);
for i = 1:num               %odd
    for j = 1:num
        G_matrix = zeros(1,window*window);
        for r = -(int16(window/2) - 1):(int16(window/2) - 1)
            for s = -(int16(window/2) - 1):(int16(window/2) - 1)
                p = i + r;
                q = j + s;
                if(p > num || p < 1)
                    p = i - r;
                end
                if(q > num || q < 1)
                    q = j - s;
                end
                G_matrix( 1,((int16(window/2) + r - 1)*window + int16(window/2) + s) ) = matrix(p,q);
            end
        end
        A = sort(G_matrix);
        outputArg1(i,j) = A(1,int16(window/5)*2);
    end
end
end