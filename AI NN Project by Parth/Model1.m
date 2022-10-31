%Parth Joshi 1126914 COMP 4475 AI Project

rng("default");

% Partitioning the data set to have 70% training, 30% testing
partition = cvpartition(dataset.StarType, "HoldOut", 0.3);
trainingSet = training(partition);
testingSet = test(partition);
tblTrain = dataset(trainingSet, :);
tblTest = dataset(testingSet, :);

% Model 1
mdl1 = fitcnet(tblTrain, "StarType", "Standardize", true);

% Calculate accuracy
accuracy1 = 1 - loss(mdl1, tblTest, "StarType");

% Display confusion chart
confusionchart(tblTest.StarType, predict(mdl1,tblTest));

% Compare training cross-entropy loss and validation cross-entropy loss 
iteration = mdl1.TrainingHistory.Iteration;
trainLosses = mdl1.TrainingHistory.TrainingLoss;
valLosses = mdl1.TrainingHistory.ValidationLoss;
plot(iteration, trainLosses, "--", iteration, valLosses, "-");
legend(["Training","Validation"]);
xlabel("Iteration");
ylabel("Cross-Entropy Loss");
