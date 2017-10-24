%  converts a  rooted, straight line, planar  tree
%  in pointer format to the same tree in matching format.

%  In pointer format, a rooted tree with n vertices is 
%  a list of n integers in the range 0,...,n-1.
%  The first entry denotes the root of the tree 
%  and contains a 0, indicating there is no parent.
%  For k > 1, the kth entry is a integer 0 < j < k
%  that gives the parent of vertex k. i.e., the unique 
%  adjacent vertex closer to the root.

%  In pointer format, a planar  rooted tree with n 
%  vertices is given by two n-long columns. The first column
%  a list of n integers in the range 0,...,n-1, giving 
%  the parent vertex as decribed above. The second column 
%  consists of complex numbers giving the location of the vertex.

%  In matching format, each edge of a planar tree is given 
%  two sides and the sides are number consequtively, starting 
%  at 1, from the root vertex and proceeding counterclockwise.
%  The data is held in two columns of length 2n, where each row 
%  gives a side number followed by the number of the oppsite side
%  Each edge is represented by two rows (each the reverse of the 
%  other), but this is redundant; only one row from each pair is 
%  needed. 


function [match,starts,ends]=pointer2match(pointer)

   % find number of vertices
   L=size(pointer);
   % start from 1-edge tree
   match = [1,2;2,1];
   % list terminal vertices (pointer list) for each side (match list)
   ends =[2;1];
   starts=[1;2];
   % add edges by induction
   for k=3:L
     % locate parent vertex
     n = pointer(k);
     % locations of new vertex and pointer vertex
     v=pointer(n,2);
     w=pointer(k,2);
     % find sides in match that point to v
     edges=find(ends==n);
     % find side that first clockwise from new side 
     max_arg=-10;
     for j=1:length(edges)
         z=pointer(starts(edges(j)),2);
         new_arg= imag(log((z-v)/(w-v)));
         if new_arg <0
            new_arg=new_arg+2*pi;
         end % if 
         if (new_arg > max_arg)
            max_arg=new_arg;
            side=edges(j);
         end % 
     end% for j
     % update verts
     ends=[ends(1:side);k;n;ends(side+1:length(ends))];
     starts=[starts(1:side);n;k;starts(side+1:length(starts))];
     % insert new edge 
     match=insert_edge(match,side);
   end % for k

return


