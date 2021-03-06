function[InfectedSet] = SISBased3(s1, s2, s3, Adj, bprob, dprob, group)

A = zeros(1, length(Adj)); 
A(s1) = 1;
A(s2) = 1;
A(s3) = 1;

for i = 1:length(Adj)
	if (Adj(i, s1) == 1 | Adj(i, s2) == 1 | Adj(i, s3) == 1)
    	A(i) = 1; %A is an index of the neighbors of infected nodes
    end
end

InfectedSet = zeros(1, length(Adj));
InfectedSet(s1) = 1;
InfectedSet(s2) = 1;
InfectedSet(s3) = 1;

InfectedBase = zeros(1, length(Adj)); 

condition = 1;
sumInfectedDprob = 0;
sumInfectedBase = 0;
j=1;

while condition == 1
    for i = 1:length(Adj)
        if A(i) == 1 & (i ~= s1 | i ~= s2 | i ~= s3)
            if bprob >= rand %applies SIS formula
               InfectedSet(i) = 1; %infects the node if requirements are met
            end     
        end
    end
 
    for i = 1:length(Adj)
        if A(i) == 1 & (i ~= s1 | i ~= s2 | i ~= s3)
            if dprob >= rand %applies SIS formula
               InfectedSet(i) = 0; %cures the node if requirements are met
            end     
        end
    end
    
    sumInfectedDprob = sumInfectedDprob + sum(InfectedSet);
    
    j = j + 1;
    if j == group
       sumInfectedDprob = sumInfectedDprob / j;
        
        if abs(sumInfectedDprob - sumInfectedBase) <= 0.1*sumInfectedBase
               break
        else 
            j = 1;
            sumInfectedBase = sumInfectedDprob;
        end
    end
end

end