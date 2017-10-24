%  Join m start of n edges eac at randomly chosen leaves
%  Stars are separated by paths of length k
%  Set k=0 to joint stars to stars directly.

function match = rand_stars(n,m,p)
   match = star(n);
   new=insert_tree(path(p),match,p);
      for k=2:m
      leaves=find_leaves(match);
      j=randi([1,length(leaves)]);
      match=insert_tree(match,new,j);
   end
return
