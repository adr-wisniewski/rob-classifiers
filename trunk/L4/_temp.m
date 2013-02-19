cd D:\Projekty\ROB\L4

% create classifiers
[tvec tlab tstv tstl] = utilReadSets(); 
[mu trmx] = pcaPrepTransform(tvec, 40);
tvec = pcaTransform(tvec, mu, trmx);
tstv = pcaTransform(tstv, mu, trmx);

ann = annBuild(tvec);
ann = annTrain(ann, tvec, tlab);
[labels confidence signals] = annTest(ann, tstv);
confusionMatrix = utilCreateConfusionMatrix(labels, tstl);
errors = utilCompErrors(confusionMatrix)