% Tree should have one leaf node or one leaf node and one root.

function  approximateLineTree(pointer,num,numBranches,ratio)
   start=pointer(1,2); % should be a leaf node/root.
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
   
   edgeHarmonicMeasures = flipud(edgeHarmonicMeasures);
   
   
   w1 = flipud(vertex(P));
   beta = 1 - flipud(angle(P));
   [w1,beta] = scfix('de',w1,beta);
   P = polygon(flipud(w1),1-flipud(beta));
   
   vertices=vertex(P); % list of vertices
   
   % convert p back to pointer (with new edges) to use pointer2match
   newPointer = zeros(size(vertices,2),2); % new pointer
   for i=1:size(vertices,1)
       newPointer(i,2)=vertices(i);
       if i>2
           newPointer(i,1)=i-1;
       else
           newPointer(i,1)=1;
       end
   end
   
   
   [match,starts,ends]=pointer2match(newPointer);
   largeMeasures=zeros(size(match,1),1); % array of half edges with value 1 if harmonic measure at half-edge is too large compared to harmonic measure
   % of opposite half-edge.
   
   
   % find location of starting vertex
   indexStart=0;
   for i=1:size(vertex(P),1)
            if vertices(i)==start
                indexStart=i;
            end
   end
   

   % determine which half-edge pairs have imbalanced harmonic measure
   % through the use of 
   for i=1:size(vertex(P),1)
       v1=0;v2=0;
       harmonicMsr1=0;
       harmonicMsr2=0;
       if i==size(vertex(P),1)
           v1=vertices(n);
           v2=vertices(1);
           harmonicMsr1=edgeHarmonicMeasures(n);
           [index1,index2]=findVertices(v1,vertices);
           index=index1;
           if index1==n
               index=index2;
           end
           harmonicMsr2=edgeHarmonicMeasures(index);
       else
           v1=vertices(i);
           % disp(i);
           harmonicMsr1=edgeHarmonicMeasures(i);
           [index1,index2]=findVertices(v1,vertices);
           index=index1;
           if (index1==i || index1==0)
               index=index2;
           end
           
           if index2==0
               index=index1
           end
           harmonicMsr2=edgeHarmonicMeasures(index);
       end
       
       if v1~=v2
            [indexEdge1,indexEdge2]=findEdges(newPointer,v1,v2);
            c1=indexEdge1-indexStart;
            c2=indexEdge2-indexStart;
            if c1<=0
                c1=c1+size(vertices,1);
            end
            if c2<=0
                c2=c2+size(vertices,1);
            end
                        
            if harmonicMsr1>ratio*harmonicMsr2
              largeMeasures(c1)=1;
            elseif harmonicMsr2>ratio*harmonicMsr1
              largeMeasures(c2)=1;
            end       
                  
       end
       
   end
       
   % make the new tree with auxiliary edges in matching format.
   
  newMatch = match;
  %buildTree = TRUE;
  counter = 0;
  
  for i=1:size(largeMeasures,1)
    if largeMeasures(i)>0
        for j=1:numBranches
            newMatch=insert_edge(newMatch,i+counter);
        end 
        counter = counter+2*numBranches; % change indexing to fit newly inserted edges.
    end 
  end
  
  tree_verts=call_marshall2(newMatch);
  theta=  -25 * pi/180;
  verts=rotate_tree(tree_verts,theta);
  plot_tree(verts,3,30);
  
       
   
   
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
        indexEdge1=0;indexEdge2=0;
        for i=1:size(pointer,1)
            if i>1 && pointer(i,2)==v2 && pointer(i-1,2)==v1
               indexEdge1=i-1;
            elseif i==1 && pointer(i,2)==v2 && pointer(size(pointer,1),2)==v1
                indexEdge1=size(pointer,1);
            end
        end
        
        for i=1:size(pointer,1)
            if i>1 && pointer(i,2)==v1 && pointer(i-1,2)==v2
                indexEdge2=i-1;
            elseif i==1 && pointer(i,2)==v1 && pointer(size(pointer,1),2)==v2
                indexEdge2=size(pointer,1);
            end
        end
        
   end
   
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








