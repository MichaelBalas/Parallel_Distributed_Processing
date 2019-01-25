
%% Initialize variables
numInputs = [4,10,16];
numOutputs = [2,6,10,14];
numPats = [2:1:24];
hebbLRate = 1;

%% Performance metrics (measuring output accuracy with Hemming Distance)
hebbPerf = zeros(1,length(numPats)); 
deltaPerf = zeros(1,length(numPats));

%% Run 1000 simulations to oberserve the average effects
%% of increased patter number on output accuracy, keeping input neuron
%% and output neuron numbers (10 & 2, respectively) constant
nSimulations = 1000;
for n = 1:nSimulations
    for i = 1:length(numPats)
        % The learning rate for the delta rule is equal to the reciprocal
        % of the number of input neurons
        deltaLRate = 1/numInputs(2);
        
        %% Create a set of M patterns
        % Initialize 'numInputs' (10) input neurons with 'numPats' patterns
        % of randomly generated binary values
        input = randi([0 1], numInputs(2), numPats(i));
        % Initialize 'numOutputs' (2) output neurons with 'numPats' 
        % patterns of randomly generated binary values
        target = randi([0,1], numOutputs(1), numPats(i));
        
        % Initialize weights to all 0's for Hebbian learning
        hebbWeights = zeros(numInputs(2), numOutputs(1)); 
        % Initialize weights to random values between 0 and 10 for delta rule
        deltaWeights = randi([0 10], numInputs(2), numOutputs(1));
        
        %% Train the linear pattern associators (LPA) and apply the Activation Functions
        %% to determine the outputs
        hebbTraining;
        deltaTraining;
        
        hebbOutput = linThresholdActivation(input, hebbWeights);
        deltaOutput = linThresholdActivation(input, deltaWeights);
        
        %% Update performance metrics every simulation
        hebbPerf(i) = hebbPerf(i) + hammingDistance(hebbOutput, target);
        deltaPerf(i) = deltaPerf(i) + hammingDistance(deltaOutput, target);
    end 
end
%% Divide total performance metrics by # simulations for average values
hebbPerf = hebbPerf/nSimulations;
deltaPerf = deltaPerf/nSimulations;
figure(1); hold on;
xlabel('Number of Patterns');
ylabel('% Accuracy of Output Pattern');
title('Accuracy with Increasing Pattern Number','FontSize',14);
plot(numPats,deltaPerf,'k-x','DisplayName','Delta Rule');
plot(numPats,hebbPerf,'r-*','DisplayName','Hebbian Learning');
hold off;
legend('show')

inputNeuronMetrics;
outputNeuronMetrics;
