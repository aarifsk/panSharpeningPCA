function [ cov_matrix] = compute_covariance(ip_matrix)
%Computes the covariance
%Input
%   ip_matrix- BIP format input matrix whose covariance is to be calculated
%output
%   cov_matrix- Covariance matrix

% % Coded by Harshula , Aarif, Ravi on 13/11/17


% cov_matrix1=cov(ip_matrix);

one_vector(1:size(ip_matrix,1)) = 1;
mu = (one_vector * ip_matrix) / size(ip_matrix,1);
ip_matrix_mean_subtract = ip_matrix - mu(one_vector, :);
ip_matrix_mean_subtract_t=ip_matrix_mean_subtract';
cov_matrix = (ip_matrix_mean_subtract_t * ip_matrix_mean_subtract) / (size(ip_matrix,1) - 1);


end

