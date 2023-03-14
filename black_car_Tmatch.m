function [xmaxbc, ymaxbc, Tbcar] = black_car_Tmatch (picture)
T = double(im2gray(imread("ur_c_s_03a_01_L_0376.png")));
Tbcar = T(340:440, 550:650);
score = normxcorr2(Tbcar,picture);
[xmaxbc, ymaxbc] = find(score == max(score(:)));
end