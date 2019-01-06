type readraw.m
type writeraw.m
type Canny_edge.m

%(a)
Picture = readraw("./raw/sample3.raw");
%High pass filtering
HPF = ones(3,3);
HPF = -HPF;
HPF(2,2) = 9;
HPF_result = zeros(512,512);
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
        HPF_result(i,j) = sum(sum(G_matrix.*HPF));
    end
end
writeraw(HPF_result, "HPF_result.raw");
%Unsharp Masking
%Low pass
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
%combine
c = 3/5;
C_US = Picture*(c/(2*c-1)) - Gau*(1-c)/(2*c-1);
writeraw(C_US, "C_US.raw");
%(b)
D = zeros(512,512);
for i = 1:512
    for j = 1:512
        if int16(i + 14*cos(j/25 - 47*pi/32) - 5) > 0 && int16(i + 14*cos(j/25 - 47*pi/32) - 5) <= 512
            if int16(j + 14*cos(i/35 - 49*pi/32) - 5) > 0 && int16(j + 14*cos(i/35 - 49*pi/32) - 5) <= 512
                D(int16(i + 14*cos(j/25 - 47*pi/32) - 5),int16(j + 14*cos(i/35 - 49*pi/32) - 5)) = C_US(i,j);
            end
        end
    end
end
writeraw(D, "D.raw");

        