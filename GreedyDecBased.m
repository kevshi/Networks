function[MaxIndexOrder] = GreedyDecBased(Adj, q)

InfectedMatrix = zeros(length(Adj), length(Adj));
for i = 1:length(Adj)
    InfectedMatrix(i, :) = Dec1(i, Adj, q);
end
MaxIndex = 0;
MaxOfOnes = 0;
InfectedSetOr = zeros(1, length(Adj));
MaxIndexSet = zeros(1, length(Adj));

MaxIndexOrder = [];
for i = 1:length(Adj)
    for j = 1:length(Adj)
        if MaxIndexSet(j) ~= 1
            NewInfectedSetOr = InfectedMatrix(j,:) | InfectedSetOr;
            NumberOfOnes = sum(NewInfectedSetOr);
            if NumberOfOnes > MaxOfOnes
               MaxOfOnes = NumberOfOnes;
               MaxIndex = j;
               FinalInfectedSetOr = NewInfectedSetOr;
            end
        end
    end
    
    InfectedSetOr = FinalInfectedSetOr;
    MaxIndexSet(MaxIndex) = 1;
    MaxIndexOrder = [MaxIndexOrder, MaxIndex];
    
    if sum(FinalInfectedSetOr) == length(Adj)
    break
    
    end

end
end

function[NewInfected] = Dec1(s1, Adj, q)

OldInfected = DecBased1(s1, Adj, q);
NewInfected = zeros(1, length(Adj));
    
while isequal(NewInfected, OldInfected) ~= 1  
    for i = 1:length(Adj)    
        if OldInfected(i) == 1
           CurrentInfected = DecBased1(i, Adj, q);
           NewInfected = NewInfected | CurrentInfected;
        end
    end
    
    if OldInfected == NewInfected
        break        
    else
        OldInfected = NewInfected;
        NewInfected = zeros(1, length(Adj));
    end

end
end

function[InfectedSet] = DecBased1(s1, Adj, q)
   
A = zeros(1, length(Adj)); 
A(s1) = 1;

for i = 1:length(Adj)
    
	if Adj(i, s1) == 1 
        A(i) = 1; %A is an index of the neighbors of infected nodes
    end
end

InfectedSet = zeros(1, length(Adj));
InfectedSet(s1) = 1;

InfectedBase = zeros(1, length(Adj));
InfectedBase(s1) = 1;

for i = 1:length(Adj)
    
    if A(i) == 1 & i ~= s1
       count = sum(InfectedBase & Adj(i, :));         
       Deg = sum(Adj(i, :)); %finds degree of neighbor of s
       
       if q < count / Deg %applies decision based formula
          InfectedSet(i) = 1; %infects the node if requirements are met
       end
    end
end
 
end