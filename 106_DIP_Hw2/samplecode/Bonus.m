type readraw.m
type writeraw.m
type Canny_edge.m
type Dilation.m
type Erosion.m

Picture1 = readraw("./raw/sample4.raw");
freq_sing = zeros(1, 257);
freq = zeros(1, 257);
H = zeros(512,512);
total = 0;
Can = Canny_edge(Picture1,10,30);
writeraw(Can, "Bonus1_Canny.raw");
% Close
% Dilation(Minkowski addition)
Dil = Dilation(Can);
writeraw(Dil, "Dil.raw");
Close1 = Erosion(Dil);
writeraw(Close1, "Close1.raw");
Dil = Dilation(Close1);
Dil = Dilation(Dil);
writeraw(Dil, "Dil2.raw");
Close2 = Erosion(Dil);
writeraw(Close2, "Close2.raw");
First = Picture1;
Temp = Picture1;
Temp(Close2 > 30) = 255;
First(Temp < 95) = 0;
writeraw(First, "Bonus1_F.raw")


% calculate frequency
for i = 1:512
    for j = 1:512
        if First(i,j) ~= 0
            freq_sing(1,int16(First(i,j)+1)) = freq_sing(1,int16(First(i,j)+1)) + 1;
            total = total + 1;
        end
    end
end
% sum frequency
freq(1,1) = freq_sing(1,1);
for i = 2:257
    freq(1,i) = freq_sing(1,i) + freq(1,i - 1);
end
%Histogram Equalization
for i = 1:512
    for j = 1:512
        if First(i,j) ~= 0
            H(i,j) = freq(1,int16(First(i,j)+1))/total*256;
        end
    end
end
writeraw(H, "Bonus1_H.raw")
%Bonus 2
Picture2 = readraw("./raw/sample5.raw");
freq_sing = zeros(1, 257);
freq = zeros(1, 257);
H = zeros(512,512);
total = 0;
Can = Canny_edge(Picture2,8,30);
writeraw(Can, "Bonus2_Canny.raw");
% Close
% Dilation(Minkowski addition)
Dil = Dilation(Can);
writeraw(Dil, "Dil_2.raw");
Close1 = Erosion(Dil);
writeraw(Close1, "Close1_2.raw");
Dil = Dilation(Close1);
Dil = Dilation(Dil);
writeraw(Dil, "Dil2_2.raw");
Close2 = Erosion(Dil);
writeraw(Close2, "Close2_2.raw");
First = Picture2;
Temp = Picture2;
Temp(Close2 > 30) = 255;
First(Temp < 50) = 0;
writeraw(First, "Bonus2_F.raw")

% calculate frequency
for i = 1:512
    for j = 1:512
        if First(i,j) ~= 0
            freq_sing(1,int16(First(i,j)+1)) = freq_sing(1,int16(First(i,j)+1)) + 1;
            total = total + 1;
        end
    end
end
% sum frequency
freq(1,1) = freq_sing(1,1);
for i = 2:257
    freq(1,i) = freq_sing(1,i) + freq(1,i - 1);
end
%Histogram Equalization
for i = 1:512
    for j = 1:512
        if First(i,j) ~= 0
            H(i,j) = freq(1,int16(First(i,j)+1))/total*256;
        end
    end
end
writeraw(H, "Bonus2_H.raw")
