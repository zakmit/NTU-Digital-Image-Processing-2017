type readraw.m
type writeraw.m
type filt_3.m
type swap_text.m

%A
I2 = readraw("./raw/sample2.raw");
Laws1 = ones(3,3);
Laws1(2,2) = 4;
Laws1(1,2) = 2;
Laws1(2,1) = 2;
Laws1(3,2) = 2;
Laws1(2,3) = 2;
Laws2 = zeros(3,3);
Laws2(1,1) = 1;
Laws2(1,2) = 2;
Laws2(1,3) = 1;
Laws2(3,1) = -1;
Laws2(3,2) = -2;
Laws2(3,3) = -1;
Laws3 = -Laws1;
Laws3(2,2) = 4;
Laws3(2,1) = 2;
Laws3(2,3) = 2;
Laws4 = Laws1;
Laws4(1,1) = -Laws4(1,1);
Laws4(2,1) = -Laws4(2,1);
Laws4(3,1) = -Laws4(3,1);
Laws4(1,2) = 0;
Laws4(2,2) = 0;
Laws4(3,2) = 0;
Laws5 = zeros(3,3);
Laws5(1,1) = 1;
Laws5(1,3) = -1;
Laws5(3,3) = 1;
Laws5(3,1) = -1;
Laws6 = zeros(3,3);
Laws6(1,1) = -1;
Laws6(2,1) = 2;
Laws6(3,1) = -1;
Laws6(1,3) = 1;
Laws6(2,3) = -2;
Laws6(3,3) = 1;
Laws7 = -Laws1;
Laws7(1,2) = 2;
Laws7(2,2) = 4;
Laws7(3,2) = 2;
Laws8 = -Laws2;
Laws8(1,2) = 2;
Laws8(3,2) = -2;
Laws9 = Laws1;
Laws9(1,2) = -2;
Laws9(2,1) = -2;
Laws9(2,3) = -2;
Laws9(3,2) = -2;
Laws1 = Laws1/36;
Laws2 = Laws2/12;
Laws3 = Laws3/12;
Laws4 = Laws4/12;
Laws5 = Laws5/4;
Laws6 = Laws6/4;
Laws7 = Laws7/12;
Laws8 = Laws8/4;
Laws9 = Laws9/4;
Out1 = filt_3(I2,512,Laws1);
Out2 = filt_3(I2,512,Laws2);
Out3 = filt_3(I2,512,Laws3);
Out4 = filt_3(I2,512,Laws4);
Out5 = filt_3(I2,512,Laws5);
Out6 = filt_3(I2,512,Laws6);
Out7 = filt_3(I2,512,Laws7);
Out8 = filt_3(I2,512,Laws8);
Out9 = filt_3(I2,512,Laws9);
threshold = 39;
T1 = Energy(Out1, 512, threshold);
T2 = Energy(Out2, 512, threshold);
T3 = Energy(Out3, 512, threshold);
T4 = Energy(Out4, 512, threshold);
T5 = Energy(Out5, 512, threshold);
T6 = Energy(Out6, 512, threshold);
T7 = Energy(Out7, 512, threshold);
T8 = Energy(Out8, 512, threshold);
T9 = Energy(Out9, 512, threshold);

Data = zeros(262144,9);
for i = 1:512
    for j = 1:512
        Data((i-1) * 512 + j, 1) = T1(i,j);
        Data((i-1) * 512 + j, 2) = T2(i,j);
        Data((i-1) * 512 + j, 3) = T3(i,j);
        Data((i-1) * 512 + j, 4) = T4(i,j);
        Data((i-1) * 512 + j, 5) = T5(i,j);
        Data((i-1) * 512 + j, 6) = T6(i,j);
        Data((i-1) * 512 + j, 7) = T7(i,j);
        Data((i-1) * 512 + j, 8) = T8(i,j);
        Data((i-1) * 512 + j, 9) = T9(i,j);
    end
end
A = kmeans(Data,3);
K = zeros(512,512);
for i = 1:512
    for j = 1:512
        if A((i-1) * 512 + j) == 1
            K(i,j) = 0;
        elseif A((i-1) * 512 + j) == 2
            K(i,j) = 120;
        else
            K(i,j) = 255;
        end
    end
end

writeraw(K,strcat("K_",int2str(threshold),".raw"));

%B
t1x = 150;
t1y = 120;
t2x = 130;
t2y = 130;
t3x = 130;
t3y = 100;
text1 = zeros(t1x,t1y);
text2 = zeros(t2x,t2y);
text3 = zeros(t3x,t3y);
for i = 1:t1x
    for j = 1:t1y
        text1(i,j) = I2(i,j);
    end
end
for i = 1:t2x
    for j = 1:t2y
        text2(i,j) = I2(i,512 - t2y + j);
    end
end
for i = 1:t3x
    for j = 1:t3y
        text3(i,j) = I2(512 - t3x + i,512 - t3y + j);
    end
end

value1 = K(1,1);
value2 = K(1,512);
value3 = K(512,512);

A = swap_text(K, 512, value3, text1, t1x, t1y);
B = swap_text(K, 512, value1, text2, t2x, t2y);
C = swap_text(K, 512, value2, text3, t3x, t3y);
Pic = A + B + C;
writeraw(Pic,"2B.raw");

