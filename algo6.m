%ALGO6

% Especifiquem el directori de les imatges de training
myFolder = 'DataBase Train-Valid Prog 1 i 2/DataBase Train-Valid Prog 1  i  2/Validation-Dataset/Masks-Ideal/';

% Fem una llista amb tots els fitxers .bmp
filePattern = fullfile(myFolder, '*.bmp'); % Change to whatever pattern you need.

theFiles = dir(filePattern);

%Creem la carpeta "Masks" la qual utilitzarem per guardar les mascares
%mkdir("Masks");

double macroF1;
double acc;
macroF1 = 0;
acc = 0;

dolentes = 0;
%Recorrem els fitxers
for k = 1 : length(theFiles)
    close all;
    baseFileName = theFiles(k).name;
    fullFileName = fullfile(theFiles(k).folder, baseFileName);
    
    %im = imread(fullFileName);
    n=algo5(fullFileName);
    fprintf('Processed image %s  -->  Number of fingers: %d \n', baseFileName,n);
    %pause;
    
    dits = extract(baseFileName,1);
    dits = str2double(dits);     
    
    if(n ~= dits)
        dolentes = dolentes + 1; 
    end
    
    [fscore, recall, precision] = algo7(n, dits);
    
    macroF1 = macroF1 + fscore;
end

%Accuracy

 
acc = ((length(theFiles) - dolentes) / length(theFiles)) * 100;

macroF1 = macroF1 / length(theFiles);

%Mostrem per pantalla els valors trobats
fprintf("\n****Summary****\nAvarage precision: %f \n", precision);
fprintf("Avarage recall: %f \n", recall);
fprintf("\nF-Score: %f \n", macroF1);
fprintf("Percentatge acert: %i \n", acc);


