% insert tree into tree
% inputs:  list1 = tree in side matching format 
%          list2 = tree in side matching format 
%           n  =  attach second tree to first tree; the  
%                 initial vertex of side 1 in tree 2 is identified
%                 with the terminal vertex of edge n in tree 1

function newlist=insert_tree(list1,list2,n)

   % count sides in each tree
   S1 = size(list1,1);
   S2 = size(list2,1);
   %  make room for tree 2
   newlist = list1 + S2*(list1 > n);  
   % insert tree 2 with new labels
   newlist =[newlist(1:n,:);n+list2;newlist(n+1:S1,:)];

return 

