
 
   n=4;
   match=[1,2;2,1];
   match=insert_tree(match, path(4),2);
   match=insert_tree(match, path(4),2);
   match=insert_tree(match, path(4),1);
   match=insert_tree(match, path(4),1);

   match=insert_edge(match,28);
   match=insert_edge(match,27);
   match=insert_edge(match,27);
   match=insert_tree(match,star2(3),26);
   match=insert_edge(match,25);
   match=insert_edge(match,25);
   match=insert_edge(match,24);

   match=insert_edge(match,11);
   match=insert_edge(match,10);
   match=insert_edge(match,10);
   match=insert_tree(match,star2(3),9);
   match=insert_edge(match,8);
   match=insert_edge(match,8);
   match=insert_edge(match,7);



   call_marshall(match)

   return;


