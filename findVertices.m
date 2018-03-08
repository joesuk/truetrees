%subfunction to find all locations of a certain vertex in the vertex
%list with repeated vertices returned by extermap.
function [index1,index2]=findVertices(v,vertices)
        count=0;index1=0;index2=0;
        for i=1:size(vertices,1)
            if vertices(i)==v && count==0
                index1=i; count=count+1;
            elseif vertices(i)==v
                index2=i;
            end
        end   
   end