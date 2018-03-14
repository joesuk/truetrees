function  [vertices, edgeHarmonicMeasures]=findHarmonicMeasureTree(P)
% Function for finding harmonic measure values of edges of embedded planar
% tree given in polygon format.
%   INPUT:
%   P - tree as polygon.m data structure.
%   OUTPUTS:
%   P - polygon object corresponding to pointer.
%   vertices - ordered list of vertices of tree in counterclockwise
%   traversal around tree
%   edgeHarmonicMeasures - list of harmonic measure values of half edges
%   corresopnding to vertices (edgeHarmonicMeasures(i) is the harmonic
%   measure of directed edge joining i-1 to i mod the number of vertices).
   m=extermap(P);
   v=angle(get(m,'pre'))/pi;
   
   % fix v so that no negative values
   for i=1:size(v,1)
       if v(i)<=0 && i~=1
           v(i)=v(i)+2;
       end
       
   end
   

   
   edgeHarmonicMeasures=zeros(size(v,1),1);
   for i=1:size(v,1)
       if i>1
           edgeHarmonicMeasures(i)=abs(v(i)-v(i-1));
       elseif (i==1)
           if v(i)==2
               edgeHarmonicMeasures(i)=abs(v(size(v,1)));
           elseif v(size(v,1))==2
               edgeHarmonicMeasures(i)=abs(v(i));
           end
       end       
   end
   
   edgeHarmonicMeasures = flipud(edgeHarmonicMeasures);
   edgeHarmonicMeasures=circshift(edgeHarmonicMeasures,1);
    
   w1 = flipud(vertex(P));

   beta = 1 - flipud(angle(P));
   [w1,beta] = scfix('de',w1,beta);
   P = polygon(flipud(w1),1-flipud(beta));
      
   vertices=vertex(P); % list of vertices
    

end
