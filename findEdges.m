%subfunction to find edge indices in pointer corresponding to certain
%vertices.
   function [indexEdge1,indexEdge2]=findEdges(indexStart,match,pointer,v1,v2)
        indexEdge1=0;indexEdge2=0;
        for i=1:size(pointer,1)
            if pointer(i,2)==v1 && pointer(pointer(i,1),2)==v2
               indexEdge1=i;
            elseif pointer(i,2)==v2 && pointer(pointer(i,1),2)==v1
                indexEdge2=i;
            end
        end
        
        if indexEdge1~=0
            indexEdge2=match(indexEdge1,2);
        end
        
        if indexEdge2~=0
            indexEdge1=match(indexEdge2,2);
        end
        
        %{
        for i=1:size(pointer,1)
            if i>1 && pointer(i,2)==v2 && pointer(i-1,2)==v1 && indexEdge1~=i-1
                num=i+indexStart;
                if num>size(match,1)
                    num=num-size(match,1);
                end
                indexEdge2=match(num,2);
            elseif i==1 && pointer(i,2)==v2 && pointer(i+1,2)==v1 && indexEdge1~=match(i,2)
                indexEdge2=match(i,2)+size(pointer,1);
            end
            
            
        end
        %}
        
   end