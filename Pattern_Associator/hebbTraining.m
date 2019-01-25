%% Weights of the net are computed from the training set by using
%% the outer product instead of iterative updating of weights used in
%% algorithm for Hebb rule
hebbWeights = hebbWeights + hebbLRate * (input * target');
