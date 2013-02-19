function label = cls1nn(dataset, sample)
	offsets = dataset(:, 2:end) - repmat(sample, size(dataset)(1), 1);
	distaces = sum(offsets .^ 2, 2);
	[minimal, closest] = min(distaces);
	label = dataset(closest, 1);
endfunction