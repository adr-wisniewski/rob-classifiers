function [confusionMatrix] = createConfusionMatrix(lab, tstl)
	maxLabelIndex = max(tstl) + 1; 
	maxClassIndex = max(lab) + 1; 

	confusionMatrix = zeros(maxLabelIndex, maxClassIndex);
	for i=1:size(tstl,1)
		confusionMatrix(tstl(i)+1, lab(i)+1) = confusionMatrix(tstl(i)+1, lab(i)+1) + 1;
	end
end