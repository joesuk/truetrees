%  take the output of Marshall's program and plot the tree.
%  The output includes all the vertices of the true tree,
%  plus a number (usually 10) points on each edge.

function  plot_tree2(list,thick,point)

   num= 10; % number of subintervals per tree edge
   L=length(list);
   figure;
   hold on;
   axis equal;
   axis off;
   plot(list(:,1),list(:,2),'k','LineWidth',thick);
   L=size(list,1);
   %scatter(list(1:num:L,1),list(1:num:L,2),point, 'filled', 'r');
return;
