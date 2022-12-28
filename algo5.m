
%ALGO5
function [n] = algo5(BW)

%obrim mask de una imatge

Mask = imread(BW);
%imshow(Mask);
n = -1; 

%
D = bwdist(Mask,'euclidean');

Dist1 = repmat(rescale(D), [1 1 3]); %creem una imatge amb 3dim

%Guardem la mida de la imatge
[rows, cols, ~]=size(D);

%Retallem la imatge per trobar els valors més importants
Dcrop = imcrop(D,[cols/4,rows/4,cols*3/4,rows*3/4]);
%Guardem el valor màxim de la imatge
maxVal = max(Dcrop,[],'all');
%fprintf('v = %d\n',maxVal);


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
SE1 = ones(5,5);
SE2 = ones(40,40);
SE3 = ones(13,13);
SE4 = ones(18,18);

% SE0 = load('SE0.mat', 'SE0');
% SE1 = load('SE1.mat', 'SE1Copy');
% SE2 = load('SE2.mat', 'SE2');
% SE3 = load('SE3.mat', 'SE1CopyCopy');
% SE4 = load('SE4.mat', 'SE4');
% 
% SE0 = SE0.SE0; %rodona radi 18x18 
% SE1 = SE1.SE1Copy; %rodona radi 5x5 
% SE2 = SE2.SE2; %rodona radi 40x40 
%  
% SE3 = SE3.SE1CopyCopy; %rodona radi 13x13 
% SE4 = SE4.SE4; %rodona radi 18x18 
SE5 = ones(1,1);



if(maxVal<=50)
 %   fprintf('utilitzem el petit \n');
    
    ImOp1 = imerode(D,SE5); %SE5 = ones(1,1)
    ImOp2 = imopen(ImOp1,SE3);%SE3 13x13
    
else
  %  fprintf('utilitzem el gran \n');
    ImOp = imdilate(D,SE0); %SE0 25x25 
    ImOp1 = imerode(ImOp,SE2); %SE2 40x40
    ImOp2 = imopen(ImOp1,SE3); %SE3 13x13
end
    

%%%eliminem els possibles errors situats al marc que  son sempre %%%
%%%colzes o parts no desitjades

ImCrop = imcrop(ImOp2,[cols/6,rows/6,cols*5/6,rows*5/6]); 

CC=bwconncomp(ImCrop);
cropErode = imerode(ImCrop,SE2);
%Calculem l'àrea
areaa=bwarea(cropErode); 
%Normalitzem
areaa = areaa /(rows*cols);
n=CC.NumObjects;


if(areaa>0)
   % fprintf('Utilitzem el petit pq el gran es solapa \n');
    ImOp = imdilate(D,SE4);
    ImOp2 = imerode(ImOp,SE2);
    ImCrop = imcrop(ImOp2,[cols/6,rows/6,cols*5/6,rows*5/6]); 
    ImCrop = imerode(ImCrop,SE1);
    
    CC=bwconncomp(ImCrop);
    n=CC.NumObjects;
    cropErode = imerode(ImCrop,SE4);
    areaa=bwarea(cropErode);
    areaa = areaa /(rows*cols);
    %fprintf('Àrea = %f\n', areaa);
    if(areaa>0 && n<=2 && areaa>0 && areaa<=0.01)
        n=n+1;
    elseif(areaa>0.01 && n<=2 && areaa<0.012)
        n=n+2;
    elseif(areaa>0.012 && n<=2)
        n=n+3;
    end
end

if(n>5)
    n=5;
end

% figure
% subplot(2,2,1), imshow(Mask), title('Original')
% hold on, 
% subplot(2,2,2), imshow(ImOp2), title('Euclidean')
% hold on,
% subplot(2,2,3), imshow(ImCrop), title('Umbral')
% hold on,
% subplot(2,2,4), imshow(cropErode), title('Opening')


end