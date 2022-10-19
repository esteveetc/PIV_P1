%ALGO3

% Especifiquem el directori de les imatges de training
myFolder = 'DataBase Train-Valid Prog 1 i 2/DataBase Train-Valid Prog 1  i  2/Training-Dataset/Images/';

% Fem una llista amb tots els fitxers .jpg
filePattern = fullfile(myFolder, '*.jpg'); % Change to whatever pattern you need.

theFiles = dir(filePattern);

%recorrem els fitxers
%for k = 1 : length(theFiles)
for k = 10 : 20
    baseFileName = theFiles(k).name;
    fullFileName = fullfile(theFiles(k).folder, baseFileName);
    fprintf('Now processing... %s\n', fullFileName);
    im = imread(fullFileName);
    
    Mask = algo2(fullFileName);
    
    imshow(Mask);
end