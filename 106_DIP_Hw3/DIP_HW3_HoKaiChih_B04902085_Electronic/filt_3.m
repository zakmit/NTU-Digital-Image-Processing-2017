function outputArg1 = filt_3(Matrix, num, filt)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
outputArg1 = zeros(num,num);
for i = 1:num               %odd
    for j = 1:num
        G_matrix = zeros(3,3);
        for r = -1:1
            for s = -1:1
                p = i + r;
                q = j + s;
                if(p > num || p < 1)
                    p = i - r;
                end
                if(q > num || q < 1)
                    q = j - s;
                end
                G_matrix(2 + r, 2 + s) = Matrix(p,q);
            end
        end
        outputArg1(i,j) = sum(sum(G_matrix.*filt));
    end
end
end

