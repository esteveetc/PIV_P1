%ALGO5
function [n] = algo5(BW)

%obrim mask de una imatge

Mask = imread(BW);
%imshow(Mask);
n=-1;

%
D = bwdist(Mask,'euclidean');

Dist1 = repmat(rescale(D), [1 1 3]); %creem una imatge amb 3dim

%Guardem la mida de la imatge
[rows, cols, ~]=size(D);

Dcrop = imcrop(D,[cols/4,rows/4,cols*3/4,rows*3/4]);
maxVal = max(Dcrop,[],'all');
fprintf('v = %d\n',maxVal);


umbralD = 10;

%[R,G,B]=imsplit(Dist1);

%disp(R);

for k=1 : rows
        for l=1 : cols
            if (D(k,l)>umbralD)
                
               D(k,l)=0;
                
            end
        end
end




%%%%% fer petit el petit se i fer un humbral mes, arreglar error fusio dits



SE0 = ones(25,25);
SE2 = ones(40,40);
SE3 = ones(10,10);
SE = SE0;
SE1 = load('SE1.mat');

if(maxVal<=50)
    SE = SE1.SE;
    fprintf('utilitzem el petit \n');
    ImOp2 = imopen(D,SE);
    
else
    SE = SE0;
    fprintf('utilitzem el gran \n');
    ImOp = imdilate(D,SE);
    ImOp1 = imerode(ImOp,SE2);
    ImOp2 = imopen(ImOp1,SE3);
end
    

CC=bwconncomp(ImOp2);
n=CC.NumObjects;

figure
subplot(2,2,1), imshow(Mask), title('Original')
hold on, 
subplot(2,2,2), imshow(Dist1), title('Euclidean')
hold on,
subplot(2,2,3), imshow(D), title('Umbral')
hold on,
subplot(2,2,4), imshow(ImOp2), title('Opening')



end