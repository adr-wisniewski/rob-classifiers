function [labels componentLabels distances] = linearClassify(planeLabels, planes, tstv)

	% helper variables
	classifiers = size(planes,1);
	testsamples = size(tstv, 1);
	noClassValue = 10;
	
	% allocate return
	componentLabels = zeros(testsamples, classifiers);
	distances = zeros(testsamples, classifiers);
	
	% get 45 component labels from each linear classifier
	for classifier=1:classifiers
		distances(:, classifier) = 1 * planes(classifier,1) + sum(tstv .* repmat(planes(classifier,2:end), testsamples, 1),2);
		componentLabels(:,classifier) = ifelse(distances(:, classifier) >= 0, planeLabels(classifier, 1), planeLabels(classifier, 2));
	end
	
	% calculate most frequent result (in case of clash - give no answer)
	[labels confidence cells] = mode(componentLabels, 2);
	noMostFrequent = cellfun('size', cells, 1)' > 1;
	labels(noMostFrequent) = noClassValue;
endfunction