%%ALGO 4 CALCUL DE LA F-SCORE%%

%Obrim la carpeta MASKS
% Especifiquem el directori de les masqueres ideals
FolderMask = 'MASKS/';
% Fem una llista amb tots els fitxers .jpg
filePatternMask = fullfile(FolderMask, '*.jpg'); % Change to whatever pattern you need.
theFilesMask = dir(filePatternMask);

%Obrim la carpeta MasksIdeal
FolderMaskIdeal = 'DataBase Train-Valid Prog 1 i 2/DataBase Train-Valid Prog 1  i  2/Validation-Dataset/Masks-Ideal/';
% Fem una llista amb tots els fitxers .jpg
filePatternMaskIdeal = fullfile(FolderMaskIdeal, '*.jpg'); % Change to whatever pattern you need.
theFilesMaskIdeal = dir(filePatternMaskIdeal);


float precision;
float recall;
float Fscore;

%comparar maskara amb la original
for k = 1 : length(theFilesMask)
 %Obrim les imatges
 baseFileNameMask = theFilesMask(k).name;
 fullFileNameMask = fullfile(theFilesMask(k).folder, baseFileNameMask);
 
 
 baseFileNameMaskIdeal = theFilesMaskIdeal(k).name;
 fullFileNameMaskIdeal = fullfile(theFilesMaskIdeal(k).folder, baseFileNameMaskIdeal);
 fprintf('Now comparing: %s with the ideal mask: %s\n', fullFileNameMaskIdeal, fullFileNameMask);
 
%calcular recall i precision 



end


%formula Fscore
Fscore = 2*((precision*recall)/(precision+recall));

fprintf("***Summary***\nAvarage precision: %f \n", precision);
fprintf("Avarage recall: %f \n", recall);
fprintf("\nF-Score: %f \n", Fscore);

