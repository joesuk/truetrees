%  Build a dyadic tree with n levels 
%  Each vertex has degree 3, exect for 
%  3*2^(n-1) leaves of degree 1.

function list = build_dyadic_tree(n)

   list=[1,6;2,3;3,2;4,5;5,4;6,1];
   add=[1,2;2,1;3,4;4,3];
   for k=1:n-1
      leaves=find_leaves(list)
      L=length(leaves);
      for j=L:-1:1
         list= insert_tree(list,add,leaves(j))
         %list= insert_edge(list,leaves(j))
         %list= insert_edge(list,leaves(j))
      end % for j
   end % for k

return 
