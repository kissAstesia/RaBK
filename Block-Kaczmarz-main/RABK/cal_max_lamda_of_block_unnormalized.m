function lamda = cal_max_lamda_of_block_unnormalized(A,J)
num_block = size(J,1);

lst = zeros(num_block,1);

 %%求AJ'  * AJ 的特征值,并对所有J取最大

for i = 1 : num_block
    rows_used = J{i} ; 
    A_J = A(rows_used,:);
    
    W = A_J'  * A_J ;
    char_value = eig(W);
    lamda_MAX = max(char_value); % 每个块的最大lamda
    lst(i) = lamda_MAX;
end


lamda = max(lst);


end
