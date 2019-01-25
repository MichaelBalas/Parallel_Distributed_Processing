%% Calculates the number of positions where two binary vectors differ,
%% and converts it into a percentage as an indicator of output accuracy
function [ percentage ] = hammingDistance(output, target)
count = 0;
for i = 1:size(output,1)
    for j = 1:size(output,2)
        if ~(isequal(output(i,j),target(i,j)))
            count = count + 1;
        end
    end
prop = 1 - (count / numel(output));
percentage = prop * 100;
end
