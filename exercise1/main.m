%to ensure reproducible result
rng (123456);

N = 1000;

figure (1);
clf;
%##############################
%Question 1
%inmitate the 4 plots
%##############################
disp ('Question 1: approximating the 4 plots ');
%plot 1
data1 = gendata ([0,0], [2,-1; -1, 2], N);

subplot (2,2,1);

scatter (data1 (:,1), data1 (:, 2), '.');

xlim ([-4, 4]);
ylim ([-4, 4]);

hold on;

%plot 2
data2 = gendata ([0,0], [1.8, 0; 0, 1.8], N);

subplot (2,2,2);

scatter (data2 (:,1), data2 (:, 2), '.');

xlim ([-4, 4]);
ylim ([-4, 4]);

hold on;

%plot 3
data3 = gendata ([0,0], [0.8, 0.5; 0.5, 0.8], N);

subplot (2,2,3);

scatter (data3 (:,1), data3 (:, 2), '.');


xlim ([-4, 4]);
ylim ([-4, 4]);

hold on;

%plot 4
data4 = gendata ([0,0], [.8, .7; .7, .8], N);

subplot (2,2,4);

scatter (data4 (:,1), data4 (:, 2), '.');

xlim ([-4, 4]);
ylim ([-4, 4]);

hold on;

disp ('Press any key to continue...')
pause

saveas (gcf, 'img/scatter_points.png');

%##############################
%Question 3 (completed after question 2)
%Plot the principla components of the first two datasets
%##############################
disp ('Question 3: plot the principla components of the first two datasets');
subplot (2, 2, 1);
[U, D] = pca (data1); 

plotv(U * 10, 'r');

subplot (2, 2, 2);
[U, D] = pca (data2);

plotv (U*10, 'r');

subplot (2, 2, 3);
[U, D] = pca (data3);

plotv (U*10, 'r');

subplot (2, 2, 4);
[U, D] = pca (data4);

plotv (U*10, 'r');

saveas (gcf, 'img/eigen_vectors.png');

disp ('Press any key to continue...')
pause

%##############################
%Question 4
%project the data on each of both components
%make a histogram for each component (20 bins)
%compute the variance of each direction and compare it with the covariance matrix
%##############################
disp ('Question 4:');
figure (2);
clf;

[projected_var, projected_data, D] = ProjectedVariance (data1);

projected_var
D

subplot (2, 1, 1); hist (projected_data (:, 1), 20);
subplot (2, 1, 2); hist (projected_data (:, 2), 20);

saveas (gcf, 'img/histogram.png');

disp ('Press any key to continue...')
pause

%##############################
%Question 5
%Artificial data
%##############################
disp ('Question 5....');
U = [1 1; -1 1] ./ sqrt (2); 
D = diag ([1, 3]);

x = repmat(U (1, :), N, 1) .* repmat(randn (N, 1) * sqrt (D (1, 1)), ...
                                     1, 2);
y = repmat(U (2, :), N, 1) .* repmat(randn (N, 1) * sqrt (D (2, 2)), ...
                                     1, 2);

data = (x + y);

figure (3)
clf;
scatter (data (:, 1), data (:, 2), '.');

[U1, D1] =  pca (data);

disp ('True eigenvector (U) and calculated eigenvector (U1) ');
U'
U1

disp ('True eigenvalue (D) and calculated eigenvalue (D1) ');
D
D1

saveas (gcf, 'img/artificial_data.png');

disp ('Press any key to continue...')
pause

%##############################
%Question 6
%Reduce dimension to 1, 
%plot the approximated data and ...
%compare the variance explained and average error 
%##############################

disp ('Question 6....');
figure (4)
clf;

reconstructed = repmat(U (2, :), N, 1) .* repmat(data * U (2, :)', ...
                                                  1, 2);

%the first 50 data rows(original and reconstructed)
x1 = data (1:50, 1);
x2 = reconstructed (1:50, 1);
y1 = data (1:50, 2);
y2 = reconstructed (1:50, 2);

scatter (x1, y1, 'b.');

hold on
scatter (x2, y2, 'r.');

line ([x1'; x2'], [y1'; y2'], 'Color', 'b');

disp ('Error introduced by reconstructing using the second eigen vector');
error1 = sum(sum((data - reconstructed) .^ 2)) / N

reconstructed = repmat(U (1, :), N, 1) .* repmat(data * U (1, :)', ...
                                                  1, 2);
disp ('Error introduced by reconstructing using the first eigen vector');
error2 = sum(sum((data - reconstructed) .^ 2)) / N

saveas (gcf, 'img/reconstruction.png');