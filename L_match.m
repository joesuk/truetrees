% hand set pointer for an L shap




  pointer=[0,i;1,0;2,1];
  pointer=subdivide(pointer,20);
  [match,starts, ends]=pointer2match(pointer);
  a=[zeros(1,8),1,0,0,0,1,0,0,0,2,0,2];
  a=[a,10,flip(a)]
  L=size(match,1)
  for k=1:length(a)
     for j=1:a(length(a)-k+1)
       
        match=insert_edge(match,L/2-k);
     end % for j
  end % for k
  match
  call_marshall(match);

return;

  pointer=[0,i;1,0;2,1];
  pointer=subdivide(pointer,10);
  [match,starts, ends]=pointer2match(pointer)
  a=[0,0,0,0,0,0,1,0,1];
  a=[a,6,flip(a)];
  for k=1:length(a)
     for j=1:a(length(a)-k+1)
        match=insert_edge(match,20-k);
     end % for j
  end % for k
  match
  call_marshall(match);

return;


  pointer=[0,i;1,0;2,1];
  pointer=subdivide(pointer,5);
  [match,starts, ends]=pointer2match(pointer)
  a=[0,0,0,1,4,1,0,0,0];
  for k=1:length(a)
     for j=1:a(length(a)-k+1)
        match=insert_edge(match,20-k);
     end % for j
  end % for k
  match
  call_marshall(match);


