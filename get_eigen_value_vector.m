function [ sorted_eigen_vector,sorted_eigen_val ] = get_eigen_value_vector( input_matrix )
%Computes the Eigen values and Eigen vectors for the given matrix
%Input
%   ip_matrix- BIP format input matrix whose covariance is to be calculated
%output
%   sorted_eigen_vector     - Eigen vector of the input matrix  in descending
%                           order of eigen values
%   sorted_eigen_val        - Descending order eigen_value

% % Coded by Harshula , Aarif, Ravi on 13/11/17


% [eigen_vector1,eigen_val1]=eig(input_matrix);
% disp('Eigen vector and Eigen values are displayed in Descending order of Eigen value');
% disp('Sorted Eigen vector and Eigen values using Built in Matlab function');
% [sorted_eigen_vector1,sorted_eigen_val1]=sort_eigen_val_vector(eigen_vector1,eigen_val1)

error_margin = 1e-16;
[eigen_vector,eigen_val] = compute_eigen_val_vectors(input_matrix,error_margin,0);
[r c]=size(eigen_vector);

for i = 1:c
  if (eigen_vector(:,1)<0)
    eigen_vector(:,1)=eigen_vector(:,1)*(-1);
  end
end
    

%disp('Sorted Eigen vector and Eigen values using developed function');

[sorted_eigen_vector,sorted_eigen_val]=sort_eigen_val_vector(eigen_vector,eigen_val);


end

