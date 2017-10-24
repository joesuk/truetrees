% compute approximate harmonic measure of sides of a planar tree
% given in pointer format

function  measure = harmonic_msr(pointer,iter)
   radius = 1+max(abs(pointer(:,2)));
   [match,starts,ends]=pointer2match(pointer);
   counter =0;
   measure=zeros(size(match,1),1);
   while counter < iter
       z=radius * exp( 2 * pi * i *rand(1));
       [step,closest]=dist2tree_match(match,starts,ends,pointer,z);
       while (step > .01)&&(step < 10000)
          z=z+ step * exp( 2 * pi * i *rand(1));
          [step,closest]=dist2tree_match(match,starts,ends,pointer,z);
       end % while step
       if step < .01
          counter=counter+1;
          measure(closest)= measure(closest)+1;
       end % if step
   end % while counter

return;