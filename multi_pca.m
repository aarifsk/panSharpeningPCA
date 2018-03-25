function [PCA_image, PCA_parameters] = multi_pca(ip_ms_image, no_dims)

% Perform PCA transform
% Replace the first band with PCA image
% perform Inverse PCA to get PCA merged high resolution image
% Input parameters
%     ip_ms_image         -    Multispectral low spatial resolution image to be transformed
% 
% Output paramters
%     
%      PCA_image          -    PCA image
%      PCAMap             -    PCA parameters - mean, eigen value and  eigen
 
% Functions called
%     Compute_covariance            - Computes the covariance matrix
%     get_eigen_value_vector       - Returns the  eigen vector znd eigen
%                                    values sorted in ascending order.
% 
% % Coded by Harshula , Aarif, Ravi on 13/11/17



    if ~exist('no_dims', 'var')
        no_dims = 2;
    end
	
	% Make sure data is zero mean
    PCA_parameters.mean = mean(ip_ms_image, 1);
	ip_ms_image = ip_ms_image - repmat(PCA_parameters.mean, [size(ip_ms_image, 1) 1]);

	% Compute covariance matrix
    if size(ip_ms_image, 2) < size(ip_ms_image, 1)
%         C = cov(X);
        C=compute_covariance(ip_ms_image);
    else
        C = (1 / size(ip_ms_image, 1)) * (ip_ms_image * ip_ms_image');        % if N>D, we better use this matrix for the eigendecomposition
    end
	
	% Perform eigendecomposition of C
	C(isnan(C)) = 0;
	C(isinf(C)) = 0;
    
%     %%%using std function eig
%     [eigen_vector, eigen_value] = eig(C); 
%     % Sort eigenvectors in descending order
%     [eigen_value, ind] = sort(diag(eigen_value), 'descend');
%         
%     if no_dims > size(eigen_vector, 2)
%         no_dims = size(eigen_vector, 2);
%         warning(['Target dimensionality reduced to ' num2str(no_dims) '.']);
%     end
% 	eigen_vector = eigen_vector(:,ind(1:no_dims));
%     eigen_value = eigen_value(1:no_dims);
% 	%%%using std functio eig ends here
   
%get the sorted eigen value and correspondoing vectors
   [eigen_vector,eigen_value ] = get_eigen_value_vector( C );

	% Apply mapping on the data
    if ~(size(ip_ms_image, 2) < size(ip_ms_image, 1))
        eigen_vector = (ip_ms_image' * eigen_vector) .* repmat((1 ./ sqrt(size(ip_ms_image, 1) .* eigen_value))', [size(ip_ms_image, 2) 1]);     % normalize in order to get eigenvectors of covariance matrix
    end
    PCA_image = ip_ms_image * eigen_vector;
    
    % Store information for out-of-sample extension
    PCA_parameters.M = eigen_vector;
	PCA_parameters.lambda = eigen_value;
    