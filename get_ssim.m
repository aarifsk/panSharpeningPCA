function [ ssimval,ssimmap ] = get_ssim( ip_image,ref_image )
%this function compares image with the reference image for similarity
%The Structural SIMilarity (SSIM) index is a method for measuring the similarity between two images. 
%The SSIM index can be viewed as a quality measure of one of the images being compared, provided the other image is regarded as of perfect quality. 
%Input parameters
%     ip_image            -    Image whose similarity is to be checked
%     ip_pan_image        -    Reference image
% 
%Output: (1) mssim: the mean SSIM index value between 2 images.
%            If one of the images being compared is regarded as 
%            perfect quality, then mssim can be considered as the
%            quality measure of the other image.
%            If img1 = img2, then mssim = 1.
%        (2) ssim_map: the SSIM index map of the test image. The map
%            has a smaller size than the input images. The actual size:
%            size(img1) - size(window) + 1.
% refer to http://www.cns.nyu.edu/~lcv/ssim/ for more details

[ssimval, ssimmap] = ssim(ip_image,ref_image);
% fprintf('The SSIM value is %0.4f.\n',ssimval);
% figure, imshow(ssimmap,[]);
% title(sprintf('ssim Index Map - Mean ssim Value is %0.4f',ssimval));
end

