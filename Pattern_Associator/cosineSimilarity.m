%
%
function [ similarity ] = cosineSimilarity(output, target, numPats)
similarity = zeros(numPats,1);
for i = 1:numPats
    cosTheta = dot(output(:,i),target(:,i))/(norm(output(:,i))*norm(target(:,i)));
    similarity(i) = cosTheta;
    %disp("Cosine similarity of pattern " + i + ":  " + (cosTheta*100) + "%");
end

end

