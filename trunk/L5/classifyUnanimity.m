function labels = classifyUnanimity(tstv)
	labels = repmat([10], size(tstv, 1), 1);
	unanimity = tstv(:,1) == tstv(:,2) & tstv(:,1) == tstv(:,3) & tstv(:,1) == tstv(:,4) & tstv(:,1) == tstv(:,5);
	labels(unanimity) = tstv(unanimity, 1); 
end