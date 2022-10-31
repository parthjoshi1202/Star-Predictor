%Parth Joshi 1126914 COMP 4475 AI Project

rng("default");

% Partitioning the data set to have 70% training, 30% testing
partition = cvpartition(dataset.StarType, "HoldOut", 0.3);
trainingSet = training(partition);
testingSet = test(partition);
tblTrain = dataset(trainingSet, :);
tblTest = dataset(testingSet, :);

% Find regulization strength 
partition = cvpartition(tblTrain.StarType, "KFold", 5);
lambda = (0:0.5:5)*1e-4;
cvloss = zeros(length(lambda),1);

for i = 1:length(lambda)
    cvMdl = fitcnet(tblTrain,"StarType","Lambda",lambda(i), ...
        "CVPartition",partition,"Standardize",true);
    cvloss(i) = kfoldLoss(cvMdl,"LossFun","classiferror");
end

plot(lambda,cvloss);
xlabel("Regularization Strength");
ylabel("Cross-Validation Loss");
[~,idx] = min(cvloss);
bestLambda = lambda(idx);

% Model 4
mdl4 = fitcnet(dataset,"StarType","Lambda",bestLambda,"Standardize",true);

% Calculate accuracy
accuracy4 = 1 - loss(mdl4, tblTest, "StarType", "LossFun", "classiferror");

% Display confusion char
confusionchart(tblTest.StarType, predict(mdl4,tblTest));

% Compare training cross-entropy loss and validation cross-entropy loss 
iteration = mdl4.TrainingHistory.Iteration;
trainLosses = mdl4.TrainingHistory.TrainingLoss;
valLosses = mdl4.TrainingHistory.ValidationLoss;
plot(iteration, trainLosses, "--", iteration, valLosses, "-");
legend(["Training","Validation"]);
xlabel("Iteration");
ylabel("Cross-Entropy Loss");