%main file for exercise 2

%------Q1-------
disp ('Question 1: reproducing the 4.2 figure')

%reproducing the 4.2 figure
addpath ('../exercise1');%might use function in that folder

data = [5 3 0 1 -1 -3 5 0 -4 -4;
       -2 -1 0 0 1 4 -3 1 5 3;
       0 1 4 -1 0 5 5 -5 -3 -3;
        0 2 3 0 -1 3 3 -7 -2 0;
       3 4 -2 1 3 -3 -3 2 0 0]';

[U, D] = pca (data);
U = fliplr(U) ;
data_prime = data * U(:, 1:2);

figure (1)
clf
%plot the data points
scatter (data_prime (:, 1), data_prime (:, 2), 'o');
hold on
title('Reproduction of figure 4.2')
%plot the coordinates
line([-10, 0; 10, 0], [0, -10; 0, 10], 'Color', 'black', 'LineWidth', ...
     2)

%plot the variables
line([U(:,1)' * 10; zeros(1,length(U(:,1)))], [U(:,2)' * 10; ...
                    zeros(1,length(U(:,2)))], 'Color', 'red')

axis([-10 10 -10 10])

xlabel ('x: First principal component')
ylabel ('y: Second principal component')

saveas (gcf, 'img/reproduct42.png');

%------Q2-------
disp ('Question 2: Proportion of variance explained vs Principal component number')

figure(2)
clf
plot(1:5, cumsum(flipud(diag(D))) / sum(diag(D)), 'o-');

title(['Proportion of variance explained vs Principal component ' ...
       'number'])
xlabel('Principal component number')
ylabel('Proportion of variance explained')

axis([1 5 0 1.01])

saveas (gcf, 'img/variance_explained.png');

%------Q3+4-------
disp ('Question 3&4: quartimax rotation')

disp ('Original matrix:')

A = [-0.9511, 0.9511; -1.6435, -1.6435; 2.3655, 2.3655; -2.9154, ...
     -2.9154; -3.7010 3.7010];
disp (A);

disp ('Performing gradient descent...')

[A_prime, J_rots] = quartimaxRotation (A);

disp ('The rotated matrix:')
disp (A_prime);

figure (3)
clf

plot(1:length(J_rots), J_rots, 'o-');

title('Change of J_{rot} over time')
xlabel('Iteration number')
ylabel('J_{rot}')
saveas (gcf, 'img/J_rot.png');

%--------Q5---------

disp ('Question 5: reproduction of figure 5.1')

A_prime = quartimaxRotation (U (:, 1:2));

data_prime = data * A_prime

figure (4)
clf
%plot the data points
scatter (data_prime (:, 1), data_prime (:, 2), 'o');
hold on
%plot the coordinates
line([-10, 0; 10, 0], [0, -10; 0, 10], 'Color', 'black', 'LineWidth', ...
     2)

%plot the variables
line([A_prime(:,1)' * 10; zeros(1,length(A_prime(:,1)))], [A_prime(:,2)' ...
                    * 10; zeros(1,length(A_prime(:,2)))], 'Color', ...
     'red', 'LineWidth', 2)

axis([-10 10 -10 10])
title ('Reproduction of Figure 5.1')
xlabel ('x: Factor by rotating the first principal component')
ylabel ('y: Factor by rotating the second principal component')

saveas (gcf, 'img/reproduct51.png');
