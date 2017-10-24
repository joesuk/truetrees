%  Make a star consisting of n edges meeting at a point
%  The root is a tip of the star

function match = star(n)
    match=[1,2;2,1];
    for k=2:n
        match = insert_edge(match,1);
    end % for k
return