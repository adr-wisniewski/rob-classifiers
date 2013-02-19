function [pConfusionMatrices pErrors] = testPerceptrons(planeLabels, planes, tstv, tstl)
	% helper variables
	planesCount = size(planes, 1);

	% result
	pConfusionMatrices = zeros(2, 3, planesCount);
	pErrors = zeros(planesCount, 3);
	
	for i=1:planesCount
		plane = planes(i, :);
		labelA = planeLabels(i, 1);
		labelB = planeLabels(i, 2);
		samplesA = tstv(tstl == labelA, :);
		samplesB = tstv(tstl == labelB, :);
		
		distancesA = 1 * plane(1) + sum(samplesA .* repmat(plane(2:end), size(samplesA, 1), 1),2);
		distancesB = 1 * plane(1) + sum(samplesB .* repmat(plane(2:end), size(samplesB, 1), 1),2);
		
		% sum doesnt work for 3d matrices?
		pConfusionMatrices(1, 1, i) = sum(distancesA >= 0);
		pConfusionMatrices(1, 2, i) = sum(distancesA <  0);
		pConfusionMatrices(2, 2, i) = sum(distancesB <  0);
		pConfusionMatrices(2, 1, i) = sum(distancesB >= 0);
		all = pConfusionMatrices(1, 1, i) + pConfusionMatrices(1, 2, i) + pConfusionMatrices(2, 2, i) + pConfusionMatrices(2, 1, i);
		pErrors(i, 1) = (pConfusionMatrices(1, 1, i) + pConfusionMatrices(2, 2, i)) / all;
		pErrors(i, 2) = (pConfusionMatrices(1, 2, i) + pConfusionMatrices(2, 1, i)) / all;
		pErrors(i, 3) = 0;
	end
endfunction