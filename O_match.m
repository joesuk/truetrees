

% letter O, not yet, looks like C 


   match = path(9);
   match=insert_tree(match, star2(10), 8);
   match=insert_tree(match, star2(15), 7);
   match=insert_tree(match, star2(25),6);
   match=insert_tree(match, star2(40),5);
   match=insert_tree(match, star2(40), 4);
   match=insert_tree(match, star2(25), 3);
   match=insert_tree(match, star2(15), 2);
   match=insert_tree(match, star2(10), 1);


   tree_verts=call_marshall(match);

return


   n=20;
   m=4;
   a=[1:n/2,n/2:-1:1]
   a=floor(a.^2)
   match=path(n);
   for k=2:n-2
        match=insert_tree(match,star2(a(k)),n-k);
   end 
   call_marshall(match);

return 

   n=40;
   m=4;
   a=[1:n/2,n/2:-1:1]
   match=path(n);
   for k=2:n-2
      for j=1:a(k)
        match=insert_edge(match,n-k);
      end 
   end 
   call_marshall(match);


