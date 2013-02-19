function ret = preprocess(data, drop_percentage)

	[initialCount, columns] = size(data);
	pass_drop_percentage = drop_percentage/(columns-1);

	for columnIndex = 2:columns
		
		column = data(:,columnIndex);
		[count, _] = size(column);
	
		minIndex = max(1, floor(count * pass_drop_percentage));
		maxIndex = min(count, floor(count * (1-pass_drop_percentage)));

		sorted = sort(column);
		minValue = sorted(minIndex);
		maxValue = sorted(maxIndex);

		valid = column >= minValue & column <= maxIndex;
		data = data(valid, :);
	endfor

	[endCount, _] = size(data);
	filtered = initialCount - endCount;
	ret = data;
end