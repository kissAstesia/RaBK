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

%%使用RaBK
%确定最佳块数：t_opt = m/norm(A,2)

%A规模太大难以计算


figure;
imshow(reshape(x_rec,N,N),[]);
axis image;

colorbar;
title('Reconstruction');
%% 
%观察生成的矩阵的特征

%%%%%paralleltomo
N = 32;
theta = 0:10:30;      % 角度从0到30
p = 20;          %每个角度的射线数
d = p-1;       %控制第一条到最后一条射线的总宽度，物理上是探测器尺寸
isDisp = 0.05;   % 每条射线暂停 0.05 秒
paralleltomo(N, theta, p, d, isDisp);
%% 

[A,b,x_true] = paralleltomo(32,0,p,d);
spy(A);

%% 
%2026.1.4任务
%1.了解paralleltomo的输出,尤其是通过ismatrix返回大规模算子，搜一下p，d的选取
%2.学下稀疏矩阵的范数计算，思考能够把RaBK应用在上面的测试用例中
%