%ALGO6

% Especifiquem el directori de les imatges de training
myFolder = 'DataBase Train-Valid Prog 1 i 2/DataBase Train-Valid Prog 1  i  2/Validation-Dataset/Masks-Ideal/';

% Fem una llista amb tots els fitxers .bmp
filePattern = fullfile(myFolder, '*.bmp'); % Change to whatever pattern you need.

theFiles = dir(filePattern);

%Creem la carpeta "Masks" la qual utilitzarem per guardar les mascares
%mkdir("Masks");

%Creem una carpeta on adjuntarem un .txt amb el numero de dits que detectem
mkdir("Predictions");


double macroF1;
double macroRec;
double macroPrec;
double acc;
macroF1 = 0;
macroRec = 0;
macroPrec = 0;

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
    
    %Guardem en un fitxers els dits detectats de cada imatge
    fileNameCut = erase(baseFileName, ".bmp");
    fid = fopen(sprintf('Predictions/%s.txt', fileNameCut), 'w');
    fprintf(fid, '%d', n);
    fclose(fid);
    
    %Guardem en una variable en numero de dits de la imatge
    dits = extract(baseFileName,1);
    dits = str2double(dits);
    
    %Comparem amb els dits que hem detectat
    if(n ~= dits)
        dolentes = dolentes + 1; 
    end
    
    [fscore, recall, precision] = algo7(n,dits);
    
    macroF1 = macroF1 + fscore;
    macroRec = macroRec + recall;
    macroPrec = macroPrec + precision;
    
    fprintf("MacroF1: %f --- Rec: %f ---- Prec: %f \n", fscore, recall, precision);
end

%Accuracy
acc = ((length(theFiles) - dolentes) / length(theFiles)) * 100;

%Calculem Macros
macroF1 = (macroF1 / length(theFiles))*100;
macroRec = (macroRec / length(theFiles))*100;
macroPrec = (macroPrec / length(theFiles))*100;

%Mostrem per pantalla els valors trobats
fprintf("\n****Summary****\nMacro-Precision: %.3f \n", macroPrec);
fprintf("Macro-recall: %.3f  \n", macroRec);
fprintf("\nMacro-F1: %.3f \n", macroF1);
fprintf("Percentatge acert: %.3d \n", acc);


