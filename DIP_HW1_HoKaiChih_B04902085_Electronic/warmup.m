type readrawRGB.m
type writeraw.m
Picture = readrawRGB("./raw/sample1.raw");
Pic = readraw("./raw/sample2.raw");
B = zeros(256, 256);
for i = 1:256
    for j = 1:256
        B(i,j) = (int16(Picture(i,j,1)) + int16(Picture(i,j,2)) + int16(Picture(i,j,3)))/3;
    end
end
writeraw(B.', "B.raw");