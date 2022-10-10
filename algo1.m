%ALGO1

im = imread('1_P_hgr1_id03_1.jpg');

% passem de rgb a ycbcr
YCBCRim = rgb2ycbcr(im);
[Y Cb Cr] = imsplit(YCBCRim);


CbArray = reshape(Cb,[],1);
CrArray = reshape(Cr,[],1);

data = [CbArray,CrArray];

[hcb] = histogram(CbArray);
[hcr] = histogram(CrArray);

X = [];

%hist3(data);







