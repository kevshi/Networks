function[NewInfected] = Dec3(s1, s2, s3, Adj, q)

OldInfected = DecBased3(s1, s2, s3, Adj, q);
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