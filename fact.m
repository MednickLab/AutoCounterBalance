classdef fact < handle
    properties
        trtNames
        trtNums
        numTrts
        allSeqs
        numAllSeqs
        reductionNum=0
        maxReduceTimes = 10000000
        n
        reducedSeq
        balancedSeqNames
        numUniqueSeq
    end
    methods
        function obj = fact(trtNames,n)
            obj.n = n;
            obj.trtNames = trtNames;
            obj.numTrts = length(trtNames);
            obj.trtNums = 1:obj.numTrts;
            obj.allSeqs = perms(obj.trtNums);
            obj.numUniqueSeq = size(obj.allSeqs,1);
            numReps = ceil(obj.n/size(obj.allSeqs,1));
            %repeat the perms if we dont have less unique seqs than n
            if numReps
               obj.allSeqs = repmat(obj.allSeqs,numReps,1); 
            end
            obj.numAllSeqs = size(obj.allSeqs,1);
            obj.reduceFactor();
        end
        
        function reduceFactor(obj)
            %this will both reduce to required length, and perform rand
            %shuffle on seq matrix
            obj.reductionNum = obj.reductionNum+1;         
            %this will be auctomatically balanced if n < numAllSeq
            randsort = randperm(obj.numAllSeqs,obj.n);
            %take a random selection of rows
            obj.reducedSeq=obj.allSeqs(randsort,:);
        end
        
        function counterbalanceWith(obj,A)
            numReductions=1;
            while 1        
                obj.reduceFactor(); %this will give a new reduced version, and we loop until we balance :)
                partiallyBallenced = areFactorsBallenced(A.reducedSeq,obj.reducedSeq,A.trtNums,obj.trtNums);
                if partiallyBallenced
                    break
                end
                numReductions=numReductions+1;
                if numReductions > obj.maxReduceTimes
                    error('Tried to reduce %i times. #Fail.',obj.maxReduceTimes);
                end
            end
            disp('balanced')
        end
        
        function output = balancedOutput(obj)
            output = cell(size(obj.reducedSeq));
            for i=1:obj.numTrts
                output(obj.reducedSeq==i)=obj.trtNames(i);
            end
        end
    end
end