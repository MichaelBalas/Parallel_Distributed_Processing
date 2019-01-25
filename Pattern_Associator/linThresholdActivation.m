% To produce the correct output for all the training inputs, 
% we test the ability of the net by using the activation function
function [ outputVec ] = linThresholdActivation(input, weights)
%% Activation Function: f(x) = 1 if x > 0; 0 if x ≤ 0
output = (weights' * input);
outputVec = double(output > 0.5);

end

