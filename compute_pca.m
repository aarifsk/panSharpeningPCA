function [centered_pan_image original_pca_image pca sharped ] = compute_pca(ip_ms_image, ip_pan_image);
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
ms_image = ip_ms_image(:,:, 1:3);
ms_image = double(ms_image)/255;
pan_image = double(ip_pan_image)/255;

% [centered_pan_image original_pca_image sharpened ] = perform_pansharp(ms_image, pan_image);
[centered_pan_image original_pca_image pca sharped ] = perform_pansharp(ms_image, pan_image);

end

