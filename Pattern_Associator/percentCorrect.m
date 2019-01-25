% 
%
function [ percent ] = percentCorrect(output, target, numPats)
count = 0;
for i = 1:numPats
    if isequal(target(:,i), output(:,i))
        count = count + 1;
    end
end
percent = (count/numPats)*100;
end

