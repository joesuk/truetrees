function   pointer=dla(n)
   clear centers;
   clear lograd;
   tic;
   centers=[0,2];
   hullx=[0,2];hully=[0,0];
   pointer=[0,0];
   counter=2;
   attempts=2;
 %  centers=zeros(1,10^7);
   while counter < n 
      maxradius=max(abs(centers))+2;
      z=(maxradius+1)* exp(2 * pi * i * random('unif',0,1));
      step=min(abs(z-centers))-2;
      while((step>.05)&&(step<5000))
         z=z+ step * exp( 2 * pi * i * random('unif',0,1));
         step=min(abs(z-centers))-2;
      end % while
      if step < .06
          [m,index]=min(abs(z-centers));
          pointer=[pointer;index,z];
          attempts=attempts+1;
          counter=counter+1;
          centers(counter)=z;
          newhullx=[hullx,real(z)];
          newhully=[hully,imag(z)];
          K=convhull(newhullx,newhully);
          hullx=newhullx(K);
          hully=newhully(K);
          saveK(counter)=length(K);
          if max(K)==length(newhullx)
             hull(counter)=1;
          else 
             hull(counter)=0;
          end % if
          hull;          
      end % if 
      if mod(counter,100000)==0
         smooth=conv(saveK,ones(1,1000))/1000;
         smooth=smooth(1000:10:length(saveK-1000));
         plot(smooth);
      end 
  end % while 
  toc;
  plotcirc(centers,hull);
  figure; 
  smooth=conv(saveK,ones(1,1000))/1000;
  smooth=smooth(1000:10:length(saveK-1000));
  plot(smooth);
return
