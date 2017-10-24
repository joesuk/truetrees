% subdivide each edge of a straight line planar tree into equal segments
% both input and output are rooted trees in pointer format

function new_pointer = subdivide(pointer,n)
    L = size(pointer,1)
       new_pointer=pointer(1,:);
    for k=2:L
        p=pointer(k,1);
        a=pointer(p,2);
        b=pointer(k,2);
        q=(p-1)*n+1;
        m=(k-1)*n+1;
        j=1;
            new_pointer(m+j-n,1)= q+j-1;
            new_pointer(m+j-n,2)=a*((n-j)/n) + b*(j/n);
        for j=2:n
            new_pointer(m+j-n,1)= m+j-n-1;
            new_pointer(m+j-n,2)=a*((n-j)/n) + b*(j/n);
        end % for j
    end % for k
return;