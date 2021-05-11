function [model,result,SV] = svm_new(Feat_Ext,Iob,Iobr,Feat_val)
%Models a given training set with a corresponding group vector and 
%classifies a given test set using an SVM classifier according to a 
%one vs. all relation. 
disp('CLASSIFICATION OF PATTERN'); 
disp('-----------------');
disp('-----------------');
TrainingSet=[1;2;3;4;5;6;7;8;9;10]; 
TestSet=[1;2]; 
GroupTrain=[1;1;1;1;1;2;2;2;2;2]; 
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
        %if svmclassify(model(k),TestSet(j,:)); 
            c(k)=svmclassify(model(k),TestSet(j,:));           
            %break;
            %end
    end
    result(j) = k;
end
[I3,RGB] = createMask(Feat_val);
        seg_img = RGB;
 figure, imshow(seg_img); title('SVM classified Image');
[R C]=size(Feat_Ext);
SV=(sum(sum(Feat_Ext))/(R*C));

if SV>150
     disp('Healthy Leaf');      
else
   disp('Defected Leaf'); 
   
end        



end
