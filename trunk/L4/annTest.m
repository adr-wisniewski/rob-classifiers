function [labels confidence signals] = annTest(ann, tstv)
	samplesCount = size(tstv, 1);
	layersCount = size(ann, 2);
	labels = zeros(size(tstv,1), 1);
	confidence = zeros(size(tstv,1), 1);
	signals = zeros(size(tstv,1), size(ann{layersCount},1));
	
	for sampleIndex = 1:samplesCount
		signal = tstv(sampleIndex, :);
		for layerIndex = 2:layersCount
			currentLayerWeights = ann{layerIndex};
			currentLayerIn = repmat([1, signal], size(currentLayerWeights, 1), 1);
			currentLayerNet = sum(currentLayerIn .* currentLayerWeights, 2)';
			signal = 2 ./ (1 + exp(-currentLayerNet)) - 1;
		end
		
		[s sidx] = sort(signal, 'descend');
		label = 10; % no decision label
		conf = 0;
		
		if signal(sidx(1)) > 0 && signal(sidx(1)) - signal(sidx(2)) > 0.3
			conf = max(signal(sidx(1))^2 - sum(signal(signal > 0)) + signal(sidx(1)), 0);
			label = sidx(1) - 1;
		end
		
		labels(sampleIndex) = label;
		confidence(sampleIndex) = conf;
		signals(sampleIndex, :) = signal;
	end
end