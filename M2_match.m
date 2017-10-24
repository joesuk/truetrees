

   match=path(10);

   match=insert_tree(match,path(6),20);
   match=insert_edge(match,19);
   match=insert_edge(match,18);
   match=insert_tree(match, star2(12),17);
   match=insert_tree(match, star2(12),13);
   match=insert_edge(match,12);
   match=insert_edge(match,11);
   match=insert_tree(match,path(6),10);

   match=insert_tree(match,path(4),5);









   call_marshall(match);
   return;
