% cd D:\Projekty\ROB\L3

% create classifiers
[tvec tlab tstv tstl] = readSets(); 
[mu trmx] = prepTransform(tvec, 40);
tvec = pcaTransform(tvec, mu, trmx);
tstv = pcaTransform(tstv, mu, trmx);
[planeLabels planes] = linearCreateClassifiers(tvec, tlab);
% save planeLabels.txt planeLabels
% save planes.txt planes

% load planeLabels.txt
% load planes.txt
[labels componentLabels distances] = linearClassify(planeLabels, planes, tstv);
confusionMatrix = createConfusionMatrix(labels, tstl);
errors = compErrors(confusionMatrix);
[pConfusionMatrices pErrors] = testPerceptrons(planeLabels, planes, tstv, tstl);
confidence = estimateConfidence(labels, componentLabels, distances, planeLabels);

% save labels.txt labels
% save confusionMatrix.txt confusionMatrix

lol = zeros(10, 1);
for i=1:10
	lol(i) = confusionMatrix(i, i) / sum(tstl==i-1);
end



sampA = ttvecA(1:end,:);
sampB = ttvecB(1:end,:);

w = perceptron(sampA, sampB);

figure (1);
plot(sampA(:,1), sampA(:,2), ".g", sampB(:,1), sampB(:,2), ".b");

distancesA = 1 * w(1) + sum(sampA .* w(2:end),2);
distancesB = 1 * w(1) + sum(sampB .* w(2:end),2);
lw = sqrt(sum(w(2:end) .^ 2));
wn = w;
wn /= lw;
w2 = wn(2:end)
w0 = w2 * -wn(1)
pts=repmat(w0, 2, 1) + [-10;10] * [w2(2) -w2(1)];
figure (2);
plot(sampA(distancesA>=0,1), sampA(distancesA>=0,2), ".g" , sampA(distancesA<0,1), sampA(distancesA<0,2), "+y",sampB(distancesB>=0,1), sampB(distancesB>=0,2), "+r", sampB(distancesB<0,1), sampB(distancesB<0,2), ".b", [w0(1); w0(1)+w2(1)], [w0(2); w0(2)+w2(2)], "r", pts(:,1), pts(:,2),"-y");
errors=sum(distancesA<0) + sum(distancesB>=0)

