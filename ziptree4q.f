C The unit circle is partitioned into n intervals 
C which are matched in pairs to form a tree.
C each interval has an index, call it j
C in(j)=index of next interval
C ip(j)=index of previous interval
C im(j)=index of matching interval
C if(j)=index of front or leading endpoint of the interval
C IMPORTANT: intervals are described counterclockwise
C Since D^c is mapped to H, the "front" edge of an interval
C  on R is on the left, and the "back" edge is on the right.
C ib(j)=index of back or trailing endpoint of the interval
C     Note: in and ip change, im,if,ib are fixed.
C z(k)=kth data point (endpoints of intervals)
C ns(k)=number of slits in \H at z(k) (initially 0).
C We assume initial values of 
C in(j)=j+1, ip(j)=j-1, if(j)=j+1, ib(j)=j (mod n) 
C
C input: match.dat   file with matchings (can be just half)
C        tree.dat   file with endpoints of intervals
C        (input name)    file of points in D^c 
C         nblocks.dat number of curves in file of points in D^c
C              (so can write output in blocks for graphing)
C output: tree.img   image of tree 
C        (input name)  image of points in D^c
C         quadcoeff.dat  -2C where C is the coefficient of 1/z
C   see refine2.f to refine large intervals: refine4.f if intervals =.
c
C this version uses the zipper algorithm and normalizes so that
C  f=z+C/z... near infinity. The constant -2C is outputted in
C   the file quadcoeff.dat
      program ziptree4q
      implicit real(kind=16)(a-h,o-y),complex(kind=16)(z)
      character*55 filenm
      dimension z(200001),zw(700000),in(200000),ip(200000),
     1im(200000),if(200000),ib(200000),ns(200000)
      call cpu_time(starttime)
      zi=cmplx(0.q0,1.q0,16)
      zzero=cmplx(0.q0,0.q0,16)
      zone=cmplx(1.q0,0.q0,16)
      zinf0=cmplx(1.q+100,0.q0,16)
C input k,m(k) and set m(m(k))=k
      open(1,file='match.dat',status='old')
      nm=0
      do 981 jj=1,200000
         read(1,*,end=59)i1,i2
         nm=max0(nm,i1,i2)
         im(i1)=i2
         im(i2)=i1
  981 continue
   59 continue
C test non-crossing:
      do 41 j=1,nm-1
         if(im(im(j)).ne.j)then
            write(*,*)' intervals not paired'
            write(*,*)j,im(j)
            write(*,*)im(j),im(im(j))
            stop
         endif
         if(im(j).lt.j)goto 41
         if(im(j).lt.j+1)then
             write(*,*)'interval and match are the same',j,im(j)
             stop
         endif
         do 42 i=j+1,im(j)-1
            if(im(i).lt.i)goto 42
            if(im(i).ge.im(j))then
               write(*,*)' matching has a crossing'
               write(*,*)j,im(j)
               write(*,*)i,im(i)
               stop
            endif
   42    continue 
   41 continue
      write(*,*)' number of matches =',nm
C input list of endpoints of intervals.
      open(2,file='tree.dat',status='old')
      do 982 jj=1,200000
         read(2,*,end=58)x,y
         z(jj)=dcmplx(x,y)
  982 continue
   58 np=jj-1
C In case input has same first and last point on the circle:
      if(abs(z(1)-z(np)).lt.1.d-12)then
         np=np-1
      endif
      if(nm.gt.np)then
         write(*,*)' not enough intervals for matchings'
         stop
      elseif(nm.lt.np)then
         write(*,*)' not enough matchings for intervals'
         stop
      endif
      write(*,*)' Enter 1 to include evaluation at interior points'
      write(*,*)' Else enter 0.'
      read(*,*)interior
      if(interior.eq.0)then
         nj=0
         goto 57 
      endif
      write(*,*)' Name of file with points in D^c [arcsout.dat]?'
      read(*,*)filenm
      open(8,file=filenm,status='old')
      write(*,*)' Name of file for image points [arcsout.img]?'
      read(*,*)filenm
      open(9,file=filenm,status='unknown')
      do 56 j=1,700000
          read(8,*,end=55)x,y
          zw(j)=cmplx(x,y,16)
   56 continue 
      write(*,*)' too many points. Increase dimension and recompile.'
      stop
   55 nj=j-1
   57 continue
C  xinf is used to compute coeff at infinity so it should be
C  at most the 4th root of 10^number of digits of accuracy
C This is further reduced because of the loss of accuracy due 
C to accumulated roundoff error.
      xinf=1.q+6
      nj=nj+1
      zw(nj)=cmplx(xinf,0.q0,16)
      nj=nj+1
      zw(nj)=cmplx(-xinf,0.q0,16)
      nj=nj+1
      zw(nj)=cmplx(0.q0,xinf,16)
      nj=nj+1
      zw(nj)=cmplx(0.q0,-xinf,16)
      write(*,*)' number of endpoints =',np
C initialize the pointers
      do 1 j=1,np
         in(j)=j+1
         ip(j)=j-1
         if(j)=j+1
         ib(j)=j
         ns(j)=0
    1 continue
      in(np)=1
      ip(1)=np
      if(np)=1
      xt=(imag(log(z(1)))+imag(log(z(np))))/2.q0
      zp=exp(cmplx(0.q0,xt,16))
      do 22 kk=1,np
          zz=zi*(z(kk)+zp)/(z(kk)-zp)
          z(kk)=cmplx(real(zz),0.q0,16)
   22 continue
      do 66 jjj=1,nj
         zz1=zw(jjj)
         zw(jjj)=zi*(zz1+zp)/(zz1-zp)
         if(imag(zw(jjj)).lt.1.q-30)then
            zw(jjj)=cmplx(real(zw(jjj)),0.q0,16)
         endif
   66 continue
      npp=np+1
C  image of infinity:
      z(npp)=zi
      j=1
    2 continue
      if(in(j).eq.ip(j))then
         goto 3
      elseif(im(j).ne.in(j))then
         j=in(j)
         goto 2
      endif
      zxc=cmplx(real(z(ib(j))),0.q0,16)
      zxb=cmplx(real(z(if(j))),0.q0,16)
      zxa=cmplx(real(z(if(in(j)))),0.q0,16)
C compute angle alpha for slit map so that slits in H remain
C evenly spaced
      xns1=float(ns(ib(j)))
      xns2=float(ns(if(im(j))))
      alpha=(xns1+1.q0)/(xns2+xns1+2.q0)
      zalpha=cmplx(alpha,0.q0,16)
C compute coeff of LFT to map a,b,c to alpha-1,0,alpha
      zxn=cmplx(alpha*(1.q0-alpha)*(real(zxc-zxa)),0.q0,16)
      zxd1=(zxb-zxa)*(zxc-zxb)
      zxd2=zxc-zxb+zalpha*(zxa-zxc)
      do 61 kk=1,npp
          zz=z(kk)-zxb
C apply LFT
          zz1=zxn*zz/(zxd1+zxd2*zz)
          if(isnan(abs(zz1)))zz1=zinf0
C careful of round off error:
          if(imag(zz1).lt.1.q-30)zz1=cmplx(real(zz1),0.q0,16)
C apply slit map
          zz2=zz1-zalpha
C careful of points mapping to 0 since 0^a not defined
          if(abs(zz2).lt.1.q-30)then
             z(kk)=zzero
             goto 61
          endif
          if(abs(zz2+1.d0).lt.1.q-30)then
             z(kk)=zzero
             goto 61
          endif
          zz3=(zone+zone/zz2)**alpha
C careful of branch cut along neg reals (zz3 should be in lower HP)
          if(imag(zz3).gt.1.q-60)zz3=conjg(zz3)
          zz4=(zz2+zone)/zz3
          z(kk)=zz4
   61 continue
C map interior points in UHP
      do 60 jjj=1,nj
         zz=zw(jjj)-zxb
         zz1=zxn*zz/(zxd1+zxd2*zz)
         if(imag(zz1).lt.1.q-30)zz1=cmplx(real(zz1),0.q0,16)
         zz2=zz1-zalpha
          if(abs(zz2).lt.1.q-30)then
             zw(jjj)=zzero
             goto 60
          endif
          if(abs(zz2+1.d0).lt.1.q-30)then
             zw(jjj)=zzero
             goto 60
          endif
         zz3=(zone+zone/zz2)**alpha
         if(imag(zz3).gt.1.q-60)zz3=conjg(zz3)
         zz4=(zz2+zone)/zz3
         zw(jjj)=zz4
   60 continue
C update pointers
C don't worry about degree of vertices in H
      ns(ib(in(im(j))))=ns(if(im(j)))+ns(ib(j))+1
      ns(if(ip(j)))=ns(ib(in(im(j))))
      in(ip(j))=in(in(j))
      ip(in(in(j)))=ip(j)
      j=ip(j)
      goto 2
    3 continue
C weld last two intervals using LFT and z^2.
C then arrange infty to be mapped to infty
C then scale to be in disk centered at 0
      zxa=cmplx(real(z(ib(j))),0.q0,16)
      zxc=cmplx(real(z(if(j))),0.q0,16)
      zinf1=z(npp)-zxc
      zinf2=zinf1/(zone-zinf1/(zxa-zxc))
      zinf=zinf2*zinf2
      do 64 kk=1,np
          zz=z(kk)-zxc
          zd=zone-zz/(zxa-zxc)
          if(abs(zd).lt.1.q-30)then
             z(kk)=zzero
          else
             zz1=zz/zd
             zz1=zz1*zz1
             z(kk)=zone/(zz1-zinf)
          endif
   64 continue
      z(if(j))=-zone/zinf
      z(ib(j))=zzero
C      distm=0.q0
C      do 70 jj=1,np
C          dist=abs(z(jj))
C          if(dist.gt.distm)distm=dist
C   70 continue
C      do 71 jj=1,np
C         z(jj)=z(jj)/distm
C   71 continue
      do 67 jjj=1,nj
          zz=zw(jjj)-zxc
          zd=zone-zz/(zxa-zxc)
          if(abs(zd).lt.1.q-30)then
             zw(jjj)=zzero
          else
             zz1=zz/zd
             zz1=zz1*zz1
             zw(jjj)=zone/(zz1-zinf)
          endif
C          zw(jjj)=1.q0/((zz1-zinf)*distm)
   67 continue
C  f=zaa*z +zbb+zcc/z+... near infinity. Find zaa and zbb:
      zbb=(zw(nj-3)+zw(nj-2)+zw(nj-1)+zw(nj))/4.q0
      zaa=(zw(nj-3)-zw(nj-2)+zw(nj-1)/zi-zw(nj)/zi)/(4.q0*xinf)
      zcc=(zw(nj-3)-zw(nj-2)+zw(nj-1)*zi-zw(nj)*zi)*xinf/4.q0
      zshift=-2.q0*zcc/zaa
      open(7,file='quadcoeff.dat',status='unknown')
      write(7,99)real(zshift),imag(zshift)
      open(3,file='tree.img',status='unknown')
      do 69 j=1,np
         x=real((z(j)-zbb)/zaa)
         y=imag((z(j)-zbb)/zaa)
         write(3,99)x,y
   69 continue
      call cpu_time(stoptime)
      write(*,98)stoptime-starttime
   98 format(' cpu time for zipper approx. =',f9.2,' sec.')
      if(interior.eq.0)stop
      open(10,file='nblocks.dat',status='unknown')
      read(10,*)nblocks
      nj4=nj-4
      npts=nj4/nblocks
      if(nj4.gt.npts*nblocks)nblocks=nblocks+1
      do 68 nnj=1,nblocks
         js=npts*(nnj-1)
         do 65 jjj=1,npts
            jnn=js+jjj
            x=real((zw(jnn)-zbb)/zaa)
            y=imag((zw(jnn)-zbb)/zaa)
            write(9,99)x,y
   65    continue
      write(9,*)'   '
      write(9,*)'   '
   68 continue
   99 format(2e40.32)
      call cpu_time(stoptime)
      write(*,*)' cpu time=',stoptime-starttime,' sec.'
      stop
      end
