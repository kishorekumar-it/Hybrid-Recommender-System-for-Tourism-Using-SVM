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
