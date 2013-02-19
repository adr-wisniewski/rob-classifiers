function [planeLabels planes] = linearCreateClassifiers(tvec, tlab)
	% helper variables
	classesCount = 10;
	attributes = size(tvec, 2);
	classifiers = classesCount * (classesCount-1) / 2; % should be 45 for 10 classesCount
	
	% allocate return
	planeLabels = zeros(classifiers, 2);
	planes = zeros(classifiers, 1 + attributes);
	
	classifier = 0
	for i=0:8
		for j=(i+1):9
			classifier = classifier + 1;
			creatingModel = [classifier, i, j] % print
			planes(classifier, :) = perceptron(tvec(tlab == (i), :), tvec(tlab == (j), :));
			planeLabels(classifier, :) = [i, j];
		end
	end
endfunction