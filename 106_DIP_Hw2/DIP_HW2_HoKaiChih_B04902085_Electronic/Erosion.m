function G = Erosion(In_Graph)
%Erosion - do erosion on image
%Usuage  : G=Erosion(In_Graph)
Ero = zeros(512,512);
Ero(In_Graph > 10) = 1;
new = Ero;
Ero_Fil = ones(3,3);
Ero_Fil(2,2) = 0;
Ero_Fil(3,2) = 0;

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
                G_matrix(2 + r, 2 + s) = Ero(p,q);
            end
        end
        flag = 0;
        for r = 1:3
            for s = 1:3
                if Ero_Fil(r,s) == 1
                    if G_matrix(r,s) == 0
                        flag = 1;
                        break;
                    end
                end
            end
            if(flag == 1)
                break;
            end
        end
        if flag == 1
            new(i,j) = 0;
        end
    end
end
G = new*255;
end

