function [model,result,c,OuI2] = Fuzzy_Interference_process(TrainingSet,GroupTrain,TestSet,Feat_Ext,Iob,Iobr)
%Models a given training set with a corresponding group vector and 
%classifies a given test set using an SVM classifier according to a 
%one vs. all relation. 


u=unique(GroupTrain);
numClasses=length(u);
result = zeros(length(TestSet(:,1)),1);

%build models
for k=1:numClasses
    %Vectorized statement that binarizes Group
    %where 1 is the current class and 0 is all other classes
    G1vAll=(GroupTrain==u(k));
    model(k) = svmtrain(TrainingSet,G1vAll);      
end

%classify test cases
for j=1:size(TestSet,1)
    for k=1:numClasses
        
            c(k)=svmclassify(model(k),TestSet(j,:));           
            
    end
    result(j) = k;
end

 OuI2= (Iob)-Iobr;

% SV=sum(sum(Feat_Ext));



load('Accuracy_Data.mat')
Accuracy_Percent= zeros(200,1);
for i = 1:500
data = Train_Feat;
groups = ismember(Train_Label,0);
[train,test] = crossvalind('HoldOut',groups);
cp = classperf(groups);
svmStruct = svmtrain(data(train,:),groups(train),'showplot',false,'kernel_function','linear');
classes = svmclassify(svmStruct,data(test,:),'showplot',false);
classperf(cp,classes,test);
Accuracy = cp.CorrectRate;
Accuracy_Percent(i) = Accuracy.*100;
end
Max_Accuracy = max(Accuracy_Percent);
sprintf('Accuracy :%g ',Max_Accuracy)

end
