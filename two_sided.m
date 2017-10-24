%  Build a path of length n and add edges to both sides

function match = two_sided(n)
 
pointer1=[0:n-1;0:n-1]';
pointer2=[1:n;i:n-1+i]';
pointer3=[1:n;-i:n-1-i]';
pointer=[pointer1;pointer2;pointer3]
match=pointer2match(pointer);
return


