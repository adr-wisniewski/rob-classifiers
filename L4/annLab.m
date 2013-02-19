function [ann labels confidence signals confusionMatrix errors] = annLab(tvec, tlab, tstv, tstl)
	ann = annBuild(tvec, [15]);
	ann = annTrain(ann, tvec, tlab, 10);
	[labels confidence signals] = annTest(ann, tstv);
	confusionMatrix = utilCreateConfusionMatrix(labels, tstl);
	errors = utilCompErrors(confusionMatrix);
endfunction