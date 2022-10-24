%ALGO1

primeraFoto = 1;

% Especifiquem el directori de les imatges de training
myFolder = 'DataBase Train-Valid Prog 1 i 2/DataBase Train-Valid Prog 1  i  2/Training-Dataset/Images/';

% Fem una llista amb tots els fitxers .jpg
filePattern = fullfile(myFolder, '*.jpg'); % Change to whatever pattern you need.

theFiles = dir(filePattern);

H = [];
HFinal = zeros(256,256);
CbRet = [];
CrRet = [];

%recorrem els fitxers
for k = 1 : length(theFiles)
    baseFileName = theFiles(k).name;
    fullFileName = fullfile(theFiles(k).folder, baseFileName);
    fprintf('Now processing %s\n', fullFileName);
    im = imread(fullFileName);
    
    % passem de rgb a ycbcr
    YCBCRim = rgb2ycbcr(im);
    [Y Cb Cr] = imsplit(YCBCRim);


    %Passem les matrius de crominancies a vectors
    CbArray = double(reshape(Cb,[],1));
    CrArray = double(reshape(Cr,[],1));
    
    %Fem que tots els vectors siguin de la mateixa mida per tal de poder
    %operar amb ells
    
    
    %if primeraFoto == 1
    %    CbTotal = CbArray;
    %    CrTotal = CrArray;
%         primeraFoto = 0;
%     end
%     if length(CbTotal)>length(CbArray)
%        CbArray(end:numel(CbTotal))=0;
%     end
%     if length(CbArray)>length(CbTotal)
%        CbTotal(end:numel(CbArray))=0;
%     end
%     if length(CrTotal)>length(CrArray)
%        CrArray(end:numel(CrTotal))=0;
%     end
%     if length(CrArray)>length(CrTotal)
%        CrTotal(end:numel(CrArray))=0;
%     end
%     
%     
%     CbTotal = CbTotal+CbArray;
%     CrTotal = CrTotal+CrArray;

    %eliminem els valors que tenen crominancies molt diferents a la pell per
    %evitar tenir valors dels fondos de les imatges a l'histograma
    for i=1 : length(CbArray)
       if(CbArray(i)>100 && CrArray(i)>100)
           CbRet(end + 1)=CbArray(i);
           CrRet(end + 1)=CrArray(i);
       end
    end


    %Passem els valors dels vectors de crominancies a una matriu de parelles de valors
    data = [CbRet.',CrRet.'];

    %Creem l'histograma
    H=hist3(data,'Ctrs',{0:1:255 0:1:255});
    HFinal=HFinal+H;

end

%normalitzem els valors dels vectors de crominancia depenent de les fotos
%analitzades
%CbTotal = CbTotal/length(theFiles);
%CrTotal = CrTotal/length(theFiles);

hist3(HFinal,'Ctrs',{0:1:255 0:1:255},'CDataMode','auto','FaceColor','interp');



% H=hist3(data,'Ctrs',{0:1:255 0:1:255},'CDataMode','auto','FaceColor','interp');










