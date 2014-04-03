load('digits.txt')
addpath('../exercise1');

old_digits = digits;
[featureSize, imageCount] = size(digits);

%--------------1--------------
disp('Question 1: visualize')
figure(1)
visual(digits(:, 1:100), 10);
title('Original digits');
saveas(gcf, 'img/original_digits.png')

%preprocess
digits = digits - mean(mean(digits));
digits = digits ./ repmat(sqrt(sum(digits .^ 2, 1)), featureSize, 1);

figure(2)
visual(mean(digits, 2));
title('Mean of each variable');
saveas(gcf, 'img/varible_mean.png')

%cener the variable
digits = digits - repmat(mean(digits, 2), 1, imageCount);

figure(3)
visual(digits(:, 1:100), 10);
title('Normalized digits');
saveas(gcf, 'img/normalized_digits.png')

%--------------2--------------
disp('Question 2: pca on digits')
[U,V] = pca(digits');

U = fliplr(U); %flip U for easier use
eigenvalues = flipud(diag(V));

figure(4)
plot(1:length(eigenvalues), cumsum(eigenvalues) / sum(eigenvalues), '-o');
title('Variance explained vs princinpal component number');
xlabel('Princinpal component number');
ylabel('Variance explained ');
saveas(gcf, 'img/variance_explained.png');

disp(sprintf('The first 20 principal components expained %f%% of the variance.', sum(eigenvalues(1:20)) / sum(eigenvalues) * 100));

%--------------3--------------
disp('Question 3: compression')
images = digits(:, randperm(imageCount, 10));

subspace_dimension = [1 2 4 8 16 32 64 128];

for i = 1:length(subspace_dimension)
    dimension = subspace_dimension(i);
    A = U(:, 1:dimension);
    image_recons = A * A' * images;
    figure(i+4);
    disp(sprintf('Subspace dimension: %d. Variance explained: %f%%', dimension, sum(eigenvalues(1:dimension)) / sum(eigenvalues) * 100));    
    visual([images, image_recons]);
    saveas(gcf, sprintf('img/image_%d.png', dimension));
end

disp('Question 4: denoising')
load('noisyDigits.txt')

figure(i+5)
visual(noisyDigits(:,1:100), 10);
saveas(gcf, 'img/noisy_digits.png')

%denoising
A = U(:, 1:32); %using the first 32 PC for image denoising
noisyDigits = noisyDigits - mean(mean(noisyDigits));
noisyDigits = noisyDigits ./ repmat(sqrt(sum(noisyDigits .^ 2, 1)), featureSize, 1);
variable_mean = mean(noisyDigits, 2);
noisyDigits = noisyDigits - repmat(variable_mean, 1, 100);

image_denoised = A * A' * noisyDigits;

figure(i+6)
image_denoised = image_denoised + repmat(variable_mean, 1, 100); %make it whiter
visual(image_denoised(:,1:100), 10);
saveas(gcf, 'img/denoised_digits.png')
