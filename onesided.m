%  Build a paht with edges all on one side

function match = onesided(n)
 
pointer1=[0:n-1;0:n-1]';
pointer2=[1:n;0:n-1]'+[0,i];
pointer=[pointer1;pointer2];
match=pointer2match(pointer);
return

