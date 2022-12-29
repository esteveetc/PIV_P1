%Algo7
function [fscore, recall, precision] = algo7(n,dits)
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

% fprintf("dits %d --- n: %d \n", dits,n);


tp = min(n,dits); 
tn = 5 - max(n,dits);

if (tp < dits)
    fn = dits - tp;
elseif (tp < n)
    fp = n - tp;
end


% fprintf("tp %d ---- tn: %d \n", tp,tn);
% fprintf("fn %d ---- fp: %d \n", fn,fp);

%Calculem la F-Score
double precision;
double recall;
double fscore;

precision = 0;
recall = 0;
fscore = 0;

if (tp+fp) == 0
    precision = 0;
else
    precision = tp /(tp+fp);
end

if (tp+fn) == 0
    recall = 0;
else
    recall = tp /(tp+fn);
end

%fórmula Fscore
if (precision+recall) == 0
    fscore = 0;
else
    fscore = 2*((precision*recall)/(precision+recall));
end

% fprintf("fscore %f ---- precision: %f ---- recall: %f \n", fscore,precision,recall);

end