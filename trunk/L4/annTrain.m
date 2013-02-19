function ann = annTrain(ann_in, tvec, tlab, epochs)
	ann = ann_in;
	
	% config
	layersCount = size(ann, 2);
	outLayerNeurons = size(ann{layersCount}, 1);
	samplesCount = size(tvec, 1);
	learningFactor = 0.005;
	errorThreshold = 0;

	% training
	for epoch=1:epochs
		epoch
		cumulativeError = 0;
		randomSamples = randperm(samplesCount);
		
		for sampleIndex = 1:samplesCount
			% print progress
			if mod(sampleIndex, 5000) == 0
				progress = 100 * (sampleIndex + (epoch-1) * samplesCount) / (epochs * samplesCount)
			end

			% propagate activation
			signal = {tvec(randomSamples(sampleIndex), :)};
			for layerIndex = 2:layersCount
				currentLayerWeights = ann{layerIndex};
				currentLayerIn = repmat([1, signal{layerIndex - 1}], size(currentLayerWeights, 1), 1);
				currentLayerNet = sum(currentLayerIn .* currentLayerWeights, 2)';
				signal{layerIndex} = 2 ./ (1 + exp(-currentLayerNet)) - 1;
			end
			
			% propagate errors
			errors = {};
			expectedSignal = repmat([-1], 1, outLayerNeurons);
			expectedSignal(tlab(randomSamples(sampleIndex)) + 1) = 1;
			netError = expectedSignal - signal{layersCount};
			cumulativeError = cumulativeError + sum(abs(netError), 2);
			for layerIndex = layersCount:-1:2
				if layerIndex == layersCount
					propagatedErrors = netError;
				else
					% tutaj jest blad
					propagatedErrors = sum(ann{layerIndex+1} .* repmat(errors{layerIndex + 1}', 1, size(ann{layerIndex+1},2))); %'
					propagatedErrors = propagatedErrors(2:end); % column 1 contains weights for constant signal
				end

				% tutaj sprawdzic znak (ale chyba jest ok)
				signalDerivative = 0.5 * ( 1 - signal{layerIndex}.^2);
				errors{layerIndex} = signalDerivative .* propagatedErrors;
			end
			
			% update weights
			for layerIndex = 2:layersCount
				inputSignal = repmat([1, signal{layerIndex - 1}], size(ann{layerIndex}, 1), 1);
				errorSignal = repmat(errors{layerIndex}', 1, size(inputSignal, 2)); % '
				weightDelta = ( inputSignal .* errorSignal);
				ann{layerIndex} = ann{layerIndex} .+ (learningFactor .* weightDelta);
			end
		end
		
		cumulativeError
		
		if cumulativeError < errorThreshold 
			break;
		end
	end
end