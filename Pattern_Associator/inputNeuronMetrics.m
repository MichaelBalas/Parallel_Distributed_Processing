numPats = [2:1:28];
%% Performance metrics (measuring output accuracy with Hemming Distance)
hebbPerf = zeros(1,length(numPats)); 
deltaPerf = zeros(1,length(numPats));

plotStyle = {'k-x','b-*','r-o','m-+'};

%% Run 1000 simulations to oberserve the average effects
%% of increased input neuron number on output accuracy, keeping pattern
%% and output neuron numbers (2) constant
nSimulations = 1000;
for j = 1:length(numInputs)
    for n = 1:nSimulations
        for i = 1:length(numPats)
            % The learning rate for the delta rule is equal to the reciprocal
            % of the number of input neurons
            deltaLRate = 1/numInputs(j);

            %% Create a set of M patterns
            % Initialize 'numInputs' (10) input neurons with 'numPats' patterns
            % of randomly generated binary values
            input = randi([0 1], numInputs(j), numPats(i));
            % Initialize 'numOutputs' (2) output neurons with 'numPats' 
            % patterns of randomly generated binary values
            target = randi([0,1], numOutputs(1), numPats(i));

            % Initialize weights to all 0's for Hebbian learning
            hebbWeights = zeros(numInputs(j), numOutputs(1)); 
            % Initialize weights to random values between 0 and 10 for delta rule
            deltaWeights = randi([0 10], numInputs(j), numOutputs(1));

            %% Train the linear pattern associators (LPA) and apply the Activation Functions
            %% to determine the outputs
            deltaTraining;
            hebbTraining;

            hebbOutput = linThresholdActivation(input, hebbWeights);
            deltaOutput = linThresholdActivation(input, deltaWeights);
            
            %% Update performance metrics every simulation
            hebbPerf(i) = hebbPerf(i) + hammingDistance(hebbOutput, target);
            deltaPerf(i) = deltaPerf(i) + hammingDistance(deltaOutput, target);
        end
    end
    %% Delta Metrics
    deltaPerf = deltaPerf/nSimulations; %get for average values
    figure(2);
    plot(numPats,deltaPerf,plotStyle{j});
    hold on;
    deltaPerf = zeros(1,length(numPats));
    
    %% Hebbian Metrics
    hebbPerf = hebbPerf/nSimulations; %get for average values
    figure(3);
    plot(numPats,hebbPerf,plotStyle{j});
    hold on;
    hebbPerf = zeros(1,length(numPats));
    
    legendInfo{j} = ['# Input Neurons = ' num2str(numInputs(j))];

end
figure(2)
xlabel('Number of Patterns');
ylabel('% Accuracy of Output Pattern');
title('Accuracy with Increasing Input Neurons - Delta Rule','FontSize',14);
hold off;
legend(legendInfo)
figure(3); hold on;
xlabel('Number of Patterns');
ylabel('% Accuracy of Output Pattern');
title('Accuracy with Increasing Input Neurons - Hebb Learning','FontSize',14);
hold off;
legend(legendInfo)
