%reproducing the 4.2 figure
addpath ('../exercise1');%might use function in that folder

data = [5 3 0 1 -1 -3 5 0 -4 -4;
       -2 -1 0 0 1 4 -3 1 5 3;
       0 1 4 -1 0 5 5 -5 -3 -3;
        0 2 3 0 -1 3 3 -7 -2 0;
       3 4 -2 1 3 -3 -3 2 0 0]';

[U, D] = pca (data);

data_prime = data * U (:, end-2: end);

scatter (data_prime (:, 1), data_prime (:, 2), 'o');

U
D