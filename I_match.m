
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
    verts=rotate_tree(tree_verts,theta);
    plot_tree(verts,3,30);


    
