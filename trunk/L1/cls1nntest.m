function errors = cls1nntest(dataset)
	errors = 0
	for sampleidx = 1:size(dataset)(1)
		label = cls1nn(dataset(1:size(dataset)(1) != sampleidx,:), dataset(sampleidx, 2:end));
		error = (label - dataset(sampleidx, 1))^2;
		errors = errors + error
	endfor
	errors 
endfunction

#error for all 4 attributes [2 3 4 5] = 6
#error for all 3 attributes [2 3 4  ] = 12
#error for all 3 attributes [2 3   5] = 8
#error for all 3 attributes [2   4 5] = 8
#error for all 3 attributes [  3 4 5] = 7
#error for all 2 attributes [2 3    ] = 43
#error for all 2 attributes [2   4  ] = 16
#error for all 2 attributes [2     5] = 11
#error for all 2 attributes [  3 4  ] = 16
#error for all 2 attributes [  3   5] = 12
#error for all 2 attributes [    4 5] = 8