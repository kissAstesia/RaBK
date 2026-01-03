%随机生成一个m*n 的矩阵，比较
clc;
clear;
m = 100;
n = 50;
t = 20;
A = randn(m,n);
%分块
J = row_partition(A,t);


rows_norm = vecnorm(A,2,2);
v = 1./rows_norm.^2;

e = eig(A'*diag(v)*A);
lamda_min_nz = min(e(e>0));
lamda_block_max = cal_max_lamda_of_block(A,J);
p_rabk = lamda_min_nz*t/lamda_block_max/m;


s = svd(A);
s_min = min(s(s>0));
lamda_max = cal_max_lamda_of_block_unnormalized(A,J);
p_BKP = s_min^2/lamda_max*t/m;

comp_rate = p_BKP/p_rabk;
fprintf('在非归一化矩阵的情况下，块投影方法和RaBK的收敛率比值为：%f',comp_rate);



%下面考虑归一化矩阵
A_normalized = A./ rows_norm;
e2 = eig(A_normalized'*A_normalized);
lamda_min_nz_nor = min(e2(e2>0));
lamda_block_max_nor = cal_max_lamda_of_block_unnormalized(A_normalized,J);
p_rabk_normalized = t*lamda_min_nz_nor/lamda_block_max_nor/m;

s_nor = svd(A_normalized);
s_min_nor = min(s_nor(s_nor>0));
lamda_max_pro_nor = cal_max_lamda_of_block_unnormalized(A_normalized,J);
p_BKP_nor = s_min_nor^2*t/lamda_max_pro_nor/m;

comp_rate_nor = p_BKP_nor/p_rabk_normalized;
fprintf('在归一化矩阵的情况下，块投影方法和RaBK的收敛率比值为：%f',comp_rate_nor);