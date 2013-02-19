function ret = bestbayes(train, test, method)

	bestErrors = size(test,1);
	bestAttributes = [];

	for attributes=2:2
		permutations = nchoosek([2:7], attributes);

		for permutation = 1:size(permutations,1)
			currentAttributes = permutations(permutation,:);

			result = testbayes(train, test, method, currentAttributes);
			errors = result(1);
			
			if(errors < bestErrors)
				bestErrors = errors;
				bestAttributes = currentAttributes;
				bestResult = result;
			end	
		end
	end

	bestResult
	ret = bestAttributes;
end