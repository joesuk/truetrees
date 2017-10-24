
function plotcirc(z,hull)

    figure;
    hold on;
    axis equal;
    t=[0:.1:2.1*pi];
    rad=1;
    for k=1:length(z)
       x=real(z(k));
       y=imag(z(k));
       if hull(k)==0
          plot([x+rad*cos(t)],[y+rad*sin(t)],'k');
       else 
          plot([x+rad*cos(t)],[y+rad*sin(t)],'r');
       end % if
    end % for k

return;
