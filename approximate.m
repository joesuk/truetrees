

function  approximate(pointer,iter1,iter2, ratio)
   num=10;
   m=4;
   counter=0;
   while counter<iter1
      [match,starts,ends]=pointer2match(pointer);
      measure=harmonic_msr(pointer,iter2);
      measure=measure/iter2;
      smalls=zeros(size(match,1),1);
      for c=1:size(match,1)/2
          newMatch = match;
          m1 = measure(c);
          %disp(match);
          m2 = measure(match(c,2));
          if m1>ratio*m2
              smalls(match(c,2))=1;
          elseif m2>ratio*m1
              smalls(c)=1;
          end              
      end
      
      search=1;
      offset=0;
      newMatch = match;
      for i=1:size(smalls,2);
          if smalls(c)>0
              newEdge=path(num);
              for k=2:num-2
                for j=1:m
                    newEdge=insert_edge(newEdge,num-k);
                end 
              end
              newMatch=insert_tree(newMatch,newEdge,c);
          end              
    end
    counter=counter+1;
    end
   
   call_marshall(newMatch);
   
  
end





