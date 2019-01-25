%% Weights of the net are computed by subtacting the actual output
%% from the desired, or target, values, in order to minimize the error
output = zeros(size(target));
nepochs = 1000;
for iter = 1:nepochs
    deltaWeights = deltaWeights + deltaLRate * ((target - output) * input')';
    output = deltaWeights' * input;
end