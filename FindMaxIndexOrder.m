function[MaxIndexOrder] = FindMaxIndexOrder(Adj, q)

InfectedMatrix = zeros(length(Adj), length(Adj));
for i = 1:length(Adj)
    InfectedMatrix(i, :) = DecBased(i, Adj, q);
end

disp(InfectedMatrix)

MaxIndex = 0;
MaxOfOnes = 0;
InfectedSetOr = zeros(1, length(Adj));
MaxIndexSet = zeros(1, length(Adj));
MaxIndexOrder = [];

for i = 1:length(Adj)
    for j = 1:length(Adj)
        if(MaxIndexSet(j) ~= 1)
            NewInfectedSetOr = InfectedMatrix(j,:) | InfectedSetOr;
            NumberOfOnes = sum(NewInfectedSetOr);
            if NumberOfOnes > MaxOfOnes
               MaxOfOnes = NumberOfOnes;
               MaxIndex = j;
               FinalInfectedSetOr = NewInfectedSetOr;
            end
        end
    end

    disp(MaxIndex)
    disp(FinalInfectedSetOr)
    InfectedSetOr = FinalInfectedSetOr;
    MaxIndexSet(MaxIndex) = 1;
    MaxIndexOrder = [MaxIndexOrder, MaxIndex];
    
    if sum(FinalInfectedSetOr) == length(Adj)
       break
        
end



end
