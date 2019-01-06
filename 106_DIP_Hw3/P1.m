type readraw.m
type writeraw.m
type intersection.m
type intersection2.m
type Erosion.m
type Dilation.m
%A
I1 = readraw("./raw/sample1.raw");
all = ones(3,3);
B = I1 - intersection(256, I1, all);
Graph = zeros(256,256);
writeraw(B,"B.raw");
num = 1;
%B
list = zeros(256,4);
for j = 1:256
    for i = 1:256
        if B(i, j) == 255 && Graph(i, j) == 0
            [x_min, x_max, y_min, y_max] = findbound(B, i, j);
            list(num, 1) = x_min;
            list(num, 2) = x_max;
            list(num, 3) = y_min;
            list(num, 4) = y_max;
            num = num + 1;
            for r = x_min:x_max
                for s = y_min:y_max
                    Graph(r,s) = 255;
                end
            end
        end
    end
end
writeraw(Graph,"G.raw");

%C -- Skeletonize
A_last = I1;
n = 40;
result = zeros(256,256);
G_last = zeros(256,256);
for i = 1:n
    %erosion
    A_last = Erosion(A_last,256);
    %opening
    B_now = Erosion(A_last,256);
    B_now = Dilation(B_now,256);
    G_now = A_last - B_now;
    G_now(G_now < 0) = 0;
    %union
    G_last = G_last + G_now;
    G_last(G_last > 0) = 255;
end
writeraw(G_last,"G_last_40.raw");

function [x_min, x_max, y_min, y_max] = findbound(matrix, i_start, j_start)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
global record;
record = zeros(256,256);
[x_min, x_max, y_min, y_max] = find_b(matrix, i_start, j_start, i_start, i_start, j_start, j_start);
end
 
function [x_min, x_max, y_min, y_max] = find_b(matrix, i, j, i_min, i_max, j_min, j_max)
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
        if i + r > 256 || j + s > 256
            break;
        end
        if matrix(i + r, j + s) > 0 && record(i + r, j + s) == 0
            [xit, xat, yit, yat] = find_b(matrix, i + r, j + s, i_min, i_max, j_min, j_max);
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