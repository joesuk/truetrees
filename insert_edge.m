% insert edge into tree
% inputs:  list = tree in side matching format 
%           n  = insert at vertex following edge n

function newlist=insert_edge(list,n)

   S = size(list,1); % number of sides
   newlist = list + 2*(list > n);  % increase some side labels by 2 
   newlist =[newlist(1:n,:);[n+1,n+2;n+2,n+1];newlist(n+1:S,:)]; % insert edge

return 

