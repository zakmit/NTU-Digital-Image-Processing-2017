function outputArg1 = compare(new, source, list, x_num, y_num, dot)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
score = zeros(71);
pixel_count = 0;
mi = 0;
for i = 1:x_num
    for j = 1:y_num
        if(new(i,j) < 50)
            pixel_count = pixel_count + 1;
            if(j > y_num/2)
                mi = mi - 1;
            else
                mi = mi + 1;
            end
        end
    end
end
mi = abs(double(mi/pixel_count));

for r = 1:70
    if(dot ~= list(r, 8))
        continue;
    end
    %if(mi > list(r, 7) + 0.2 || mi < list(r, 7) - 0.2)
        %continue;
    %end
    sour_p = zeros(list(r, 2) - list(r, 1) + 1, list(r, 4) - list(r, 3) + 1);
    for l = list(r, 1):list(r, 2)
        for s = list(r, 3):list(r, 4)
            sour_p(l - list(r, 1) + 1,s - list(r, 3) + 1) = source(l,s);
        end
    end
    %res = min(x_num/list(r,5), y_num/list(r,6));
    %# Initializations:
    oldSize = size(sour_p);                   %# Get the size of your image
    newSize = size(new);  %# Compute the new image size
    scale = [newSize(1)/oldSize(1) newSize(2)/oldSize(2)];  %# The resolution scale factors: [rows columns]

    %# Compute an upsampled set of indices:

    rowIndex = min(round(((1:newSize(1))-0.5)./scale(1)+0.5),oldSize(1));
    colIndex = min(round(((1:newSize(2))-0.5)./scale(2)+0.5),oldSize(2));

    %# Index old image to get new image:
    comp_p = sour_p(rowIndex,colIndex,:);
    for i = 1:x_num
        for j = 1:y_num
            %if(mi > list(r, 7) + 0.2 || mi < list(r, 7) - 0.2)
                %continue;
            %end
            %if(pixel_count*4 < list(r,7)*res || pixel_count > list(r,7)*res*4)
                %continue;
            %end
            if( new(i,j) == comp_p(i,j) )
                score(r) = score(r) + 1;
            end
        end
    end
end
%disp(score)
[M,I] = max(score(:));
outputArg1 = I;
end

