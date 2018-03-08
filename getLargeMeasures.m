function  [match, largeMeasures,ratios]=getLargeMeasures(ratio,start,listVertices,vertices,edgeHarmonicMeasures)
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
   newPointer=zeros(size(listVertices,1),1);
   for i=1:size(listVertices,1)
       if i==1 || i==2
           newPointer(i)=1;
       else
           newPointer(i)=i-1;
       end
   end
   newPointer = horzcat(newPointer,listVertices);
   
   %disp(vertices);
   %disp(edgeHarmonicMeasures);
   %disp(newPointer);
   
   % array of half edges with value 1 if harmonic measure at half-edge is 
   % too large compared to harmonic measure of opposite half-edge.
   [match,starts,ends]=pointer2match(newPointer);
   largeMeasures=zeros(size(match,1),1); 
   ratios=zeros(size(match,1),1);
   
   %disp('matching format');
   %disp(match);
   
   % find location of starting vertex
   indexStart=0;
   for i=1:size(newPointer,1)
            if newPointer(i,2)==start
                indexStart=i;
            end
   end
   
   
   % change size to accomodate new vertices
   n=size(vertices,1);
   
   % determine which half-edge pairs have imbalanced harmonic measure
   % through the use of 
   for i=1:n
       v1=0;v2=0;
       harmonicMsr1=0;
       harmonicMsr2=0;
       if i==1
           v1=vertices(1);
           v2=vertices(n); 
           harmonicMsr1=edgeHarmonicMeasures(1);
           [index1,index2]=findVertices(v1,vertices);
           index=index1;
           if index1==1
               index=index2;
           end
           harmonicMsr2=edgeHarmonicMeasures(index+1);
       else
           v1=vertices(i);
           v2=vertices(i-1);
           
           harmonicMsr1=edgeHarmonicMeasures(i);
           [index1,index2]=findVertices(v1,vertices);
           index=index1;
           
           if (index1==i) 
               index=index2;
           end

           if (index1==0 || index2==0)
               index=i;
           end
           
           if (index+1>n)
               index=index-n;
           end
           
           harmonicMsr2=edgeHarmonicMeasures(index+1);
       end
       
       if v1~=v2 % this if should never be true?
            [indexEdge1,indexEdge2]=findEdges(indexStart,match,newPointer,v1,v2);
                        
            %{
            c1=indexEdge1-indexStart;
            c2=indexEdge2-indexStart;
            if c1<=0
                c1=c1+size(vertices,1);
            end
            if c2<=0
                c2=c2+size(vertices,1);
            end
            %}
                        
            if harmonicMsr1>ratio*harmonicMsr2
              largeMeasures(indexEdge1)=1;
              ratios(indexEdge1)=harmonicMsr1/harmonicMsr2;
            elseif harmonicMsr2>ratio*harmonicMsr1
              largeMeasures(indexEdge2)=1;
              ratios(indexEdge2)=harmonicMsr2/harmonicMsr1;
            end       
                  
       end
       
   end
   

end

   
   
   
