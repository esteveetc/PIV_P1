%ALGO1

primeraFoto = 1;

% Especifiquem el directori de les imatges de training
myFolder = 'DataBase Train-Valid Prog 1 i 2/DataBase Train-Valid Prog 1  i  2/Training-Dataset/Images/';

% Fem una llista amb tots els fitxers .jpg
filePattern = fullfile(myFolder, '*.jpg'); % Change to whatever pattern you need.

myFolder2 = 'DataBase Train-Valid Prog 1 i 2/DataBase Train-Valid Prog 1  i  2/Training-Dataset/Masks-Ideal/';


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
    
    maskFileName = baseFileName(1:length(baseFileName)-3)+"bmp";
    
    % passem de rgb a ycbcr
    YCBCRim = rgb2ycbcr(im);
    [Y Cb Cr] = imsplit(YCBCRim);


    %Passem les matrius de crominancies a vectors
    tmpMask=imread(myFolder2 + maskFileName);
    tmpMask = ~tmpMask;
    
    
    Cbmask = Cb(tmpMask);
    Crmask = Cr(tmpMask);
    
    

    %Passem els valors dels vectors de  crominancies a una matriu de parelles de valors
    data = [Cbmask,Crmask];

    %Creem l'histograma
    H=hist3(data,'Edges',{0:255 0:255},'CDataMode','auto','FaceColor','interp');
    HFinal=HFinal+H;
    

end

%normalitzem els valors dels vectors de crominancia depenent de les fotos
%analitzades
%CbTotal = CbTotal/length(theFiles);
%CrTotal = CrTotal/length(theFiles);

bar3(HFinal);


% H=hist3(data,'Ctrs',{0:1:255 0:1:255},'CDataMode','auto','FaceColor','interp');










