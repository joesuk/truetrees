function  [match, largeMeasures,ratios]=getLargeMeasuresTree(pointer,numAdded,num,ratio,start,listVertices,vertices,edgeHarmonicMeasures)
% Function for finding harmonic measure values of edges of embedded planar
% tree given in polygon format.
%   INPUT:
%   ratio - threshold ratio of harmonic measure values of opposite
%   half-edges
%   start - starting vertex in original pointer format input
%   listVertices - list of vertices starting from start
%   vertices - list of vertices corresponding to edgeHarmonicMeasures
%   edgeHarmonicMeasures - Harmonic measure values of half-edges
%   OUTPUTS:
%   P - polygon object corresponding to pointer.
%   match - 
%   largeMeasures - 
%   ratios - 
   
    % convert p back to pointer (with new edges) to use pointer2match
    %disp(listVertices);
    
   newPointer=zeros(size(listVertices,1),1);
   for i=1:size(listVertices,1)
       if i==1
           newPointer(i)=1;
       elseif ismember(listVertices(i),pointer(:,2))==1
           newPointer(i)=i-1;
       elseif mod(i,num)~=2
           newPointer(i)=i-1;
       else
           disp(i);
           if (i-2)/num+2<=size(pointer,1)
                newPointer(i)=(pointer((i-2)/num+2,1)-1)*num+1;
           else
                newPointer(i)=(pointer((i-2)/num+2-numAdded,1)-1)*num+1;
           end
       end
   end
   
   newPointer = horzcat(newPointer,listVertices);
   
   
   %disp(vertices);
   %disp(edgeHarmonicMeasures);
   disp(newPointer);
   
   % array of half edges with value 1 if harmonic measure at half-edge is 
   % too large compared to harmonic measure of opposite half-edge.
   [match,starts,ends]=pointer2match(newPointer);
   largeMeasures=zeros(size(match,1),1); 
   ratios=zeros(size(match,1),1);
   
   
   % find location of starting vertex
   indexStart=0;
   for i=1:size(newPointer,1)
            if newPointer(i,2)==start
                indexStart=i;
            end
   end
   
   
   % change size to accomodate new vertices
   n=size(vertices,1);
   
   disp(vertices);
   
   disp(edgeHarmonicMeasures);
   
   % determine which half-edge pairs have imbalanced harmonic measure
   % through the use of 
   for ii=1:size(match,1)
       edge1=match(ii,1);
       edge2=match(ii,2);
       vertex1=newPointer(starts(ii),2);
       vertex2=newPointer(ends(ii),2);
       harmonicMsr1=0; harmonicMsr2=0;
       %disp('this pair');
       %disp(vertex1);
       %disp(vertex2);
       
       for jj=1:size(vertices,1)
           if jj<size(vertices,1) & vertices(jj)==vertex1 & vertices(jj+1)==vertex2
               harmonicMsr1=edgeHarmonicMeasures(jj+1);
           elseif vertices(jj)==vertex1 & vertices(1)==vertex2
               harmonicMsr1=edgeHarmonicMeasures(1);
           end
       end
       
       for jj=1:size(vertices,1)
           if jj<size(vertices,1) & vertices(jj)==vertex2 & vertices(jj+1)==vertex1
               harmonicMsr2=edgeHarmonicMeasures(jj+1);
           elseif vertices(jj)==vertex2 & vertices(1)==vertex1
               harmonicMsr2=edgeHarmonicMeasures(1);
           end
       end
       
       [indexEdge1,indexEdge2]=findEdges(indexStart,match,newPointer,vertex1,vertex2);

       
       if harmonicMsr1>ratio*harmonicMsr2
            %disp('imbalance');
            %disp(vertex1);
            %disp(vertex2);
            largeMeasures(indexEdge1)=1;
            ratios(indexEdge1)=harmonicMsr1/harmonicMsr2;
       elseif harmonicMsr2>ratio*harmonicMsr1
            %disp('imbalance');
            %disp(vertex1);
            %disp(vertex2);
            largeMeasures(indexEdge2)=1;
            ratios(indexEdge2)=harmonicMsr2/harmonicMsr1;
       end       
      
   end


end

   
   
   
