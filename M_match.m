   n=20;
   match=path(n)
   size(match)
   for k=1:2
      match=insert_edge(match, 30);
   end % for k2
      match=insert_edge(match, 16);
      match=insert_edge(match, 14);
      match=insert_edge(match, 13);
      match=insert_edge(match, 13);
      match=insert_edge(match, 12);
      match=insert_edge(match, 12);
      match=insert_edge(match, 12);
   for k=1:10
      match=insert_edge(match, 11);
   end % for k2
   for k=1:10
      match=insert_edge(match, 9);
   end % for k2

      match=insert_edge(match, 8);
      match=insert_edge(match, 8);
      match=insert_edge(match, 8);
      match=insert_edge(match, 7);
      match=insert_edge(match, 7);
      match=insert_edge(match, 6);
      match=insert_edge(match, 4);


    tree_verts=call_marshall2(match);
    theta=   50 * pi/180;
    verts=rotate_tree(tree_verts,theta);
    plot_tree(verts,3,30);

