%  Build a paht and add one edge to each path vertex on a 
%  randomlu selected side

function match = rand_sided(n)
 
pointer1=[0:n-1;0:n-1]';
y=(2*randi([0,1],n,1)-1)*i;
pointer2=[1:n;0:n-1]'+[zeros(n,1),y];
pointer=[pointer1;pointer2]
match=pointer2match(pointer);
return

