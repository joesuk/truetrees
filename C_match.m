
% letter C 

   n=20;
   m=4;

   match=path(n);
   for k=2:n-2
      for j=1:m
        match=insert_edge(match,n-k);
      end 
   end 
   call_marshall(match);

   match=path(n);
   for k=4:n-4
        match=insert_tree(match,path(m),n-k);
   end 
    tree_verts=call_marshall2(match);
    theta=  -25 * pi/180;
    verts=rotate_tree(tree_verts,theta);
    plot_tree(verts,3,30);



