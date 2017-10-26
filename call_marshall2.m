
%  Given a tree in match format, call Don Marshall's program 
%  to compute the corresonding true tree. The output is a list
%  of complex numbers. Plotting this list, in order, will draw
%  the tree.

function tree_verts = call_marshall(list)

   % create data file, delete previously stored date 
   fileID = fopen('treedata','w+');
   L = length(list);
   fprintf(fileID,'%4d   %4d  \n',list');
   fclose(fileID);

  % run Marshall's program on the data
   PATH = getenv('PATH');
setenv('PATH', [PATH ':~/Documents/Marshall']);
    unix('echo $PATH');
   unix('executable < refine4q.input');
   unix('executable2 < ziptree4q.input');

   % open file created by Marshall's prgram and read data
   tree_verts=textread('tree.img');

   % plot tree 

   %plot_tree(tree_verts,3,30);



return 

