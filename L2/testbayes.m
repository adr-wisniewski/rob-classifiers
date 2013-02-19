function ret = testbayes(train, test, method, columns)

	train = train(:, [1, columns]);
	test = test(:, [1, columns]);

	train_filtered = preprocess(train, 0.05);
	train_filtered_classes = train_filtered(:,1);
	train_filtered_data = train_filtered(:,2:end);

	test_classes = test(:,1);
	test_data = test(:,2:end);

	classification = bayes(train_filtered_data, train_filtered_classes, test_data, method);

	errors=sum(classification != test_classes);
	errors_percent = errors/size(test)(1);

	ret = [errors, errors_percent, 1-errors_percent];
end