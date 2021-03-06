function[MaxIndexOrder] = GreedyIndepCascade(Adj, p)

InfectedMatrix = zeros(length(Adj), length(Adj));
for i = 1:length(Adj)
    InfectedMatrix(i, :) = IndepCascade(i, Adj, p);
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

function[NewInfected] = IndepCascade(s1, Adj, p)

OldInfected = IndepCascade1(s1, Adj, p);
NewInfected = zeros(1, length(Adj));
    
while isequal(NewInfected, OldInfected) ~= 1  
    for i = 1:length(Adj)    
        if OldInfected(i) == 1
           CurrentInfected = IndepCascade1(i, Adj, p);
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

function[InfectedSet] = IndepCascade1(s1, Adj, p)
   
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
       
       if p > rand %applies decision based formula
          InfectedSet(i) = 1; %infects the node if requirements are met
       end
    end
end
 
end