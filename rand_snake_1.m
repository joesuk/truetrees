%   Make a n-long path.  
%   Inductively add edges at random to vertices of this path

function match = rand_snake_1(n,m)
   match=[1:2*n;2*n:-1:1]';
   for k=1:m
       j=randi([1,length(match)]);
       match=insert_edge(match,j);
   end % for k
return
