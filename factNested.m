classdef factNested < handle
    properties
        trtNames
        trtNums
        numTrts
        allSeqs
        numUniqueSeq
        
        nestTrtNums
        nestTrtNames
        numSubInSeq
        
        reductionNum=0
        maxReduceTimes = 1000000
        cols
        n
        reducedSeq
        balancedSeqNames
        
        fact2BallenceWith
    end
    methods
        function obj = factNested(trtNames,n)
            obj.n = n;
            obj.trtNames = trtNames;
            obj.numTrts = length(trtNames);
            obj.trtNums = 1:obj.numTrts;
            obj.allSeqs = perms(obj.trtNums);
            obj.numUniqueSeq = size(obj.allSeqs,1);
                        
            %we now try to balance seqences of trts, not individual trts           
            obj.nestTrtNums = 1:obj.numUniqueSeq;
            
            %make some names for the sequences
            for i=1:obj.numUniqueSeq
                names = obj.trtNames(obj.allSeqs(i,:));
                obj.nestTrtNames{i} = [names{:}]; %make concatinated name
            end
        end
               
        function counterbalanceWith(obj,A)
            obj.numSubInSeq = ceil(obj.n/obj.numUniqueSeq);
            if obj.numSubInSeq < 1
                error('Cannot Counterbalance when num seq > n')
            end
            %create our pool of seqs to pair each A condition with
            seqPool = repmat(obj.nestTrtNames',obj.numSubInSeq,1);
            
            %if n < numUniqueSequences then we must exclude some sequences
            %here we just take a random selection of the sequences, if you
            %want to get more clever, and exclude certain sequences then
            %the code would go here...TODO
            seqPool = seqPool(randperm(length(seqPool),obj.n));
            
            seqPools = cell(1,A.numTrts);
            for i=1:A.numTrts
                seqPools{i}=seqPool;
            end
            
            %step though each value in A and pair with some seq
            for row=1:size(A.reducedSeq,1)
                for col=1:size(A.reducedSeq,2)
                    ATrt = A.reducedSeq(row,col);
                    numTrtsInPool = length(seqPools{ATrt});
                    randPick = randi(numTrtsInPool);
                    obj.reducedSeq{row,col} = seqPools{ATrt}{randPick};
                    seqPools{ATrt}(randPick) = []; %remove this trt from pool
                end
            end
        end
        
        function output = balancedOutput(obj)
            output = obj.reducedSeq;
        end
    end
end