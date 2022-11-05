%ALGO3

% Especifiquem el directori de les imatges de training
myFolder = 'DataBase Train-Valid Prog 1 i 2/DataBase Train-Valid Prog 1  i  2/Validation-Dataset/Images/';

% Fem una llista amb tots els fitxers .jpg
filePattern = fullfile(myFolder, '*.jpg'); % Change to whatever pattern you need.

theFiles = dir(filePattern);

%Creem la carpeta "Masks" la qual utilitzarem per guardar les mascares
mkdir("Masks");

%%%BUCLE
%recorrem els fitxers
for k = 1 : length(theFiles)
    baseFileName = theFiles(k).name;
    fullFileName = fullfile(theFiles(k).folder, baseFileName);
    fprintf('Now processing... %s\n', fullFileName);
    im = imread(fullFileName);
    
    %Mask = ;
    
    %imshow(Mask);
    
    %Guardem la mascara en la carpeta "Masks"
    %%%Podem posar directament el algo2 dins del imwrite()
    baseFileNameCut = erase(baseFileName, "jpg");
    baseFileNameCut = baseFileNameCut +"bmp";
    imwrite(algo2(fullFileName),"Masks\"+ baseFileNameCut);
    
   % pause;
end

%%%FOTO X FOTO
%im =  imread("/Users/esteve/Desktop/PIV_P1/DataBase Train-Valid Prog 1 i 2/DataBase Train-Valid Prog 1  i  2/Training-Dataset/Images/3_A_hgr2B_id06_1.jpg");
%Mask = algo2("/Users/esteve/Desktop/PIV_P1/DataBase Train-Valid Prog 1 i 2/DataBase Train-Valid Prog 1  i  2/Training-Dataset/Images/3_A_hgr2B_id06_1.jpg");
    
%imshow(Mask);