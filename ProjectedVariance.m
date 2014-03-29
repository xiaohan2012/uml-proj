function [projected_var, projected_data, D] = ProjectedVariance (data)
%PCA of data and project each data row to each PC
%return the variance in terms of each projected PC

[U, D] = pca (data);

%project data to each PC
%each column correspond to one PC
projected_data = data * U;

projected_var = var (projected_data);

