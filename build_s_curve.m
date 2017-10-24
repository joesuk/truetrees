%  buit a tree with a spine of length 2n and edges 
%  added on one side for 1,..n, and on the other side
%  for n+1, ..., 2n

function list = build_s_curve(n)

   list=[1:4*n;4*n:-1:1]'
   for k=4*n-1:-1:3*n
      list=insert_edge(list,k)
   end % for k
   for k=2*n-1:-1:n
      list=insert_edge(list,k)
   end % for k

return 

