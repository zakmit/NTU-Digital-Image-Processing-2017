function outputArg1 = swap_text(matrix,num,value,texture,texture_numx, texture_numy)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
outputArg1 = zeros(num,num);
i = 1;
while i < num
    j = 1;
    while j < num
        for r = 1:texture_numx
            for s = 1:texture_numy
                if i + r > num || j + s > num
                    break;
                end
                if matrix(i + r, j + s) == value
                    outputArg1(i + r, j + s) = texture(r,s);
                    matrix(i + r, j + s) = -3;
                end
            end
        end
        j = j + texture_numy;
    end
    i = i + texture_numx;
end
end
