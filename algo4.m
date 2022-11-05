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


float tp; %true positives
float tn; %true negatives
float fp; %false positives
float fn; %false negative

int N;

%comparem la maskara generada amb la ideal
for k = 1 : length(theFilesMask)
 %Obrim les dues imatges
 baseFileNameMask = theFilesMask(k).name;
 fullFileNameMask = fullfile(theFilesMask(k).folder, baseFileNameMask);
 Mask = imread(fullFileNameNameMask);
 
 baseFileNameMaskIdeal = theFilesMaskIdeal(k).name;
 fullFileNameMaskIdeal = fullfile(theFilesMaskIdeal(k).folder, baseFileNameMaskIdeal);
 IdealMask = imread(fullFileNameMaskIdeal);

 fprintf('Now comparing: %s with the ideal mask: %s\n', fullFileNameMaskIdeal, fullFileNameMask);
 
 [rows, cols, val]=size(Mask);
 
 for i = 0 : rows
     for j = 0 : cols
         %N = N+1;
        if ((Mask(i,j)==IdealMask(i,j)) && Mask(i,j)==1)
            tp = tp + 1;
        elseif ((Mask(i,j)==IdealMask(i,j)) && Mask(i,j)==0)
            tn = tn + 1;
        elseif ((Mask(i,j)~=IdealMask(i,j)) && Mask(i,j)==1)
             fp = fp + 1;  
        else %((Mask(i,j)~=IdealMask(i,j)) && Mask(i,j)==0))
            fn = fn +1;
        end
     end
end

float precision;
float recall;
float fscore;
% tp = tp /N;
% tn = tn/N;
% fp = fp/N;
% fn = fn/N;

precision = tp/(tp+fp);
recall = tp/(tp+fn);
%formula Fscore
Fscore = 2*((precision*recall)/(precision+recall));

fprintf("****Summary****\nAvarage precision: %f \n", precision);
fprintf("Avarage recall: %f \n", recall);
fprintf("\nF-Score: %f \n", fscore);

