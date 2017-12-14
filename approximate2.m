

function  approximate2(pointer,num,ratio)
   n=size(pointer,1);
   p=pointer(1,2);
   for i=2:n
       point1 = pointer(pointer(i,1),2);
       point2 = pointer(i,2);
       zcents = point1+(1:num)*(point2-point1)/num;
       p=horzcat(p,zcents);    
   end

   p=horzcat(p,fliplr(p(1:size(p,2)-1)));
   P=polygon(p.');
   m=extermap(P);
   v=angle(get(m,'pre'))/pi;
   
   % fix v so that no negative values
   for i=1:size(v,1)
       if v(i)<=0 && i~=1
           v(i)=v(i)+2;
       end
       
   end
   disp(m);
   
   edgeHarmonicMeasures=zeros(size(v,1),1);
   for i=size(v,1):-1:1
       if i>1
           edgeHarmonicMeasures(i)=abs(v(i)-v(i-1));
       elseif (i==1) && (v(size(v,1))==2)
           edgeHarmonicMeasures(i)=abs(v(1));
       elseif (i==1) && (v(size(v,1))==0)
           edgeHarmonicMeasures(i)=abs(v(1)-v(size(v,1)));
       end       
   end
   
   disp(edgeHarmonicMeasures);
   
   
   w1 = flipud(vertex(P));
   beta = 1 - flipud(angle(P));
   [w1,beta] = scfix('de',w1,beta);
   P = polygon(flipud(w1),1-flipud(beta));
   
   
   % convert p to pointer
   newPointer = zeros(size(p,1),2);
   for i=1:size(p,1)
       newPointer(i,1)=p(i);
       if i>2
           newPointer(i,2)=i-1;
       else
           newPointer(i,1)=1;
       end
   end
   
   [match,starts,ends]=pointer2match(newPointer);
   smalls=zeros(size(match,1),1);
   
   for i=1:size(vertex(P),1)
       v1=0;v2=0;
       harmonicMsr1=0;
       harmonicMsr2=0;
       if i==n
           v1=P(n);
           v2=P(1);
           harmonicMsr1=edgeHarmonicMeasures(n);
           [index1,index2]=findVertices(v1,vertex(P));
           harmonicMsr2=edgeHarmonicMeasures(index2);
       else
           v1=P(i);
           v2=P(i+1);
           harmonicMsr1=edgeHarmonicMeasures(i);
           [index1,index2]=findVertices(v1,vertex(P));
           harmonicMsr2=edgeHarmonicMeasures(index2);
       end
       
       if v1~=v2
            [indexEdge1,indexEdge2]=findEdges(newPointer,v1,v2);
            if harmonicMsr1>ratio*harmonicMsr2
              smalls(match(c,2))=1;
            elseif harmonicMsr2>ratio*harmonicMsr1
              smalls(c)=1;
          end       
                  
       end
       
   end
       
       
   end
   
   disp(vertex(P));
   
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

   %subfunction to find edge indices in pointer corresponding to certain
   %vertices.
   function [indexEdge1,indexEdge2]=findEdges(pointer,v1,v2)
        for i=1:size(pointer,1)
            if i>1 && pointer(i,2)==v2 && pointer(i-1,2)==v1
               indexEdge1=i-1;
            elseif i==1 && pointer(i,2)==v2 && pointer(size(pointer,1),2)==v1
                indexEdge1=size(pointer,1);
            end
        end
        
        for i=1:size(pointer,1)
            if i>1 && pointer(i,2)==v2 && pointer(i-1,2)==v1
                indexEdge2=i-1;
            elseif i==1 && pointer(i,2)==v2 && pointer(size(pointer,1),2)==v1
                indexEdge2=size(pointer,1);
            end
        end
        
   end
   
   %subfunction to find vertex corresponding to edge harmonic measure
   function [index1,index2]=findVertices(v,vertices)
        count=0;
        for i=1:size(vertices,1)
            if vertices(i)==v && count==0
                index1=i;
            elseif vertices(i)==v
                index2=i;
            end
        end   
   end








