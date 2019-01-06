type writeraw.m
type num_to_train.m
type median_filt.m
type compare.m

%A
I1 = zeros(390,125);
I2 = zeros(390,125);
Train = zeros(450,248);
fid=fopen("./raw/sample1.raw",'rb');
if (fid==-1)
    error('can not open imput image filem press CTRL-C to exit \n');
end
pixel=fread(fid,inf, 'uchar');
fclose(fid);
[Y,X]=size(pixel);
Size=(Y*X);
I1(1:Size)=pixel(1:Size);
I1=permute(I1, [2,1]);

fid=fopen("./raw/sample2.raw",'rb');
if (fid==-1)
    error('can not open imput image filem press CTRL-C to exit \n');
end
pixel=fread(fid,inf, 'uchar');
fclose(fid);
[Y,X]=size(pixel);
Size=(Y*X);
I2(1:Size)=pixel(1:Size);
I2=permute(I2, [2,1]);

fid=fopen("./raw/TrainingSet.raw",'rb');
if (fid==-1)
    error('can not open imput image filem press CTRL-C to exit \n');
end
pixel=fread(fid,inf, 'uchar');
fclose(fid);
[Y,X]=size(pixel);
Size=(Y*X);
Train(1:Size)=pixel(1:Size);
Train=permute(Train, [2,1]);
I1(I1 >= 60) = 255;
I1(I1 < 60) = 0;
writeraw(I1, "I1.raw");
I2 = median_filt(3,I2,125,390);
Train(Train >= 60) = 255;
Train(Train < 60) = 0;
I2(I2 >= 80) = 255;
I2(I2 < 80) = 0;
writeraw(I2, "I2.raw");

writeraw(Train, "Train.raw");
%Train
Graph = zeros(248,450);
num = 1;
list = zeros(100,8);
tmp_i = zeros(4);
tmp_j = zeros(4);

flag1 = 0;
for i = 1:248
    for j = 1:450
        if Train(i, j) == 0 && Graph(i, j) == 0
            [x_min, x_max, y_min, y_max] = findbound(Train, i, j, 248, 450);
            list(num, 8) = 0;
            if(num == 32 && flag1 == 0)
                tmp_i(1) = x_min;
                tmp_i(2) = x_max;
                tmp_i(3) = y_min;
                tmp_i(4) = y_max;
                flag1 = 1;
                for r = x_min:x_max
                    for s = y_min:y_max
                        Graph(r,s) = num*10;
                    end
                end
                continue;
            end
            if(num == 32 && flag1 == 1)
                tmp_j(1) = x_min;
                tmp_j(2) = x_max;
                tmp_j(3) = y_min;
                tmp_j(4) = y_max;
                flag1 = 2;
                for r = x_min:x_max
                    for s = y_min:y_max
                        Graph(r,s) = num*10;
                    end
                end
                continue;
            end
            if(num == 66 && flag1 == 2)
                tmp_i(1) = x_min;
                tmp_i(2) = x_max;
                tmp_i(3) = y_min;
                tmp_i(4) = y_max;
                flag1 = 3;
                for r = x_min:x_max
                    for s = y_min:y_max
                        Graph(r,s) = num*10;
                    end
                end
                continue;
            end
            if(num == 37)
                x_min = min(tmp_i(1),x_min);
                x_max = max(tmp_i(2),x_max);
                y_min = min(tmp_i(3),y_min);
                y_max = max(tmp_i(4),y_max);
                list(num, 8) = 1;
            end
            if(num == 38)
                x_min = min(tmp_j(1),x_min);
                x_max = max(tmp_j(2),x_max);
                y_min = min(tmp_j(3),y_min);
                y_max = max(tmp_j(4),y_max);
                list(num, 8) = 1;
            end
            if(num == 66)
                x_min = min(tmp_i(1),x_min);
                x_max = max(tmp_i(2),x_max);
                y_min = min(tmp_i(3),y_min);
                y_max = max(tmp_i(4),y_max);
            end
            if(num == 71)
                list(63, 1) = min(list(63, 1),x_min);
                list(63, 2) = max(list(63, 2),x_max);
                list(63, 3) = min(list(63, 3),y_min);
                list(63, 4) = max(list(63, 4),y_max);
                list(63, 5) = list(63, 2) - list(63, 1);
                list(63, 6) = list(63, 4) - list(63, 3);
                list(63, 7) = 0;
                list(num, 8) = 2;
                num = 0;
                new = zeros(list(63, 2) - list(63, 1) + 1, list(63, 4) - list(63, 3) + 1);
                for r = list(63, 1):list(63, 2)
                    for s = list(63, 3):list(63, 4)
                        new(r - list(63, 1) + 1,s - list(63, 3) + 1) = Train(r,s);
                        if(new(r - list(63, 1) + 1,s - list(63, 3) + 1) < 50)
                            num = num + 1;
                            if(s > list(63, 3) + list(63, 6)/2)
                                list(63, 7) = list(63, 7) - 1;
                            else
                                list(63, 7) = list(63, 7) + 1;
                            end
                        end
                        Graph(r,s) = num*10;
                    end
                end
                list(63, 7) = abs(double(list(63, 7)/num));
                name = char("63.png");
                %imwrite(new, name);
                break;
            end
            list(num, 1) = x_min;
            list(num, 2) = x_max;
            list(num, 3) = y_min;
            list(num, 4) = y_max;
            list(num, 5) = list(num, 2) - list(num, 1);
            list(num, 6) = list(num, 4) - list(num, 3);
            list(num, 7) = 0;
            cal = 0;
            new = zeros(x_max - x_min + 1, y_max - y_min + 1);
            for r = x_min:x_max
                for s = y_min:y_max
                    new(r - x_min + 1,s - y_min + 1) = Train(r,s);
                    if(new(r - list(num, 1) + 1,s - list(num, 3) + 1) < 50)
                        cal = cal + 1;
                        if(s > y_min + list(num, 6)/2)
                            list(num, 7) = list(num, 7) - 1;
                        else
                            list(num, 7) = list(num, 7) + 1;
                        end
                    end
                    Graph(r,s) = num*10;
                end
            end
            list(num, 7) = abs(double(list(num, 7)/cal));
            name = char(num + ".png");
            %imshow(new);
            %imwrite(new, name);
            num = num + 1;
        end
    end
end
writeraw(Graph,"G.raw");

%I1
Graph2 = zeros(125,390);
num = 1;
flag1 = 0;
for i = 1:125
    for j = 1:390
        if I1(i, j) == 0 && Graph2(i, j) == 0
            [x_min, x_max, y_min, y_max] = findbound(I1, i, j, 125, 390);
            dot = 0;
            if(num == 4 && flag1 == 0)
                tmp_i(1) = x_min;
                tmp_i(2) = x_max;
                tmp_i(3) = y_min;
                tmp_i(4) = y_max;
                flag1 = 1;
                for r = x_min:x_max
                    for s = y_min:y_max
                        Graph2(r,s) = num*10;
                    end
                end
                continue;
            end
            if(num == 4)
                x_min = min(tmp_i(1),x_min);
                x_max = max(tmp_i(2),x_max);
                y_min = min(tmp_i(3),y_min);
                y_max = max(tmp_i(4),y_max);
                dot = 1;
            end
            new = zeros(x_max - x_min + 1, y_max - y_min + 1);
            for r = x_min:x_max
                for s = y_min:y_max
                    new(r - x_min + 1,s - y_min + 1) = I1(r,s);
                    Graph2(r,s) = num*10;
                end
            end
            %disp(num);
            most_like = num_to_train(compare(new, Train, list, x_max - x_min + 1, y_max - y_min + 1, dot));
            disp(most_like);
            name = char("i1" + num + ".png");
            %imshow(new);
            imwrite(new, name);
            num = num + 1;
        end
    end
end
writeraw(Graph2,"G_I1.raw");

%I1
Graph2 = zeros(125,390);
num = 1;
flag1 = 0;
for i = 1:125
    for j = 1:390
        if I2(i, j) == 0 && Graph2(i, j) == 0
            [x_min, x_max, y_min, y_max] = findbound(I2, i, j, 125, 390);
            new = zeros(x_max - x_min + 1, y_max - y_min + 1);
            for r = x_min:x_max
                for s = y_min:y_max
                    new(r - x_min + 1,s - y_min + 1) = I2(r,s);
                    Graph2(r,s) = num*10;
                end
            end
            %disp(num);
            most_like = num_to_train(compare(new, Train, list, x_max - x_min + 1, y_max - y_min + 1, 0));
            disp(most_like);
            name = char("I2" + num + ".png");
            %imshow(new);
            imwrite(new, name);
            num = num + 1;
        end
    end
end
writeraw(Graph2,"G_I2.raw");

function [x_min, x_max, y_min, y_max] = findbound(matrix, i_start, j_start, i_num, j_num)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
global record;
record = zeros(i_num,j_num);
[x_min, x_max, y_min, y_max] = find_b(matrix, i_start, j_start, i_start, i_start, j_start, j_start, i_num, j_num);
end

function [x_min, x_max, y_min, y_max] = find_b(matrix, i, j, i_min, i_max, j_min, j_max, i_num, j_num)
global record;
record(i,j) = 1;
if(i < i_min)
    i_min = i;
end

if(i > i_max)
    i_max = i;
end

if(j < j_min)
    j_min = j;
end

if(j > j_max)
    j_max = j;
end

for r = -1:1
    for s = -1:1
        if i + r < 1 || j + s < 1
            break;
        end
        if i + r > i_num || j + s > j_num
            break;
        end
        if matrix(i + r, j + s) == 0 && record(i + r, j + s) == 0
            [xit, xat, yit, yat] = find_b(matrix, i + r, j + s, i_min, i_max, j_min, j_max, i_num, j_num);
            if xit < i_min
                i_min = xit;
            end
            if xat > i_max
                i_max = xat;
            end
            if yit < j_min
                j_min = yit;
            end
            if yat > j_max
                j_max = yat;
            end
        end
    end
end
x_min = i_min;
x_max = i_max;
y_min = j_min;
y_max = j_max;
end
