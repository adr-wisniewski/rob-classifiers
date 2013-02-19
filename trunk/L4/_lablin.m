function [planeLabels planes labels componentLabels confidence confusionMatrix errors pConfusionMatrices pErrors] = lablin(tvec, tlab, tstv, tstl)
	
	[planeLabels planes] = linearCreateClassifiers(tvec, tlab);
	[labels componentLabels confidence] = linearClassify(planeLabels, planes, tstv);
	confusionMatrix = createConfusionMatrix(labels, tstl);
	errors = compErrors(confusionMatrix);
	[pConfusionMatrices pErrors] = testPerceptrons(planeLabels, planes, tstv, tstl);
	confidence = estimateConfidence(labels, componentLabels, distances, planeLabels);
	
endfunction