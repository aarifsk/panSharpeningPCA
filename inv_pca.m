function [ FinalMatrix ] = inv_pca(eigen_vector,pca_image,MeanV)
% Perform INVERSE PCA transform
% Multiply the PCA image with transpose of Eigen vector and add the mean
% vector to it to get the original image
% Input parameters
%     eigen_vector          -   Eigen vector
%     pca_image             -   BIP format PCA Image
%       MeanV               -   Mean vector of the Original Image
% Output paramters
%     
%      FinalMatrix          -    Inverse PCA image
% 
% % Coded by Harshula , Aarif, Ravi on 13/11/17


[m, ~] = size(pca_image);

M = zeros(m, length(MeanV));

for k = 1 : length(MeanV)
    M(1:m, k) = MeanV(k);
end

FinalMatrix =(pca_image*transpose(eigen_vector))+ M;