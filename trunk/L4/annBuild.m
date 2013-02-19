function ann = annBuild(tvec, hiddenLayerNeurons)
	% config
	inLayerNeurons = size(tvec, 2);
	outLayerNeurons = 10;
	layerNeurons = [inLayerNeurons, hiddenLayerNeurons, outLayerNeurons];
	
	% layers
	ann = {};
	
	% each layer has layerNeurons(layerIndex) neurons with layerNeurons(layerIndex - 1) + 1 weights
	% (number of neutrons in previous layer plus 1 for constant 1 signal)
	for layerIndex = 2:size(layerNeurons, 2) ann{layerIndex} = rand(layerNeurons(layerIndex), layerNeurons(layerIndex - 1) + 1) - 0.5; end
	
endfunction