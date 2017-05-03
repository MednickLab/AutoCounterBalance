function [balencedIncomplete,balencedComplete,numDiffsWithoutZero,numDiffsWithZero] = isFactorsBallenced(m1,m2,trts1,trts2)
    %does 1 pair with 2 as much as 1 pairs with 3, and 1 with 4 etc
    %find all posible pairings of trts1 and trts2
    sets = {trts1,trts2};
    [x,y]=ndgrid(sets{:});
    allPairings = [x(:) y(:)];
   
    %checkBallence
    sumOverlap = zeros(length(allPairings),1);
    for i=1:length(allPairings) %step over pairs and check for evenness
        temp1 = (m1==allPairings(i,1));
        temp2 = (m2==allPairings(i,2));
        overlap = (temp1 & temp2);
        sumOverlap(i) = sum(sum(overlap));
    end
    
    %make sure same number of all pairs that do actually occur
    numDiffsWithoutZero = length(unique(sumOverlap(sumOverlap~=0)))-1;
    balencedIncomplete = ~logical(numDiffsWithoutZero);
    
    %make sure same number of all pairs, and all pairs occur
    numDiffsWithZero = length(unique(sumOverlap))-1;
    balencedComplete = ~logical(numDiffsWithZero);
end