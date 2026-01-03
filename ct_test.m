img = imread('astesia.jpg');
img_gray = rgb2gray(img);    % 转成灰度
img_gray = im2double(img_gray);
img_small = imresize(img_gray,[64 64],'bilinear');
imshow(img_small,[]);
axis image;
colorbar;
%% 

x_true = img_small(:);
N = 64;
theta = 0:1:179;   % 投影角度（单位：度）
[A,~,~,~,~,~] = paralleltomo(N, theta);
b = A * x_true;
%% 
x0 = zeros(size(x_true));
x_rec = kaczmarz(A, b, 50);   % AIRTools 自带

figure;
imshow(reshape(x_rec,N,N),[]);
axis image;
colorbar;
title('Reconstruction');

