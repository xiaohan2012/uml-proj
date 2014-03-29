function [U, D] = pca (data)
%principle component analysis given data
%Param:
%data: m by n matrix, where there are m observations/rows and n variables/columns
%Returns:
%D, the eigen value diagonal matrix
%U, left eigenvectors
%V, right eigenvectors

%compute the covariance matrix
C = cov (data);

%perform eigen value decomposition
[U, D] = eig (C);

