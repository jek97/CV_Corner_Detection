%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                                            UNIVERSIT DEGLI STUDI DI GENOVA
%                                           COMPUTER VISION: SECOND ASSIGNMENT
%                                                Giacomo Lugano S5400573
%                                              Claudio Tomaiuolo S5630055 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% upload images:
picture(:,:,1) = double(im2gray(imread("ur_c_s_03a_01_L_0376.png")));
picture(:,:,2) = double(im2gray(imread("ur_c_s_03a_01_L_0377.png")));
picture(:,:,3) = double(im2gray(imread("ur_c_s_03a_01_L_0378.png")));
picture(:,:,4) = double(im2gray(imread("ur_c_s_03a_01_L_0379.png")));
picture(:,:,5) = double(im2gray(imread("ur_c_s_03a_01_L_0380.png")));
picture(:,:,6) = double(im2gray(imread("ur_c_s_03a_01_L_0381.png")));

picture1 = double(imread("i235.png"));

% apply the NCC-based segmentation and display the results:
for i = 1 : size(picture,3)
    % apply the Template matching on the red car:
    [xmaxrc, ymaxrc, Trcar] = red_car_Tmatch (picture(:,:,i));
    max_score_rc(i,:) = [ymaxrc-50, xmaxrc-50];
    
    figure;
    subplot(1,2,1), imagesc(Trcar), title('red car template'),colormap gray;
    subplot(1,2,2), imagesc(picture(:,:,i)), title('picture',i), colormap gray;
    hold on;
    plot(max_score_rc(i,1), max_score_rc(i,2), 'r+', 'LineWidth', 1, 'MarkerSize', 5);
    rectangle(Position=[max_score_rc(i,1)-50 max_score_rc(i,2)-50 100 100],EdgeColor='r');
    
    % apply the Template matching with the black car:
    [xmaxbc, ymaxbc, Tbcar] = black_car_Tmatch (picture(:,:,i));
    max_score_bc(i,:) = [ymaxbc-50, xmaxbc-50];
    f1 = @() black_car_Tmatch(picture(:,:,i));
    t(i) = timeit(f1);
    
    figure;
    subplot(1,2,1), imagesc(Tbcar), title('black car template'),colormap gray;
    subplot(1,2,2), imagesc(picture(:,:,i)), title('picture',i), colormap gray;
    hold on;
    plot(max_score_bc(i,1), max_score_bc(i,2), 'r+', 'LineWidth', 1, 'MarkerSize', 5);
    rectangle(Position=[max_score_bc(i,1)-50 max_score_bc(i,2)-50 100 100],EdgeColor='r');
    
    % apply the Template matching with the black car, with differents patch dimensions:
    [xmaxbcs, ymaxbcs, Tbcars] = black_car_Tmatch_small (picture(:,:,i));
    max_score_bc_s(i,:) = [ymaxbcs-30, xmaxbcs-30];
    f2 = @() black_car_Tmatch_small(picture(:,:,i));
    ts(i) = timeit(f2);

    [xmaxbcb, ymaxbcb, Tbcarb] = black_car_Tmatch_big (picture(:,:,i));
    max_score_bc_b(i,:) = [ymaxbcb-70, xmaxbcb-70];
    f3 = @() black_car_Tmatch_big(picture(:,:,i));
    tb(i) = timeit(f3);
    
    figure;
    subplot(1,3,1), imagesc(picture(:,:,i)), title('small black car template'), colormap gray;
    hold on;
    plot(max_score_bc_s(i,1),max_score_bc_s(i,2), 'r+', 'LineWidth', 1, 'MarkerSize', 5);
    rectangle(Position=[max_score_bc_s(i,1)-30 max_score_bc_s(i,2)-30 60 60],EdgeColor='r');

    subplot(1,3,2), imagesc(picture(:,:,i)), title('normal black car template'), colormap gray;
    hold on;
    plot(max_score_bc(i,1),max_score_bc(i,2), 'r+', 'LineWidth', 1, 'MarkerSize', 5);
    rectangle(Position=[max_score_bc(i,1)-50 max_score_bc(i,2)-50 100 100],EdgeColor='r');
    
    subplot(1,3,3), imagesc(picture(:,:,i)), title('big black car template'), colormap gray;
    hold on;
    plot(max_score_bc_b(i,1),max_score_bc_b(i,2), 'r+', 'LineWidth', 1, 'MarkerSize', 5);
    rectangle(Position=[max_score_bc_b(i,1)-70 max_score_bc_b(i,2)-70 140 140],EdgeColor='r');
   
end

% record the average time for each template dimension:
t = mean(t);
ts = mean(ts);
tb = mean(tb);

% Harris corner detection:
[dx, dy, gK, R, Rt, corners] = Harris_corners (picture1);

% displaing the image derivatives:
figure;
subplot(1,2,1), imagesc(dx), title('image derivative along x'), colormap gray;
subplot(1,2,2), imagesc(dy), title('image derivative along y'), colormap gray;

% displaing the Gaussian filter:
figure;
imagesc(gK), title('Gaussian filter'), colormap gray;

% displaing the Harris corner detection results:
figure;
subplot(1,3,1), imagesc(R), title('corner response'), colormap gray;
subplot(1,3,2), imagesc(Rt), title('corner response thresholded'), colormap gray;
subplot(1,3,3), imagesc(picture1), title('image with corners detected'), colormap gray;
hold on;
plot(corners(:,1), corners(:,2), 'Marker','o','MarkerEdgeColor','r');

