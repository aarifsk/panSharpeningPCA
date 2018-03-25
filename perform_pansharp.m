function [centered_pan_image original_image PCA_parameters sharpened ] = perform_pansharp( ip_ms_image, ip_pan_image )
%Image enhancement using Principal COmponent Merge Technique.  
% First resize the multispectral image to same size as the Panchromatic image by replicating values(nearest neighbour)
% Rearange the BSQ data to BIP Format
% Perform PCA transform
% Replace the first band with PCA image
% perform Inverse PCA to get PCA merged high resolution image
% Input parameters
%     ip_ms_image         -    Multispectral low spatial resolution image to be transformed
%     ip_pan_image        -    Panchromatic High spatial resolution image to be merged
% 
% Output paramters
%      centered_pan_image    -  zero mean panchromatic image
%      original_image        -  Original PCA image without prominent
%                               component replaced by PAN image
%      PCAMap                - PCA parameters - mean, eigen value and  eigen
%                               vector
%      sharpened             -  PCA Sharpened Image
%      
% Functions called
%     upsample_ms     - Resize the Multispectral image to size of panchromatic image
%     multi_pca       - Perform the Principal Component Analysis
% 
% % Coded by Harshula , Aarif, Ravi on 13/11/17

 ip_ms_image= double(ip_ms_image)/255;
 ip_pan_image = double(ip_pan_image)/255;

ip_ms_image= double(ip_ms_image);
ip_pan_image = double(ip_pan_image);

% ip_ms_image = upsample_ms(ip_ms_image,ip_pan_image);
[hr,hc]=size(ip_pan_image);
ip_ms_image = imresize(ip_ms_image,[hr hc]);

[m, n, d] = size(ip_ms_image);

ms_image = reshape(ip_ms_image, m*n, d);

%pca transform on ms bands
[PCA_Image, PCA_parameters] = multi_pca(ms_image, d);
PCA_Image = reshape(PCA_Image, [m, n, d]);
image_for_pca = PCA_Image;

 centered_pan_image = (ip_pan_image - mean(ip_pan_image(:))) * std(image_for_pca(:))/std(double(ip_pan_image(:))) + mean(image_for_pca(:));
 original_image = image_for_pca;
% %replace 1st band with pan
image_for_pca(:,:,1) = centered_pan_image;


%inverse PCA
image_for_pca = inv_pca(PCA_parameters.M, reshape(image_for_pca, m*n, d), PCA_parameters.mean);

sharpened = reshape(image_for_pca, [m, n, d]);
