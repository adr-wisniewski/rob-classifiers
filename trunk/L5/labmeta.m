function [result] = labmeta(rec_in, tstl_in)

	thresholds = [0.5, 0.7, 0.8, 0.9, 0.95, 0.97, 0.99, 0.995, 0.999, 0.9995];

	% split samples
	samplesCount = size(rec_in, 1);
	classifiersCount = size(rec_in, 2);
	trainSamples = randperm(samplesCount) <= samplesCount/2;
	
	tvec = rec_in(trainSamples, :);
	tlab = tstl_in(trainSamples, :);
	tstv = rec_in(!trainSamples, :);
	tstl = tstl_in(!trainSamples, :);

	result = zeros(size(thresholds, 2), 1 + 3);
	for index = 1:size(thresholds, 2)
		threshold = thresholds(index);
		[labels believability] = classifyMetaBayes(tvec, tlab, tstv, threshold);
		confusionMatrix = utilCreateConfusionMatrix(labels, tstl, 10);
		errors = utilCompErrors(confusionMatrix);
		
		result(index, 1) = threshold;
		result(index, 2:end) = errors;
	end
end