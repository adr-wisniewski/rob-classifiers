function [homogenousSamples] = utilHomogenousSpace(samples)
	homogenousSamples = [repmat([1], size(samples,1), 1), samples];
end