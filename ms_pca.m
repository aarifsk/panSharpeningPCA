function [mappedX, mapping] = ms_pca(X, no_dims)
%PCA Perform the PCA algorithm
%
%   [mappedX, mapping] = pca(X, no_dims)
%
% The function runs PCA on a set of datapoints X. The variable
% no_dims sets the number of dimensions of the feature points in the 
% embedded feature space (no_dims >= 1, default = 2). 
% For no_dims, you can also specify a number between 0 and 1, determining 
% the amount of variance you want to retain in the PCA step.
% The function returns the locations of the embedded trainingdata in 
% mappedX. Furthermore, it returns information on the mapping in mapping.



    if ~exist('no_dims', 'var')
        no_dims = 2;
    end
	
	% Make sure data is zero mean
    mapping.mean = mean(X, 1);
	X = X - repmat(mapping.mean, [size(X, 1) 1]);

	% Compute covariance matrix
    if size(X, 2) < size(X, 1)
        C = cov(X);
    else
        C = (1 / size(X, 1)) * (X * X');        % if N>D, we better use this matrix for the eigendecomposition
    end
	
	% Perform eigendecomposition of C
	C(isnan(C)) = 0;
	C(isinf(C)) = 0;
    [eigen_vector, eigen_value] = get_eigen_value_vector(C);
    
    % Sort eigenvectors in descending order
%     [eigen_value, ind] = sort(diag(eigen_value), 'descend');
    if no_dims > size(eigen_vector, 2)
        no_dims = size(eigen_vector, 2);
        warning(['Target dimensionality reduced to ' num2str(no_dims) '.']);
    end
	eigen_vector = eigen_vector(:,ind(1:no_dims));
    eigen_value = eigen_value(1:no_dims);
	
	% Apply mapping on the data
    if ~(size(X, 2) < size(X, 1))
        eigen_vector = (X' * eigen_vector) .* repmat((1 ./ sqrt(size(X, 1) .* eigen_value))', [size(X, 2) 1]);     % normalize in order to get eigenvectors of covariance matrix
    end
    mappedX = X * eigen_vector;
    
    % Store information for out-of-sample extension
    mapping.M = eigen_vector;
	mapping.lambda = eigen_value;
    