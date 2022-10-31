%Parth Joshi 1126914 COMP 4475 AI Project

rng("default");

% Partitioning the data set to have 70% training, 30% testing
partition = cvpartition(dataset.StarType, "HoldOut", 0.3);
trainingSet = training(partition);
testingSet = test(partition);
tblTrain = dataset(trainingSet, :);
tblTest = dataset(testingSet, :);

% Model 2
mdl2 = fitcnet(tblTrain, "StarType", "OptimizeHyperparameters","auto", "HyperparameterOptimizationOptions", ...
    struct("AcquisitionFunctionName", "expected-improvement-plus", "MaxObjectiveEvaluations", 200));

% Calculate accuracy
accuracy2 = 1 - loss(mdl2, tblTest, "StarType");

% Display confusion chart
confusionchart(tblTest.StarType, predict(mdl2,tblTest));


% Compare training cross-entropy loss and validation cross-entropy loss 
iteration = mdl2.TrainingHistory.Iteration;
trainLosses = mdl2.TrainingHistory.TrainingLoss;
valLosses = mdl2.TrainingHistory.ValidationLoss;
plot(iteration, trainLosses, "--", iteration, valLosses, "-");
legend(["Training","Validation"]);
xlabel("Iteration");
ylabel("Cross-Entropy Loss");