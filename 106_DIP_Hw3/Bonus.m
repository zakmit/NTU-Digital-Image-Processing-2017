type readraw.m
type writeraw.m
type median.m

Bonus_P = readraw("./raw/sample3.raw");

freq_sing = zeros(1, 257);
freq = zeros(1, 257);
H = Bonus_P;
total = 0;
H = max_filter(H, 256, 3); %dilation
H = min_filter(H, 256, 9); %erosion
H = median_filter(H, 256, 3);
H = max_filter(H, 256, 5); %dilation
H = min_filter(H, 256, 5); %erosion

M = H;
M = median_filter(M, 256, 9);
writeraw(M,"M.raw");