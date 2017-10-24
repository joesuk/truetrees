

% Letter I 

    m=7;
    match=path(m)
    n=8;
    for k=1:4
       match=insert_edge(match,2*m);
    end 
       match=insert_edge(match,7+2*m);
       match=insert_edge(match,7+2*m);
       match=insert_edge(match,1+2*m);
       match=insert_edge(match,1+2*m);


    for k=1:4
       match=insert_edge(match,m);
    end 
       match=insert_edge(match,7+m);
       match=insert_edge(match,7+m);
       match=insert_edge(match,1+m);
       match=insert_edge(match,1+m);

   

    tree_verts=call_marshall2(match)
    theta= 27.8 * pi/180;
    verts_I=rotate_tree(tree_verts,theta);



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
    verts_C=rotate_tree(tree_verts,theta);
    %plot_tree(verts,3,30);


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
    verts_M=rotate_tree(tree_verts,theta);
    %plot_tree(verts,3,30);

return; 


   figure;
   hold on;
   axis equal;
   axis off;
   num= 10; % number of subintervals per tree edge

   list = verts_I
   L=length(list,1);
   plot(list(:,1),list(:,2),'k','LineWidth',thick);
   scatter(list(1:10:L,1),list(1:10:L,2),point, 'filled', 'r');

   list = verts_C
   L=length(list,1);
   plot(list(:,1),list(:,2),'k','LineWidth',thick);
   scatter(list(1:10:L,1),list(1:10:L,2),point, 'filled', 'r');


   list = verts_M
   L=length(list,1);
   plot(list(:,1),list(:,2),'k','LineWidth',thick);
   scatter(list(1:10:L,1),list(1:10:L,2),point, 'filled', 'r');



return;






    
