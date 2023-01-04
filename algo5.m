%ALGO5
function [n] = algo5(BW)

Mask = imread(BW);
%imshow(Mask);

%Inicialitzem a -1 per comprobar el bon funcionament
n = -1; 

%Calculem la distància euclidiana de la mascara
D = bwdist(Mask,'euclidean');

%Creem una imatge amb 3dim
Dist1 = repmat(rescale(D), [1 1 3]);

%Guardem la mida de la imatge
[rows, cols, ~]=size(D);

%Retallem la imatge per trobar els valors més importants
Dcrop = imcrop(D,[cols/4,rows/4,cols*3/4,rows*3/4]);

%Guardem el valor màxim de la imatge
maxVal = max(Dcrop,[],'all');
%fprintf('v = %d\n',maxVal);


umbralD = 10;

for k=1 : rows
        for l=1 : cols
            if (D(k,l) > umbralD)
                
               D(k,l)=0;
                
            end
        end
end

%Creem els SE
 SE0 = ones(25,25);
 SE1 = ones(5,5);
 SE2 = ones(40,40);
 SE3 = ones(13,13);
 SE4 = ones(18,18);
 SE5 = ones(1,1);


 %Escollim depenen de la distància respecte la camara quin SE aplicar.
if(maxVal<=50)
    %Primerament realitzem un erode per eliminar píxels esporàdics
    ImOp1 = imerode(D,SE5); %SE5 = ones(1,1)
    %Realitzem un opening
    ImOp2 = imopen(ImOp1,SE3);%SE3 13x13
    
else
    ImOp = imdilate(D,SE0); %SE0 25x25 
    ImOp1 = imerode(ImOp,SE2); %SE2 40x40
    ImOp2 = imopen(ImOp1,SE3); %SE3 13x13
end
    

%Eliminem els possibles errors situats al marc (colzes,etc)

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
    % Multipliquem per la mascara negada per eliminar solapaments
    ImOp2 = ImOp2.*~Mask;
    
    ImCrop = imcrop(ImOp2,[cols/6,rows/6,cols*5/6,rows*5/6]); 
    ImCrop = imerode(ImCrop,SE1);
    
    CC=bwconncomp(ImOp2);
    n=CC.NumObjects;
    cropErode = imerode(ImCrop,SE4);
    areaa=bwarea(cropErode);
    areaa = areaa /(rows*cols);
    fprintf('Àrea = %f\n', areaa);
    
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
 
%Mostrem per pantalla
%  figure
%  subplot(2,2,1), imshow(Mask), title('Original')
%  hold on, 
%  subplot(2,2,2), imshow(Dist1), title('Euclidean')
%  hold on,
%  subplot(2,2,3), imshow(ImOp2), title('Umbral')
%  hold on,
%  subplot(2,2,4), imshow(ImCrop), title('Retallada')
%  pause;

end