%  start with a two sided path of length n, and then add m edges to 
%  randomly selected leaves

function   match = rand_snake_2(n,m)
   match = two_sided(n);
   for k=1:m
       leaves=find_leaves(match);
       j=randi([1,length(leaves)]);
       match=insert_edge(match,leaves(j));
   end % for k
return 

