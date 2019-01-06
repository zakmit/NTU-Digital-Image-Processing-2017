function outputArg1 = Erosion(matrix, num)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
outputArg1 = zeros(num,num);
comp = ones(3,3);
for i = 1:num
    for j = 1:num
        count = 0;
        for r = -1:1
            for s = -1:1
                if i + r < 1|| j + s < 1 || i + r > num || j + s > num
                    break
                end
                if comp(2 + r, 2 + s) == 0
                    count = count + 1;
                else
                    if matrix(i + r, j + s) > 0
                        count = count + 1;
                    end
                end
            end
        end
        if count == 9
            outputArg1(i, j) = 255;
        end
    end
end
end

