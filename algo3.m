%ALGO3

% Especifiquem el directori de les imatges de training
myFolder = 'DataBase Train-Valid Prog 1 i 2/DataBase Train-Valid Prog 1  i  2/Training-Dataset/Images/';

% Fem una llista amb tots els fitxers .jpg
filePattern = fullfile(myFolder, '*.jpg'); % Change to whatever pattern you need.

theFiles = dir(filePattern);

%%%BUCLE
%recorrem els fitxers
for k = 1 : length(theFiles)
baseFileName = theFiles(k).name;
    fullFileName = fullfile(theFiles(k).folder, baseFileName);
    fprintf('Now processing... %s\n', fullFileName);
    im = imread(fullFileName);
    
    Mask = algo2(fullFileName);
    
    imshow(Mask);
    %%%%%% HEM DE FER QUE ES GUARDIN A UNA CRPETA MASKS ELS RESULTATS S%%%%%%
    imwrite (Mask, fullFileName+'.png', 'png');
    pause;
end


%%%FOTO X FOTO
%im =  imread("/Users/esteve/Desktop/PIV_P1/DataBase Train-Valid Prog 1 i 2/DataBase Train-Valid Prog 1  i  2/Training-Dataset/Images/3_A_hgr2B_id06_1.jpg");
%Mask = algo2("/Users/esteve/Desktop/PIV_P1/DataBase Train-Valid Prog 1 i 2/DataBase Train-Valid Prog 1  i  2/Training-Dataset/Images/3_A_hgr2B_id06_1.jpg");
    
%imshow(Mask);
    
