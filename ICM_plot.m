
% plo the ICM lo
   thick =3;
   point=30;
   figure;
   hold on;
   axis equal;
   axis off;
   num= 10; % number of subintervals per tree edge

   list = verts_I
   L=size(list,1);
   plot(list(:,1),list(:,2),'k','LineWidth',thick);
   scatter(list(1:10:L,1),list(1:10:L,2),point, 'filled', 'r');

   L=size(verts_C,1);
   scale =1.2;
   x = 2; 
   y=-0
   list = scale*(verts_C+[x*ones(L,1),y*ones(L,1)]);  
   plot(list(:,1),list(:,2),'k','LineWidth',thick);
   scatter(list(1:10:L,1),list(1:10:L,2),point, 'filled', 'r');

   L=size(verts_M,1);
   scale =2;
   x = 3.5; 
   y=-0
   list = scale*(verts_M+[x*ones(L,1),y*ones(L,1)]);  
   plot(list(:,1),list(:,2),'k','LineWidth',thick);
   scatter(list(1:10:L,1),list(1:10:L,2),point, 'filled', 'r');



return;






    
