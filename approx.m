% input is s arooted planar, straight  line graph in pointer format
%  subdived the tree and convert to match format
% approximate harmonic measure of eqch side 
% add edges to each vertex approximately proportional toharmonic 
% measure of two adjacent sides 
%  input is in pointer format, output in match format

function match = approx(pointer,n,iter)
    temp = subdivide(pointer,n);
    measure = harmonic_msr(temp,iter);
    [match,starts,ends]=pointer2match(temp);
    L=size(match,1);
    add(1)=measure(1)+measure(L);
    for k=2:L-1
        add(k)=measure(k-1)+measure(k);
    end % for k
    add = floor(add/min(add))
    for k=L-1:-1:1
        for j=1:add(k)
            match=insert_edge(match,k);
        end % for j
    end % for k

return;