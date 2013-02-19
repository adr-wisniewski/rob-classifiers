function [confidence] = estimateConfidence(labels, componentLabels, distances, planeLabels)
	% helper variables
	samples = size(labels, 1);
	confidence = zeros(samples, 1);
	
	for i=1:samples
		label = labels(i);
		if label != 10 % no confidence for no answer
			relevantPlanes = find(planeLabels(:,1) == label | planeLabels(:,2) == label);
			positivePlanes = relevantPlanes(componentLabels(i, relevantPlanes) == label);
			negativePlanes = relevantPlanes(componentLabels(i, relevantPlanes) != label);
			confidence(i) = sum(abs(distances(i, positivePlanes))) - sum(abs(distances(i, negativePlanes)));
		end
	end
endfunction