function outputArg1 = intersection2(num, matrix, comp1, comp2, comp3, comp4)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
outputArg1 = matrix;
for i = 1:num
    for j = 1:num
        count = 0;
        for r = -1:1
            for s = -1:1
                if i + r < 1 || j + s < 1 || i + r > 256 || j + s > 256
                    break
                end
                if comp1(2 + r, 2 + s) == 0
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
        else
            outputArg1(i, j) = 0;
        end
    end
end
for i = 1:num
    for j = 1:num
        count = 0;
        for r = -1:1
            for s = -1:1
                if i + r < 1 || j + s < 1 || i + r > 256 || j + s > 256
                    break
                end
                if comp2(2 + r, 2 + s) == 0
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
        else
            outputArg1(i, j) = 0;
        end
    end
end
for i = 1:num
    for j = 1:num
        count = 0;
        for r = -1:1
            for s = -1:1
                if i + r < 1 || j + s < 1 || i + r > 256 || j + s > 256
                    break
                end
                if comp3(2 + r, 2 + s) == 0
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
        else
            outputArg1(i, j) = 0;
        end
    end
end
for i = 1:num
    for j = 1:num
        count = 0;
        for r = -1:1
            for s = -1:1
                if i + r < 1 || j + s < 1 || i + r > 256 || j + s > 256
                    break
                end
                if comp4(2 + r, 2 + s) == 0
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
        else
            outputArg1(i, j) = 0;
        end
    end
end
end

