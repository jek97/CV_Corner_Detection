function [xmaxbcb, ymaxbcb, Tbcarb] = black_car_Tmatch_big (picture)
T = double(im2gray(imread("ur_c_s_03a_01_L_0376.png")));
Tbcarb = T(320:460, 530:670);
score = normxcorr2(Tbcarb,picture);
[xmaxbcb, ymaxbcb] = find(score == max(score(:)));
end