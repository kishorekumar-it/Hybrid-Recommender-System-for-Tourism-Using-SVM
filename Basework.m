

clc
clear all
close all

TourismList = loadTourismList();

%  Initialize my ratings
my_ratings = zeros(1682, 1);


my_ratings(1) = 4;


my_ratings(98) = 2;

% We have selected a few Tourisms we liked / did not like and the ratings we
% gave are as follows:
my_ratings(7) = 3;
my_ratings(12)= 5;
my_ratings(54) = 4;
my_ratings(64)= 5;
my_ratings(66)= 3;
my_ratings(69) = 5;
my_ratings(183) = 4;
my_ratings(226) = 5;
my_ratings(355)= 5;

fprintf('\n\nNew user ratings:\n');
for i = 1:length(my_ratings)
    if my_ratings(i) > 0 
        fprintf('Rated %d for %s\n', my_ratings(i), ...
                 TourismList{i});
    end
end

fprintf('\nProgram paused. Press enter to continue.\n');
pause;


%% ================== Learning Tourism Ratings ====================
%  Now, we will train the collaborative filtering model on a Tourism rating 
%  dataset of 1682 Tourisms and 943 users
%

fprintf('\nTraining collaborative filtering...\n');

%  Load data
load('ex8_Tourisms.mat');

%  Add our own ratings to the data matrix
Y = [my_ratings Y];
R = [(my_ratings ~= 0) R];

%  Normalize Ratings
[Ynorm, Ymean] = normalizeRatings(Y, R);

%  Useful Values
num_users = size(Y, 2);
num_Tourisms = size(Y, 1);
num_features = 10;

% Set Initial Parameters (Theta, X)
X = randn(num_Tourisms, num_features);
Theta = randn(num_users, num_features);

initial_parameters = [X(:); Theta(:)];

% Set options for fmincg
options = optimset('GradObj', 'on', 'MaxIter', 100);

% Set Regularization
lambda = 10;
theta = fmincg (@(t)(cofiCostFunc(t, Ynorm, R, num_users, num_Tourisms, ...
                                num_features, lambda)), ...
                initial_parameters, options);

% Unfold the returned theta back into U and W
X = reshape(theta(1:num_Tourisms*num_features), num_Tourisms, num_features);
Theta = reshape(theta(num_Tourisms*num_features+1:end), ...
                num_users, num_features);

fprintf('Recommender system learning completed.\n');

fprintf('\nProgram paused. Press enter to continue.\n');
pause;

%% ==================Recommendation for us ====================

p = X * Theta';
my_predictions = p(:,1) + Ymean;

TourismList = loadTourismList();

[r, ix] = sort(my_predictions, 'descend');
fprintf('\nTop recommendations for new user:\n');
for i=1:10
    j = ix(i);
    fprintf('Predicting rating %.1f for Tourism %s\n', my_predictions(j), ...
            TourismList{j});
end


fprintf('\n\nOriginal ratings provided:\n');
for i = 1:length(my_ratings)
    if my_ratings(i) > 0 
        fprintf('Rated %d for %s\n', my_ratings(i), ...
                 TourismList{i});
    end
end

Data = xlsread('Tour_feature.xlsx')
save Training_Data.mat Data
load('Training_Data.mat')
train_label={zeros(1,1),ones(1,1),2*ones(1,1),3*ones(1,1),4*ones(1,1)};
train_cell={Data(1,:),Data(2,:),Data(3,:),Data(4,:),Data(5,:)};
[svmstruct,level] = Train_DSVM(train_cell,train_label);
labels=[0 1 2 3 4 ];
feat_Tourism=Ymean'
feat_Tourism=feat_Tourism(1,1:13)
[Class_test] = Classify_DSVM(feat_Tourism,labels,svmstruct,level)


Accuracy = Evaluate(Y,Ynorm)



