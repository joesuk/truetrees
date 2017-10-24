%   Input tree in matching format  
%   Inductively add edges at random to vertices of this path

function match = add_rand_edges(list,m)
   match=list;
   for k=1:m
       j=randi([1,length(match)]);
       match=insert_edge(match,j);
   end % for k
return

