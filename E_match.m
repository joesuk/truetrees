

   match=path(8);

   match=insert_tree(match,path(6),16);

   match=insert_tree(match,star2(2),15);
   match=insert_tree(match,star2(3),14);

   match=insert_tree(match, star2(15),13);
   match=insert_tree(match,star2(5),12);
   match=insert_tree(match, star2(15),11);

   match=insert_tree(match,star2(3),10);
   match=insert_tree(match,star2(2),9);

   match=insert_tree(match,path(6),8);


   match=insert_tree(match,path(3),4);









   call_marshall(match);
   return;
