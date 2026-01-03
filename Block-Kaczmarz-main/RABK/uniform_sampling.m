function J = uniform_sampling(A, t)
%UNIFORM_ROW_SAMPLING Uniform sampling of row blocks


    [m, ~] = size(A);

    if t <= 0 || t > m
        error('Block size t must satisfy 1 <= t <= m.');
    end

 
    num_blocks = ceil(m / t);


    J = cell(num_blocks, 1);

    for k = 1:num_blocks
        % Uniform sampling 
        J{k} = randperm(m, t);
    end
end

