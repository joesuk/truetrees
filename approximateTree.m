function approximateTree(pointer,num,numBranches,ratio)
   start=pointer(1,2); % should be the root of the tree
   n=size(pointer,1);
   p=pointer(1,2);
   numAdded=0;
   for i=2:n
       
       if pointer(i-1,1)==pointer(i,1) & i~=2
           point1=pointer(i-1,2);
           point2=pointer(pointer(i-1,1),2);
           zcents = point1+(1:num)*(point2-point1)/num;
           p=horzcat(p,zcents);   
           numAdded=numAdded+1;
       end
       
       point1 = pointer(pointer(i,1),2);
       point2 = pointer(i,2);
       
       zcents = point1+(1:num)*(point2-point1)/num;
       p=horzcat(p,zcents);    
   end
   newVertices=p.';

   p=horzcat(p,fliplr(p(1:size(p,2)-1)));
   p=p.';
   disp(newVertices);
   P=polygon(p);
   
   [vertices,edgeHarmonicMeasures]=findHarmonicMeasureTree(P);
           
   [match,largeMeasures,ratios]=getLargeMeasuresTree(pointer,numAdded,num,ratio,start,newVertices,vertices,edgeHarmonicMeasures);

   % make the new tree with auxiliary edges in matching format.
   
   newMatch = match;
   counter = 0;
  
  for i=1:size(largeMeasures,1)
    if largeMeasures(i)>0
        
        %disp('imbalance detected');
        %{
        numBranchestoAdd = round(abs(log(ratios(i)))*numBranches/4);

        for j=1:numBranchestoAdd
            newMatch=insert_edge(newMatch,i+counter);            
        end 
        %}

        for j=1:numBranches
            newMatch=insert_edge(newMatch,i+counter);            
        end 
        
        
                
        %newMatch=insert_tree(newMatch,path(numBranches),i+counter);
        
        
         counter = counter+2*numBranches; % change indexing to fit newly inserted edges.
        
        %counter = counter+2*numBranchestoAdd; % change indexing to fit newly inserted edges.
    end 
  end
  
  tree_verts=call_marshall2(newMatch);
  theta=  -25 * pi/180;
  verts=rotate_tree(tree_verts,theta);
  plot_tree(verts,3,30);
  
  newTree = zeros(size(verts,1)/10,1);
  jj=1;
  for ii=1:10:size(verts,1)
      newTree(jj)=verts(ii,1)+1i*verts(ii,2);
      jj=jj+1;
  end
   
  
  %disp(newTree);
  
  %{
  Q=polygon(newTree.');
  [newTreeVertices,newTreeEdgeHarmonicMeasures]=findHarmonicMeasure(P); % this doesnt apply to P since P is high degree!!!!
  %}
  
  % NEED TO CREATE FUNCTION TO FIND HARMONIC MEASURE VALUES OF OPPOSITE
  % SIDES FOR HIGH DEGREE TREES TO DO THE REST OF THIS COMPUTATION!!!
  %{
  
  listVertices = newTree.'; % new analogue of newVertices (see above)
  newPointer=zeros(size(listVertices,1),1);
   for i=1:size(listVertices,1)
       if i==1 || i==2
           newPointer(i)=1;
       else
           newPointer(i)=i-1;
       end
   end
   newPointer = horzcat(newPointer,listVertices);

   
   % array of half edges with value 1 if harmonic measure at half-edge is 
   % too large compared to harmonic measure of opposite half-edge.
   [match,starts,ends]=pointer2match(newPointer);
   
   ratios=zeros(size(match,1),1); % harmonic measure ratios
   
   alreadyAdded=zeros(size(match,1),1); % already added to ratios list

   
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
            
            if alreadyAdded(indexEdge1)==0 & alreadyAdded(indexEdge2)==0
                ratios(indexEdge1)=harmonicMsr1/harmonicMsr2;
                ratios(indexEdge2)=harmonicMsr2/harmonicMsr1;
            end
            
            alreadyAdded(indexEdge1)=1;
            alreadyAdded(indexEdge2)=1;
                  
       end
       
   end
   
   disp('L2 norm of ratios of new tree');
   disp(norm(log(ratios)));
   

  %}
  
  
  %{
  fid1 = fopen('verts.txt','w');
  for ii=1:size(verts,1)
    fprintf(fid1,'%f\t',verts(ii,:));
    fprintf(fid1,'\n');
  end
    %}   
   
   
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









