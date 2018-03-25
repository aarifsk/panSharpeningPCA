function [eigen_vector,eigen_value] = compute_eigen_val_vectors(ip_matrix,error_margin,debug_mode)
% Computes the     Eigenvalues and eigenvectors.
%Input
%   ip_matrix
%   error_margin
%output
%   eigen_vector - sorted in descending order
%   eigen_value- sorted in descending order



if nargin==2, debug_mode = 0; end
eigen_value = ip_matrix;
[n,n] = size(ip_matrix);
eigen_vector = eye(n);
cnts = 0;
cntr = 0;
done = 0;
working = 1;
stat = working;
while (stat==working),
	 cnts = cnts+1;
	 t = sum(diag(eigen_value));
	 stat = done;
    for p = 1:(n-1),
      for q = (p+1):n,
	       if ((abs(eigen_value(p,q))/t)>error_margin),
          t = eigen_value(p,q)/(eigen_value(q,q) - eigen_value(p,p));
          c = 1/sqrt(t*t+1);
          s = c*t;
          R = [c s; -s c];
          eigen_value([p q],:) = R'*eigen_value([p q],:);
          eigen_value(:,[p q]) = eigen_value(:,[p q])*R;
          eigen_vector(:,[p q]) = eigen_vector(:,[p q])*R;
		        cntr = cntr+1;
          if debug_mode==1,
            home; if cntr==1, clc; end; 
            disp(['Iteration No. ',int2str(cntr)]),disp(''),...
            disp(['Zeroed out the element  eigen_value(',num2str(p),...
                  ',',num2str(q),') = ']),disp(eigen_value(p,q)),...
	           disp('New transformed matrix  eigen_value = '),disp(eigen_value)
          end
		        stat = working;
        end
      end
    end
end
eigen_value = diag(diag(eigen_value));


