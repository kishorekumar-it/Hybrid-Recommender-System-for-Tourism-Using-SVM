function [Dark_reg,Gaus]  = Gaussian_Filter(imagefilename) 
 
% READ THE INPUT IMAGE as uint 
im_input  = imagefilename;  
 
%  color image 
im_n =(im_input); 
 
% Getting the luminescence component alone 
ntsc_gray = im_n(:,:,1);  
 
% Histogram equalisation 
ref_image=(imagefilename);
hist = imhist(ref_image); 
ntsc_gray_eq = histeq(ntsc_gray,hist); 

% laplacian of gaussian LOG KERNEL 
h=fspecial('log',11,1.4);  
 
% convolve image with filter for edge detection 
im_log = imfilter(ntsc_gray_eq,h);  
 
% Converting to Binary Images and thresholding 
Gaus = im2bw(im_log,graythresh(im_log)); 
 
% complement of the image and ostu's thresholding for better clarity 
Dark_reg = imcomplement(Gaus); 
Dark_reg = im2bw(Dark_reg);  
figure(), imshow(Gaus), title('Edge detected Image');  
%saveas(gcf,'E:\IOTR\3.jpg');

end 