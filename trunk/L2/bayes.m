function ret = bayes(train, classes, test, method)

	methodIndependent = 1;
	methodPolynominal = 2;
	methodParzen = 3;

	aprioriProbability = [0.33,0.33,0.17,0.17];
	attributes = size(train, 2);

	# loop for all classes
	densities = [];
	for i = 1:4 
		data = train(classes == i,:);

		if(method == methodIndependent || method == methodPolynominal)
			meanVal = mean(data);	
			covVal = cov(data);

			if(method == methodIndependent)
				 covVal = covVal .* eye(attributes);
			end

			density = mvnpdf(test, meanVal, covVal);	
		elseif(method == methodParzen)
			h1 = 0.0001;
			dataSamples = size(data, 1);
			hn2 = h1^2/dataSamples;	
			covVal = eye(attributes) * hn2;
			
			density = 0;
			for j = 1:dataSamples
				density = density + mvnpdf(test, data(j,:), covVal);
			end

			density = density ./ dataSamples;
		else
			"BAD METHOD!"
		end

		
		density = density .* aprioriProbability(i);
		densities = [densities, density];
	end

	[_, class] = max(densities');
	ret = class';
endfunction