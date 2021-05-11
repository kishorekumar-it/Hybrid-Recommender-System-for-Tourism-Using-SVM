
function EVAL = Evaluate(ACTUAL,PREDICTED)


idx = (ACTUAL()==1);

p = length(ACTUAL(idx));
n = length(ACTUAL(~idx));
N = p+n;

tp = sum(ACTUAL(idx)==PREDICTED(idx));
tn = sum(ACTUAL(~idx)==PREDICTED(~idx));
fp = n-tn;
fn = p-tp;

tp_rate = tp/p;
tn_rate = tn/n;

accuracy=((tp+tn)/(tp+tn+fp+fn))*100;
% sensitivity = tp/(tp+fn);
% specificity = tn/(tn+fp);

EVAL = [accuracy  ];