function[InfectedSet] = DecBased3(s1, s2, s3, Adj, q)
   
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
InfectedBase(s1) = 1;
InfectedBase(s2) = 1;
InfectedBase(s3) = 1;

for i = 1:length(Adj) 
    if A(i) == 1 & (i ~= s1 | i ~= s2 | i ~= s3)
       count = sum(InfectedBase & Adj(i, :));         
       Deg = sum(Adj(i, :)); %finds degree of neighbor of s
       if q < count / Deg %applies decision based formula
          InfectedSet(i) = 1; %infects the node if requirements are met
       end
    end
end
 
end