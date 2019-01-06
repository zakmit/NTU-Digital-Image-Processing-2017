function outputArg1 = Energy(Matrix, num, threshold)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
outputArg1 = zeros(num,num);
for i = 1:num               %odd
    for j = 1:num
        G_matrix = zeros(17,17);
        for r = -(int16(threshold/2) - 1):(int16(threshold/2) - 1)
            for s = -(int16(threshold/2) - 1):(int16(threshold/2) - 1)
                p = i + r;
                q = j + s;
                if(p > num || p < 1)
                    p = i - r;
                end
                if(q > num || q < 1)
                    q = j - s;
                end
                G_matrix(int16(threshold/2) + r, int16(threshold/2) + s) = Matrix(p,q);
            end
        end
        outputArg1(i,j) = sum(sum(G_matrix.*G_matrix));
    end
end
end

