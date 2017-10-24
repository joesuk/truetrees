%  given a rotoed planar tree in pointer format, draw the tree
% pointer form map is a n by 2 array where the first column
% gives the integer index of the parent vertex (0 in the case of 
% the root vertex) and the second column gives the location as a 
% complex number.

function  draw_pts(pointer)
   L = size(pointer,1);
   x = real(pointer(:,2));
   y = imag(pointer(:,2));
   hold on;
   axis equal;
   axis off;
   for k=2:L
     plot([x(k);x(pointer(k,1))],[y(k);y(pointer(k,1))],'b');
   end % for k
   scatter(x,y,'filled','r');
return;