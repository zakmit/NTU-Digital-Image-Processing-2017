type readraw.m
type writeraw.m

freq_sing = zeros(1, 257);
freq = zeros(1, 257);
H = zeros(256,256);
Picture = readraw("../raw/sample2.raw");
D = uint8(Picture/3);
writeraw(D, "D.raw");
total = 0;
% calculate frequency
for i = 1:256
    for j = 1:256
        freq_sing(1,int16(D(i,j)+1)) = freq_sing(1,int16(D(i,j)+1)) + 1;
        total = total + 1;
    end
end
% sum frequency
freq(1,1) = freq_sing(1,1);
for i = 2:257
    freq(1,i) = freq_sing(1,i) + freq(1,i - 1);
end
%Histogram Equalization
for i = 1:256
    for j = 1:256
        H(i,j) = freq(1,int16(D(i,j)+1))/256;
    end
end
writeraw(H, "H.raw");
%Local HE
len = 3;
L = zeros(256:256);
for i = 1:256
    for j = 1:256
        rank = 0;
        for k = 1:len
            for r = 1:len
                if i + k > 256
                    if j + r > 256
                        if D(i,j) < D(i - k, j - r)
                            rank = rank + 1;
                        end
                    elseif D(i,j) < D(i - k, j + r)
                            rank = rank + 1;
                    end
                elseif j + r > 256
                    if D(i,j) < D(i + k, j - r)
                        rank = rank + 1;
                    end
                elseif D(i,j) < D(i + k, j + r)
                    rank = rank + 1;
                end
            end
        end
        L(i,j) = (len*len - rank) * 255 / len / len;
    end
end
writeraw(L, "L3.raw");
len = 9;
for i = 1:256
    for j = 1:256
        rank = 0;
        for k = 1:len
            for r = 1:len
                if i + k > 256
                    if j + r > 256
                        if D(i,j) < D(i - k, j - r)
                            rank = rank + 1;
                        end
                    elseif D(i,j) < D(i - k, j + r)
                            rank = rank + 1;
                    end
                elseif j + r > 256
                    if D(i,j) < D(i + k, j - r)
                        rank = rank + 1;
                    end
                elseif D(i,j) < D(i + k, j + r)
                    rank = rank + 1;
                end
            end
        end
        L(i,j) = (len*len - rank) * 255 / len / len;
    end
end
writeraw(L, "L9.raw");
histogram(L);
%Log Transform
alpha = 10;
G = uint8(log(1+double(D)/256*alpha)/log(2)*255);
writeraw(G, "LT.raw");
%Inverse Log Transform (a = 1)
alpha = 1;
G = uint8((exp(double(D)/256*log(2)) - 1)/alpha*255);
writeraw(G, "ILT.raw");
%Power Transform (p = 1.4)
G = uint8(double(D).^1.4);
writeraw(G, "PT.raw");
histogram(G);
