function G = Dilation(In_Graph, num)
%   Dilation(Minkowski addition) - Dilation the image
%	Usuage  : G=Dilation(In_Graph)
    Dil = zeros(num,num);
    Dil(In_Graph > 0) = 1;
    kernel = ones(3,3);
    new = zeros(num,num);
    for i = 1:num
        for j = 1:num
            if Dil(i,j) == 1
                for r = -1:1
                    for s = -1:1
                        if kernel(2 + r, 2 + s) == 0
                            break
                        end
                        if i + r <= num && i + r > 0
                            if j + s <= num && j + s > 0
                                new(i + r,j + s) = 1;
                            end
                        end
                    end
                end
            end
        end
    end
    G = new*255;
end