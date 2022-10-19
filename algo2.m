function [BW] = algo2(RGB)

%Identifiquem els parametres de la imatge
I = imread(RGB);

%Cambiem l'espai de color de la imatge a YCBCr
YCBCRim = rgb2ycbcr(I);
[Y Cb1 Cr1] = imsplit(YCBCRim);
Cb = double(Cb1);
Cr = double(Cr1);

%Definim uns llindars per crear la mascara (basats en l'histograma del
%ALGO1)
minCb = 100;
maxCb = 140;

minCr = 130;
maxCr = 160;

%Guardem la mida de la imatge
[rows, cols, val]=size(YCBCRim);

%Creem una matriu de zeros de la mida de la imatge
BW = zeros(rows,cols);

%Recorrem la imatge comparant les crominancies per crear la mascara
for k=1 : rows
        for l=1 : cols
            if (Cb(k,l)>= minCb && Cb(k,l) <= maxCb && Cr(k,l)>= minCr && Cr(k,l) <= maxCr)
                
               BW(k,l) = 1;
                
            end
        end
end

%Mostrem la mascara
imshow(BW);

end
