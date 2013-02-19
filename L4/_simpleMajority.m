function [confmx] = simpleMajority(labknn, tstl)
% simple absolut majority classifier
% labknn - matrix containing nearest neighbours labels
%	each row contains NN labels for one test element
% tstl - test set labels (ground truth)
% confmx - confusion matrix of the classifier
	treshold = floor(size(labknn, 2)/2) + 1;
	reject = max(tstl) + 1; 
	[lab f] = mode(labknn');
	lab(f < treshold) = reject;
	
	confmx = zeros(reject, reject+1);
	for i=1:size(tstl,1)
		confmx(tstl(i)+1, lab(i)+1) = confmx(tstl(i)+1, lab(i)+1) + 1;
	end
