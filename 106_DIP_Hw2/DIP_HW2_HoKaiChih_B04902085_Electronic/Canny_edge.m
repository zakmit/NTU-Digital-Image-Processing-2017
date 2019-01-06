function G=Canny_edge(In_Graph, threshold1, threshold2)
%Canny_edge - Do Canny Edge Detector on In_Graph
%	Usuage  : G=Canny_edge(In_Graph, threshold1, threshold2)
%threshold1 for Hysteretic thresholding's candidate
%threshold2 for Hysteretic thresholding's Edge

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
                    G_matrix(2 + r, 2 + s) = In_Graph(p,q);
                end
            end
            Gau(i,j) = sum(sum(G_matrix.*LPF2));
        end
    end
    P9PC = zeros(512,512);
    theta = zeros(512,512);
    P9R_P = zeros(512,512); %Prewitt
    P9C_P = zeros(512,512); %Prewitt
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
            K_reg = 1;
            P9R_P(i,j) = abs((Gau(l,r) + K_reg*Gau(l,j) + Gau(l,s) - Gau(v,r) - K_reg*Gau(v,j) - Gau(v,s))/(K_reg + 2));
            P9C_P(i,j) = abs((Gau(v,r) + K_reg*Gau(i,r) + Gau(l,r) - Gau(v,s) - K_reg*Gau(i,s) - Gau(l,s))/(K_reg + 2));
            theta(i,j) = atan(P9C_P(i,j)/P9R_P(i,j));
        end
    end
    P9PC = sqrt(P9R_P.^2 + P9C_P.^2);
    %Non-maximal suppression
    P9PC_N = zeros(512,512);
    for i = 1:512
        for j = 1:512
            x1 = int16(i + sin(pi/2 - theta(i,j)));
            y1 = int16(i + cos(pi/2 - theta(i,j)));
            x2 = int16(i - sin(pi/2 - theta(i,j)));
            y2 = int16(i - cos(pi/2 - theta(i,j)));
            if x1 < 1
                x1 = x1 + 2;
            end
            if y1 < 1
                y1 = y1 + 2;
            end
            if x2 < 1
                x2 = x2 + 2;
            end
            if y2 < 1
                y2 = y2 + 2;
            end
            if x1 > 512
                x1 = x1 -2;
            end
            if x2 > 512
                x2 = x2 -2;
            end
            if y1 > 512
                y1 = y1 -2;
            end
            if y2 > 512
                y2 = y2 -2;
            end
            if P9PC(i,j) > P9PC(x1, y1) && P9PC(i,j) > P9PC(x2, y2)
                P9PC_N(i,j) = P9PC(i,j);
            end
        end
    end
    histogram(P9PC_N);
    %Hysteretic thresholding
    Ht = zeros(512,512);
    Ht(P9PC_N >= threshold1) = 1;
    Ht(P9PC_N >= threshold2) = 255;
    for i = 1:512
        for j = 1:512
            if Ht(i,j) == 1
                for r = -1:1
                    for s = -1:1
                        x = i + r;
                        y = j + s;
                        if x > 512 || x < 1
                            x = i - r;
                        end
                        if y > 512 || y < 1
                            y = j - s;
                        end
                        if Ht(x,y) == 255
                            Ht(i,j) = 255;
                            break;
                        end
                    end
                    if Ht(i,j) == 255
                        break;
                    end
                end
            end
        end
    end
    G = Ht;
   end
