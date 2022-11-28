
%ALGO6

% Especifiquem el directori de les imatges de training
myFolder = 'DataBase Train-Valid Prog 1 i 2/DataBase Train-Valid Prog 1  i  2/Validation-Dataset/Masks-Ideal/';

% Fem una llista amb tots els fitxers .bmp
filePattern = fullfile(myFolder, '*.bmp'); % Change to whatever pattern you need.

theFiles = dir(filePattern);

%Creem la carpeta "Masks" la qual utilitzarem per guardar les mascares
%mkdir("Masks");

%Recorrem els fitxers
for k = 1 : length(theFiles)
    close all;
    baseFileName = theFiles(k).name;
    fullFileName = fullfile(theFiles(k).folder, baseFileName);
    
    %im = imread(fullFileName);
    n=algo5(fullFileName);
    fprintf('Processed image %s  -->  Number of fingers: %d \n', baseFileName,n);
    pause;
    
end
