function[] = IndepCascad(s, Adj, p)
   
A = zeros(1, length(Adj)); 
A(s) = 1;

for i = 1:length(Adj)
	if Adj(i, s) == 1
    	A(i) = 1;
    end
end

InfectedSet = zeros(1, length(Adj));
InfectedSet(s) = 1;
count = zeros(1, length(Adj));
for i = 1:length(Adj)
    if A(i) == 1&i ~= s
        for j = 1:length(Adj)
            if A(j)*Adj(i, j) == 1            
                count(i) = count(i)+1;
            end
        end
        sumrow = 0;
        for k = 1:length(Adj)
            sumrow = sumrow+Adj(i, k);
        end
        if rand < p
            InfectedSet(i) = 1;
        end
    end
end

disp(InfectedSet)
Infected=sum(InfectedSet)
Uninfected=length(Adj)-sum(InfectedSet)

end




        
    
   