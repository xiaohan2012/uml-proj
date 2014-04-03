function visual(pictures, cols)

%% FUNCTION visual
%
% Display images stored in the columns of a matrix as a matrix of patches.
%
% pictures:     matrix in which each column represents one picture. Pictures are
%               stored in row-major order.
% cols          number of pictures in the horizontal dimension of the final
%               figure.
%
% EXAMPLE: Display the first 100 digits in a square of 10x10 images.
%
% visual(digits(:,1:100),10) 
%
% Last update: 14.03.14 Hugo Gabriel Eyherabide


% Compute the dimensiones of the final figure in units of pictures.

numpictures=size(pictures,2);

if ~exist('cols','var') || ~isnumeric(cols) || cols<1, 
    cols=ceil(sqrt(numpictures)); 
elseif cols>numpictures, cols=numpictures;
end

rows=ceil(numpictures/cols); 


% Adding columns with zeros so that the number of pictures in the final
% figure coincides with the number of pictures in the input matrix.
pictures=[pictures,zeros(size(pictures,1),rows*cols-numpictures)];


% Creating the patches containing each figure. Digits are arranges in
% row-major order.
pictures=reshape(permute(reshape(pictures,[28,28,cols,rows]),[2,4,1,3]),28*[rows,cols]);


% Creating the figure. The colormap will be inverted so that the background
% colour is white.
imagesc(pictures); 
colormap(-sort(-gray));
axis off;
set(gca,'DataAspectRatio',[1,1,1]);

