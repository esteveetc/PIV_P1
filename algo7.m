%Algo7
function [fscore, recall, precision] = algo7(n, dits)
%F-Score

double tp; %true positive
double tn; %true negatives
double fp; %false positives
double fn; %false negative

%Inicialitzem a 0
tp  = 0;
tn = 0;
fp = 0;
fn = 0;

tp = min(n,dits); 

tn = 5 - max(n,dits);

if (tp < dits)
    fn = dits - tp;
elseif (tp < n)
    fp = n - tp;
end

%Calculem la F-Score
double precision;
double recall;
double fscore;

precision = 0;
recall = 0;
fscore = 0;

precision = tp/(tp+fp);
recall = tp/(tp+fn);

%fórmula Fscore
fscore = 2*((precision*recall)/(precision+recall));

end