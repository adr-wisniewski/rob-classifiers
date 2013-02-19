function [confusionMatrix] = utilCreateConfusionMatrix(lab, tstl, classes)
	maxClassIndex = classes; 
	maxLabelIndex = classes + 1; 

	confusionMatrix = zeros(maxClassIndex, maxLabelIndex);
	for i=1:size(tstl,1)
		confusionMatrix(tstl(i)+1, lab(i)+1) = confusionMatrix(tstl(i)+1, lab(i)+1) + 1;
	end
end