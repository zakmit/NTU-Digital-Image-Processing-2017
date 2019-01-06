type readraw.m
type writeraw.m

Picture = readraw("./raw/sample3.raw");
%Gaussian Noise
Gau1 = normrnd(1,10,[256,256]);
GauP1 = uint8(Picture + Gau1);
writeraw(GauP1, "GauP1.raw");
Gau2 = normrnd(1,20,[256,256]);
GauP2 = uint8(Picture + Gau2);
writeraw(GauP2, "GauP2.raw");
%Salt and pepper noise
Salt1 = 256*rand(256,256);
Salt_Pic1 = Picture;
Salt_Pic1(Salt1 <= 3) = 0;
Salt_Pic1(Salt1 >= 253) = 255;
writeraw(Salt_Pic1, "SaltP1.raw");
%Salt and pepper noise
Salt2 = 256*rand(256,256);
Salt_Pic2 = Picture;
Salt_Pic2(Salt2 <= 5) = 0;
Salt_Pic2(Salt2 >= 250) = 255;
writeraw(Salt_Pic2, "SaltP2.raw");
%Remove noise from G1(3 kinds of LPF, odd or even boundary)
RG = zeros(256,256);
LPF1 = ones(3,3)/9;
LPF2 = ones(3,3);
LPF3 = ones(3,3);
LPF2(2,2) = 2;
LPF2 = LPF2/10;
LPF3(2,2) = 4;
LPF3(1,2) = 2;
LPF3(2,1) = 2;
LPF3(2,3) = 2;
LPF3(3,2) = 2;
LPF3 = LPF3/16;
for i = 1:256               %odd
    for j = 1:256
        G_matrix = zeros(3,3);
        for r = -1:1
            for s = -1:1
                p = i + r;
                q = j + s;
                if(p > 256 || p < 1)
                    p = i - r;
                end
                if(q > 256 || q < 1)
                    q = j - s;
                end
                G_matrix(2 + r, 2 + s) = GauP1(p,q);
            end
        end
        RG(i,j) = sum(sum(G_matrix.*LPF2));
    end
end
writeraw(RG, "RG2_odd.raw");
%Remove noise from S1
RS = zeros(256,256);
for i = 1:256               %odd
    for j = 1:256
        S_matrix = zeros(3,3);
        epsilon_arr = zeros(1,8);
        num = 1;
        for r = -1:1
            for s = -1:1
                if (r == s) && (r == 0)
                    continue;
                end
                p = i + r;
                q = j + s;
                if(p > 256 || p < 1)
                    p = i - r;
                end
                if(q > 256 || q < 1)
                    q = j - s;
                end
                epsilon_arr(num) = Salt_Pic1(p,q);
                num = num + 1;
            end
        end
        avg = mean(epsilon_arr);
        epsilon = std(epsilon_arr);
        if abs(Salt_Pic1(i,j) - avg) > epsilon
            RS(i,j) = avg;
        else
            RS(i,j) = Salt_Pic1(i,j);
        end
    end
end
writeraw(RS, "RS.raw");
%Calculate
MSEsum_S = 0;
MSEsum_G = 0;
for i = 1:256
    for j = 1:256
        MSEsum_S = MSEsum_S + (RS(i,j) - Picture(i,j))^2;
        MSEsum_G = MSEsum_G + (RG(i,j) - Picture(i,j))^2;
    end
end
PSNR_S = 10*log10(255*255*256*256/MSEsum_S)
PSNR_G = 10*log10(255*255*256*256/MSEsum_G)
%2.II
Picture2 = readraw("./raw/sample4.raw");
Result2 = zeros(256,256);

%Edge Detection(Vertical(Column))GC ( j , k ) = F ( j , k ) − F ( j + 1, k )



for i = 1:256               %5
    for j = 1:256
        S_matrix = zeros(5,5);
        epsilon_arr = zeros(1,24);
        num = 1;
        for r = -2:2
            for s = -2:2
                if (r == s) && (r == 0)
                    continue;
                end
                p = i + r;
                q = j + s;
                if(p > 256 || p < 1)
                    p = i - r;
                end
                if(q > 256 || q < 1)
                    q = j - s;
                end
                epsilon_arr(num) = Picture2(p,q);
                num = num + 1;
            end
        end
        avg = mean(epsilon_arr);
        epsilon = std(epsilon_arr);
        if abs(Picture2(i,j) - avg) > epsilon
            Result2(i,j) = avg;
        else
            Result2(i,j) = Picture2(i,j);
        end
    end
end

writeraw(Result2, "Result2_5.raw");

for i = 1:256               %13
    for j = 1:256
        S_matrix = zeros(13,13);
        epsilon_arr = zeros(1,168);
        num = 1;
        for r = -6:6
            for s = -6:6
                if (r == s) && (r == 0)
                    continue;
                end
                p = i + r;
                q = j + s;
                if(p > 256 || p < 1)
                    p = i - r;
                end
                if(q > 256 || q < 1)
                    q = j - s;
                end
                epsilon_arr(num) = Result2(p,q);
                num = num + 1;
            end
        end
        avg = mean(epsilon_arr);
        epsilon = std(epsilon_arr);
        if abs(Result2(i,j) - avg) > epsilon
            Result2(i,j) = avg;
        end
    end
end

writeraw(Result2, "Result2_5+13.raw");

for i = 1:256               %5
    for j = 1:256
        S_matrix = zeros(5,5);
        epsilon_arr = zeros(1,24);
        num = 1;
        for r = -2:2
            for s = -2:2
                if (r == s) && (r == 0)
                    continue;
                end
                p = i + r;
                q = j + s;
                if(p > 256 || p < 1)
                    p = i - r;
                end
                if(q > 256 || q < 1)
                    q = j - s;
                end
                epsilon_arr(num) = Result2(p,q);
                num = num + 1;
            end
        end
        avg = mean(epsilon_arr);
        epsilon = std(epsilon_arr);
        if abs(Result2(i,j) - avg) > epsilon
            Result2(i,j) = avg;
        else
            Result2(i,j) = Result2(i,j);
        end
    end
end


writeraw(Result2, "Result2_5+13+5.raw");

for i = 1:256               %13
    for j = 1:256
        S_matrix = zeros(13,13);
        epsilon_arr = zeros(1,168);
        num = 1;
        for r = -6:6
            for s = -6:6
                if (r == s) && (r == 0)
                    continue;
                end
                p = i + r;
                q = j + s;
                if(p > 256 || p < 1)
                    p = i - r;
                end
                if(q > 256 || q < 1)
                    q = j - s;
                end
                epsilon_arr(num) = Result2(p,q);
                num = num + 1;
            end
        end
        avg = mean(epsilon_arr);
        epsilon = std(epsilon_arr);
        if abs(Result2(i,j) - avg) > epsilon
            Result2(i,j) = avg;
        end
    end
end

writeraw(Result2, "Result2_5+13+5+13.raw");

for i = 1:256               %5
    for j = 1:256
        S_matrix = zeros(5,5);
        epsilon_arr = zeros(1,24);
        num = 1;
        for r = -2:2
            for s = -2:2
                if (r == s) && (r == 0)
                    continue;
                end
                p = i + r;
                q = j + s;
                if(p > 256 || p < 1)
                    p = i - r;
                end
                if(q > 256 || q < 1)
                    q = j - s;
                end
                epsilon_arr(num) = Result2(p,q);
                num = num + 1;
            end
        end
        avg = mean(epsilon_arr);
        epsilon = std(epsilon_arr);
        if abs(Result2(i,j) - avg) > epsilon
            Result2(i,j) = avg;
        else
            Result2(i,j) = Result2(i,j);
        end
    end
end

writeraw(Result2, "Result2.raw");


