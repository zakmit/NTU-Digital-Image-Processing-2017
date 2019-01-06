function G = Dilation(In_Graph)
%   Dilation(Minkowski addition) - Dilation the image
%	Usuage  : G=Dilation(In_Graph)
    Dil = zeros(512,512);
    Dil(In_Graph > 10) = 1;
    new = Dil;
    for i = 1:512
        for j = 1:512
            if Dil(i,j) == 1
                if (i + 1 <= 512)
                    new(i + 1,j) = 1;
                    if(j + 1 <= 512)
                        new(i + 1,j + 1) = 1;
                    end
                end
                if (j + 1 <= 512)
                    new(i,j + 1) = 1;
                end
                if (j + 2 <= 512)
                    new(i,j + 2) = 1;
                end
            end
        end
    end
    G = new*255;
end