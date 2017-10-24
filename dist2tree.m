% compute distance from complex point z to planar tree given in 
% in pointer format (firt column give index of parent, second gives 
% location of vertex as a complex number

function [dist,closest]=dist2tree(pointer,z)
   [list,starts,ends]=pointer2match(pointer);
   L=size(list,1);
   dist=100000;
   for k=1:L
       a=pointer(starts(k),2);
       b=pointer(ends(k),2);
       edgedist=dist2segment(a,b,z);
       if edgedist < dist
           dist = edgedist;
           closest = k;
       end % if
   end % for k
return;