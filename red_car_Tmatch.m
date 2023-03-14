function [xmaxrc, ymaxrc, Trcar] = red_car_Tmatch (picture)
T = double(im2gray(imread("ur_c_s_03a_01_L_0376.png")));
Trcar = T(340:440, 680:780);
score = normxcorr2(Trcar,picture);
[xmaxrc, ymaxrc] = find(score == max(score(:)));
end