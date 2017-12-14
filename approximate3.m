

function  approximate3(pointer,num,ratio)
   n=size(pointer,1);
   p=pointer(1,2);
   for i=2:n
       point1 = pointer(pointer(i,1),2);
       point2 = pointer(i,2);
       deltax = (real(point2) - real(point1))/num;
       deltay = (imag(point2) - imag(point1))/num;
       halfdx = deltax/2;
       halfdy = deltay/2;
       xcents = real(point1) + halfdx + (0:num-1)*deltax;
       ycents = imag(point1) + halfdy + (0:num-1)*deltay;
       zcents = xcents+i*ycents;
       %disp(size(zcents));
       p=cat(2,p,pointer(i,2),zcents);
   end
   P=polygon(p');
   disp(vertex(P));
   m=extermap(P);
   v=angle(get(m,'pre'))/pi;
   disp(v);
   
   % fix v so that no negative values
   for i=1:size(v,1)
       if v(i)<=0 && i~=1
           v(i)=v(i)+2;
       end
       
   end
   
   w=zeros(size(v,1));
   for i=1:size(v,1)
       if i>1
           w(i)=abs(v(i)-v(i-1));
       elseif i==1
           w(i)=abs(v(1)-v(size(v,1)));
       end       
   end
   
   disp(w);
   
   % fix v so that you don't have negative values
   % use the code below to get the corrected list of vertices
   % gonna have to implement some more stuff to get
   % the right harmonic measure assigned to the right
   % half edge (remember the traversal always keeps
   % tree on left side so that I thionk we can use this to "know"
   % which half edge we are talking about during our assignment.
   
   %{
  w = flipud(vertex(poly));
  beta = 1 - flipud(angle(poly));
  [w,beta] = scfix('de',w,beta);
  poly = polygon(flipud(w),1-flipud(beta));
   %}
end






