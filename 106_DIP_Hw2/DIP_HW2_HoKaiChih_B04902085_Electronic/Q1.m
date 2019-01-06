type readraw.m
type writeraw.m
type Canny_edge.m

P3R = zeros(512,512);
P3C = zeros(512,512);
P4R = zeros(512,512);
P4C = zeros(512,512);
P9R_P = zeros(512,512); %Prewitt
P9C_P = zeros(512,512); %Prewitt
P9R_S = zeros(512,512); %Sobel
P9C_S = zeros(512,512); %Sobel
Picture = readraw("./raw/sample1.raw");
% 1st order threshold 40 -> good P9P
for i = 1:512
    for j = 1:512
        r = j - 1; %up
        l = i + 1; %right
        s = j + 1; %down
        v = i - 1; %left
        if r < 1
            r = j + 1;
        end
        if v < 1
            v = i + 1;
        end
        if l > 512
            l = i - 1;
        end
        if s > 512
            s = j - 1;
        end
        P3R(i,j) = Picture(i,j) - Picture(i,r);
        P3C(i,j) = Picture(i,j) - Picture(l,j);
        P4R(i,j) = Picture(i,j) - Picture(l,s);
        P4C(i,j) = Picture(i,s) - Picture(l,j);
        K_reg = 1;
        P9R_P(i,j) = abs((Picture(l,r) + K_reg*Picture(l,j) + Picture(l,s) - Picture(v,r) - K_reg*Picture(v,j) - Picture(v,s))/(K_reg + 2));
        P9C_P(i,j) = abs((Picture(v,r) + K_reg*Picture(i,r) + Picture(l,r) - Picture(v,s) - K_reg*Picture(i,s) - Picture(l,s))/(K_reg + 2));
        K_reg = 2;
        P9R_S(i,j) = abs((Picture(l,r) + K_reg*Picture(l,j) + Picture(l,s) - Picture(v,r) - K_reg*Picture(v,j) - Picture(v,s))/(K_reg + 2));
        P9C_S(i,j) = abs((Picture(v,r) + K_reg*Picture(i,r) + Picture(l,r) - Picture(v,s) - K_reg*Picture(i,s) - Picture(l,s))/(K_reg + 2));
    end
end
P3 = sqrt(P3R.^2 + P3C.^2);
P4 = sqrt(P4R.^2 + P4C.^2);
P9P = sqrt(P9R_P.^2 + P9C_P.^2);
P9S = sqrt(P9R_S.^2 + P9C_S.^2);
%histogram(P9P);
P3(P3 < 40) = 0;
P4(P4 < 40) = 0;
P3(P3 >= 40) = 255;
P4(P4 >= 40) = 255;
writeraw(P3, "P3_40.raw");
writeraw(P4, "P4_40.raw");
P9P(P9P < 40) = 0;
P9P(P9P >= 40) = 255;
P9S(P9S < 40) = 0;
P9S(P9S >= 40) = 255;
writeraw(P9P, "P9P_40.raw");
writeraw(P9S, "P9S_40.raw");
% 2nd order threshold (Laplacian impulse response + 8)
LIR_8_S = zeros(512,512);
LIR_8_N = zeros(512,512);
non_sep = ones(3,3);
sep = ones(3,3);
non_sep = -non_sep;
non_sep(2,2) = 8;
non_sep = non_sep/8;
sep(1,1) = -2;
sep(3,1) = -2;
sep(1,3) = -2;
sep(3,3) = -2;
sep(2,2) = 4;
sep = sep/8;
for i = 1:512               %sep
    for j = 1:512
        G_matrix = zeros(3,3);
        for r = -1:1
            for s = -1:1
                p = i + r;
                q = j + s;
                if(p > 512 || p < 1)
                    p = i - r;
                end
                if(q > 512 || q < 1)
                    q = j - s;
                end
                G_matrix(2 + r, 2 + s) = Picture(p,q);
            end
        end
        LIR_8_S(i,j) = sum(sum(G_matrix.*sep));
    end
end

for i = 1:512               %non_sep
    for j = 1:512
        G_matrix = zeros(3,3);
        for r = -1:1
            for s = -1:1
                p = i + r;
                q = j + s;
                if(p > 512 || p < 1)
                    p = i - r;
                end
                if(q > 512 || q < 1)
                    q = j - s;
                end
                G_matrix(2 + r, 2 + s) = Picture(p,q);
            end
        end
        LIR_8_N(i,j) = sum(sum(G_matrix.*non_sep));
    end
end
histogram(LIR_8_N);
LIR_8_N_re = zeros(512,512);
LIR_8_N_re(LIR_8_N >= 13) = 255;
LIR_8_N_re(LIR_8_N <= -13) = 255;
LIR_8_S_re = zeros(512,512);
LIR_8_S_re(LIR_8_S >= 13) = 255;
LIR_8_S_re(LIR_8_S <= -13) = 255;

writeraw(LIR_8_N_re, "LIR_13_N_re.raw");
writeraw(LIR_8_S_re, "LIR_13_S_re.raw");

%LOG
LPF2 = ones(3,3);
LPF2(2,2) = 2;
LPF2 = LPF2/10;
Gau = zeros(512,512);
for i = 1:512               %odd
    for j = 1:512
        G_matrix = zeros(3,3);
        for r = -1:1
            for s = -1:1
                p = i + r;
                q = j + s;
                if(p > 512 || p < 1)
                    p = i - r;
                end
                if(q > 512 || q < 1)
                    q = j - s;
                end
                G_matrix(2 + r, 2 + s) = Picture(p,q);
            end
        end
        Gau(i,j) = sum(sum(G_matrix.*LPF2));
    end
end
LOG_8_S = zeros(512,512);
for i = 1:512               %sep
    for j = 1:512
        G_matrix = zeros(3,3);
        for r = -1:1
            for s = -1:1
                p = i + r;
                q = j + s;
                if(p > 512 || p < 1)
                    p = i - r;
                end
                if(q > 512 || q < 1)
                    q = j - s;
                end
                G_matrix(2 + r, 2 + s) = Gau(p,q);
            end
        end
        LOG_8_S(i,j) = sum(sum(G_matrix.*sep));
    end
end
histogram(LOG_8_S);
LOG_8_S_re = zeros(512,512);
LOG_8_S_re(LOG_8_S >= 5) = 255;
LOG_8_S_re(LOG_8_S <= -5) = 255;
writeraw(LOG_8_S_re, "LOG_8_S_re.raw");
% Canny Edge Detector
Canny1 = Canny_edge(Picture, 30, 40);
writeraw(Canny1, "Canny1.raw");
%(b)
Picture2 = readraw("./raw/sample2.raw");
Canny2 = Canny_edge(Picture2, 33, 40);
writeraw(Canny2, "Canny2.raw")