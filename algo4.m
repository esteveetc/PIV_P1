%ALGO4

%Obrim la carpeta MASKS
% Especifiquem el directori de les masqueres ideals
FolderMask = 'Masks/';
% Fem una llista amb tots els fitxers .jpg
filePatternMask = fullfile(FolderMask, '*.bmp'); % Change to whatever pattern you need.
theFilesMask = dir(filePatternMask);

%Obrim la carpeta MasksIdeal
FolderMaskIdeal = 'DataBase Train-Valid Prog 1 i 2/DataBase Train-Valid Prog 1  i  2/Validation-Dataset/Masks-Ideal/';
% Fem una llista amb tots els fitxers .jpg
filePatternMaskIdeal = fullfile(FolderMaskIdeal, '*.bmp'); % Change to whatever pattern you need.
theFilesMaskIdeal = dir(filePatternMaskIdeal);

double tp; %true positive
double tn; %true negatives
double fp; %false positives
double fn; %false negative

%Inicialitzem a 0
tp  = 0;
tn = 0;
fp = 0;
fn = 0;

%Comparem la maskara generada amb la ideal
for k = 1 : length(theFilesMask)
 %tic
 %Obrim les dues imatges
 baseFileNameMask = theFilesMask(k).name;
 fullFileNameMask = fullfile(theFilesMask(k).folder, baseFileNameMask);
 Mask = imread(fullFileNameMask);
 
 baseFileNameMaskIdeal = theFilesMaskIdeal(k).name;
 fullFileNameMaskIdeal = fullfile(theFilesMaskIdeal(k).folder, baseFileNameMaskIdeal);
 IdealMask = imread(fullFileNameMaskIdeal);

 fprintf('Now comparing: %s with the ideal mask: %s\n', baseFileNameMaskIdeal, baseFileNameMask);
 
 [rows, cols, ~]=size(Mask);
 
 %Dividim per 255 perque al cambiar a format bmp no podem modificar la seva
 %Capçalera i se'ns guarda amb valors 0 o 255.
 Mask1 = Mask/255;
 
 %Recorrem la imatge classificant els pixels amb les seva mascara ideal
 IdealMask = ~IdealMask;
 for i = 1 : rows
     for j = 1 : cols
        if ((Mask1(i,j)==IdealMask(i,j)) && Mask1(i,j)==0)
            tn = tn + 1;
        elseif ((Mask1(i,j)==IdealMask(i,j)) && Mask1(i,j)==1)
            tp = tp + 1;
        elseif ((Mask1(i,j)~=IdealMask(i,j)) && Mask1(i,j)==0)
             fn = fn + 1;  
        elseif ((Mask1(i,j)~=IdealMask(i,j)) && Mask1(i,j)==1)
            fp = fp + 1;
        end
     end
 end
 %toc
end

%Calculem la F-Score
double precision;
double recall;
double fscore;

precision = tp/(tp+fp);
recall = tp/(tp+fn);

%fórmula Fscore
fscore = 2*((precision*recall)/(precision+recall));

%Mostrem per pantalla els valors trobats
fprintf("\n****Summary****\nAvarage precision: %f \n", precision);
fprintf("Avarage recall: %f \n", recall);
fprintf("\nF-Score: %f \n", fscore);

