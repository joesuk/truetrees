%  find leaves in a tree given in matching format
%  output is a list of sides; the leaves are the terminal
%  vertices of these sides.

function leaves = find_leaves(list)
  
   L=size(list,1);
   leaves = find(list(:,1)+1==list(:,2));
   if list(L,2)==1
      leaves=[leaves;L];
   end % if

return 
