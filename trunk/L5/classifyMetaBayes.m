function [labels] = classifyMetaBayes(tvec, tlab, tstv, threshold)
	classifiersCount = size(tvec, 2);
	testSamplesCount = size(tstv, 1);
	
	% calculate confusion matrices
	C = {};
	for classifierIndex = 1:classifiersCount
		C{classifierIndex} = utilCreateConfusionMatrix(tvec(:, classifierIndex), tlab, 10);
	end
	
	% calculate probability distributions
	P = {};
	minimal = 1;
	for classifierIndex = 1:classifiersCount
		c = C{classifierIndex};
		sums = sum(c);
		sums(sums == 0) = 1; % if cell has 0 entries, we can divide by anything except 0, because 0/n == 0
		P{classifierIndex} = c ./ repmat(sums, size(c, 1), 1);
		
		% calculate minimal element of all matrices
		p = P{classifierIndex};
		p( p == 0 ) = minimal;
		minimal = min(min(p));
	end
	
	% get rid of zeroes
	minimal = minimal / 10;
	for classifierIndex = 1:classifiersCount
		P{classifierIndex}(P{classifierIndex} == 0) = minimal;
	end

	% classify
	labels = zeros(testSamplesCount, 1);
	believability = zeros(testSamplesCount, 10);
	for sampleIndex = 1:testSamplesCount
		sample = tstv(sampleIndex, :);
		
		% calculate believability
		bel = ones(10, 1);
		for classifierIndex = 1:classifiersCount
			bel = bel .* P{classifierIndex}(:, sample(classifierIndex) + 1);
		end
		bel = bel / sum(bel);
		
		% pick best guess
		[best, bestidx] = max(bel);
		
		label = 10; % no decision label
		if best > threshold 
			label = bestidx - 1;
		end
		
		labels(sampleIndex, :) = label;
		believability(sampleIndex, :) = bel';
	end
end