function [weights] = perceptron(positive, negative)

	% configuration variables
	epochs = 10;
	enableEpochDimishing = 1;
	epochErrorThreshold = 0;
	constLearningFactor = 0.005 * 2; % const 2 is here to confirm to Rosenblatt rule, since error is {-1, 0, 1}
	
	% helper variables
	attributes = size(positive, 2);
	
	% allocate return vector
	% TODO - initial weght values : (rand(attributes, 1) - 0.5) * 2
	weights = zeros(1, attributes + 1);
	
	samples = [positive;negative];	
	samplesCount = size(samples, 1);
	positiveCount = size(positive, 1);
	labels = repmat(0, samplesCount, 1);
	labels(1:positiveCount) = 1;
	
	for epoch=1:epochs
		epochErrors = 0;
		epochLearningFactor = constLearningFactor / ifelse(enableEpochDimishing, epoch, 1);
		order = randperm(samplesCount);
		
		for sampleIndex = 1:samplesCount
			sample = order(sampleIndex);
			samplevec = samples(sample, :);
			samplelab = labels(sample);
			
			distance = 1 * weights(1) + sum(samplevec .* weights(2:end), 2);
			error = samplelab - (distance > 0);
			weights(1) += error * epochLearningFactor;
			weights(2:end) += error * epochLearningFactor * samplevec;
			epochErrors += abs(error);
		end
	
		if epochErrors / samplesCount < epochErrorThreshold
			break;
		end
	end

endfunction