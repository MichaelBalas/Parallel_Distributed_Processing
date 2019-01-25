% To produce the correct output for all the training inputs, 
% we test the ability of the net by using the activation function
function [ outputVec ] = linActivation(input, weights)
%% Activation Function: f(x) = x
outputVec = (weights' * input);

end