%ALGO1

im = imread('1_P_hgr1_id03_1.jpg');

% YCBCRim = rgb2ycbcr(im);
%histograma(YCBCRim);

% passem de rgb a ycbcr

[R G B] = imsplit(im);  
Cb = -0.1687*R - 0.3313*G + 0.5*B;
Cr = 0.5*R - 0.4187*G - 0.0813*B;

% Cb2 = typecast(Cb,int8);
% Cr2 = typecast(Cr,int8);

hCb = histogram(Cb);
hCr = histogram(Cr);




% [rows, columns, canals] = size(im);
% 
% figure
% imshow(im)
% title('Indexed Image with RGB Colormap');
% 
% longCb = 255;
% longCr = 255;
% 
% hist = zeros(256,256);
% 
% 
%  for i = 0:rows
%      for j = 0:columns
%          hist(Cb(i,j),Cr(i,j))= hist(Cb(i,j),Cr(i,j)) + 1;
%               
%      end
%  end

