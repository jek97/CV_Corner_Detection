function [xmaxbcs, ymaxbcs, Tbcars] = black_car_Tmatch_small (picture)
T = double(im2gray(imread("ur_c_s_03a_01_L_0376.png")));
Tbcars = T(360:420, 570:630);
score = normxcorr2(Tbcars,picture);
[xmaxbcs, ymaxbcs] = find(score == max(score(:)));
end