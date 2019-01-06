function outputArg1 = Hole_Filling(matrix, num, G0)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
matrix_c = zeros(num,num);
matrix_c(matrix == 0) = 1;
Gi = G0;
for n = 1:30
    for i = 1:num
        for j = 1:num
            if Gi(i,j) == 1
                for r = -1:1
                    for s = -1:1
                        if r ~= 0 && s ~= 0
                            break
                        end
                        if (i + r <= 256) && i + r > 0
                            if(j + s <= 256 && j + s > 0)
                                Gi(i + r,j + s) = 1;
                            end
                        end
                    end
                end
            end
        end
    end
    Gi = Gi + matrix_c;
    Gi(Gi < 2) = 0;
    Gi(Gi == 2) = 1;
end
outputArg1 = Gi + matrix;
outputArg1(outputArg1 > 0) = 255;
end

