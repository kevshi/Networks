% Title: Degree Centrality
% Description: Finds the degree centrality of each node in the Facebook data
% Authors: Chris Duncan, Kevin Shi, and Fernando Velazquez
% Date Modified: 7/24/13
% Status: Complete
function [a] = DegCen(Adj)
n = 1434;
T = [1:n];
r = sum(Adj);
q = max(r);
for x = 1:size(Adj)
	C(x) = sum(q - r(x),x);
end
for i = 2:numel(C) % numel is number of elements in an array
	numb = C(i);
	j = i-1;
	while j >= 1 && C(j) > numb
    	C(j+1) = C(j);
    	T(j+1) = T(j);
    	j = j-1;
	end
	C(j+1) = numb;
	T(j+1) = i;
end
disp(C)
disp(T)
end