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


%SE = ones(16,16);

SE1 = load('SE1.mat');


%ImDi = imdilate(D,SE1);
ImOp = imopen(D,SE1.SE);
%ImEr = imerode(ImOp,SE1);

CC=bwconncomp(ImOp);
n=CC.NumObjects;

figure
subplot(2,2,1), imshow(Mask), title('Original')
hold on, 
subplot(2,2,2), imshow(Dist1), title('Euclidean')
hold on,
subplot(2,2,3), imshow(D), title('Umbral')
hold on,
subplot(2,2,4), imshow(ImOp), title('Opening')



end