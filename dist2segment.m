% compute the one-sided distance from a complex point z
% to the segment withcomplex endpoints a and b. This comptues
% Eulcidean distance in the halfplane to the right of the ray 
% from a to b and returns a large value if z is in the other 
% half-plane

function  d = dist2segment(a,b,z)
  w=(z-a)/(b-a);
  A=abs(b-a);
  x=real(w);
  y=imag(w);
  if y > 0
      d=10000;
  elseif x < 0
      d=sqrt(x^2+y^2) * A;
  elseif  x > 1
      d=sqrt((x-1)^2+y^2) * A;
  else 
      d= abs(y) * A;
  end  % if y > 0
return 