function [sorted_eigen_vector,sorted_eigen_val]=sort_eigen_val_vector(ip_eigen_vector,ip_eigen_val)
% this function takes in two matrices P and D, presumably the output 
% from Matlab's eig function, and then sorts the columns of P to 
% match the sorted columns of D (going from largest to smallest)
% 
% EXAMPLE: 
% 
% ip_eigen_val =
%    -90     0     0
%      0   -30     0
%      0     0   -60
% ip_eigen_vector =
%      1     2     3
%      1     2     3
%      1     2     3
% 
% [sorted_eigen_vector,sorted_eigen_val]=sortem(ip_eigen_vector,ip_eigen_val)
% sorted_eigen_vector =
%      2     3     1
%      2     3     1
%      2     3     1
% sorted_eigen_val =
%    -30     0     0
%      0   -60     0
%      0     0   -90


sorted_eigen_val=diag(sort(diag(ip_eigen_val),'descend')); % make diagonal matrix out of sorted diagonal values of input D
[c, ind]=sort(diag(ip_eigen_val),'descend'); % store the indices of which columns the sorted eigenvalues come from
sorted_eigen_vector=ip_eigen_vector(:,ind); % arrange the columns in this order

