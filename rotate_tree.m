
% rotate list of points in plane

function verts=rotate_tree(tree_verts,theta);

   L=size(tree_verts,1);
   for k=1:L
      x=tree_verts(k,1);
      y=tree_verts(k,2);
      verts(k,1) =  cos(theta)*x + sin(theta)*y;
      verts(k,2) =  - sin(theta)*x + cos(theta)*y;
   end % for k

return
