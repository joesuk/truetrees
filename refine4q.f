C This program defines the intervals on the boundary
C of D which will be matched to form a tree. 
C It is designed for welding maps that are Euclidean (reflect and rotate)
C input file: matchorig.dat pairwise matchings of intervals
C             j   im(j) 
C             Can input just half (eg those j with j<im(j).
C             np= number of intervals (even)
C input nsub= number of subintervals of each of the np intervals(even)
C       if nsub=0 then np equal intervals  (2\pi/np)
C       else nsub*np intervals, based on refining the original
C       matching. The degree of each vertex determines the    
C       size of the subintervals so as to match the power 
C       near the jth vertex and (j+1st) vertex.
C output: match.dat  (refined matchings)
C         tree.dat    intervals to be welded.
C         degree.dat   j, degree(image of zj)
C         degree0.dat  this is the degrees of the original vertices 
C                      (degree0.dat=degree.dat if nsub=1).
C each interval has an index, call it j
C im(j)=index of matching interval
C The jth interval has endpoints zj and z{j+1}; arg zj < arg z{j+1} 
C this differs from refine4 by using an approximate midpoint of
C  each interval based on the powers at the ends instead of the
C  harmonic measure midpoint. This spaces the points out better
C   at high degree vertices and degree 1 vertices.

      program refine4q
      implicit real(kind=16)(a-h,o-y),complex(kind=16)(z)
      character*55 filenm
      dimension z(200001),im(200000),imn(200000),ideg(200000)
   80 format(a55)
  999 format(2e40.32)
  997 format(2i10)
      write(*,*)' Name of file with matchings?'
      write(*,*)'  [matchorig.dat]'
      read(*,*)filenm
      write(*,*)filenm
      open(1,file=filenm,status='old')
      write(*,*)' Output files will be tree.dat and match.dat.'
      open(3,file='match.dat',status='unknown')
      open(4,file='tree.dat',status='unknown')
      open(8,file='degree.dat',status='unknown')
      open(9,file='degree0.dat',status='unknown')
      pi=4.q0*atan2(1.q0,1.q0)
C input k,m(k) where the k-th and m(k)-th intervals are identified.
      np=0
      do 981 jj=1,200000
         read(1,*,end=59)i1,i2
         np=max0(np,i1,i2)
         im(i1)=i2
         im(i2)=i1
  981 continue
   59 continue
      write(*,*)' number of initial intervals =',np
      write(*,*)'  '
      write(*,*)' Number of subintervals of each interval=?[10]'
      write(*,*)' The number must be even or one.'
C   can enter 0 for no subintervals.
      read(*,*)nsub
      write(*,*)nsub
      if(nsub.ne.(nsub/2)*2)then
         if(nsub.ne.1)then
            write(*,*)' number must be even, or 1'
            stop
         endif
      endif
      open(2,file='nsub.dat',status='unknown')
      write(2,*)nsub
      if(nsub.eq.1)nsub=0
C compute the degree of each vertex
      do 10 j=1,np
          ia=im(j)+1
          if(ia.gt.np)ia=1
          k=1
    5     if(ia.eq.j)goto 6
          ia=im(ia)+1
          if(ia.gt.np)ia=1
          k=k+1
          goto 5
    6     ideg(j)=k
   10 continue
      do 35 jj=1,np
         write(9,997)jj,ideg(jj)
   35 continue
      if(nsub.eq.0)then
         nint=np
         do 14 j=1,np
            imn(j)=im(j)
            t=float(j-1)*2.q0*pi/float(np)
            z(j)=exp(cmplx(0.q0,t,16))
   14    continue
         goto 13
      endif
      ksub=nsub/2
      if(nsub.eq.1)ksub=1
      nint=np*nsub
      write(*,*)' total number of intervals',nint
C compute the intervals.
      xksub=float(ksub)
      rat=pi/float(np)
      do 11 j=1,np
         jp=j+1
         if(jp.gt.np)jp=1
         xideg=float(ideg(j))
         xidegp=float(ideg(jp))
C first find the central point
         xcen=2.q0/((xideg/xidegp)+1.q0)
         do 12 ip=1,ksub
           j1=(j-1)*nsub+ip
           imn(j1)=im(j)*nsub-ip+1
           t=2.q0*(j-1)+xcen*(float(ip-1)/xksub)**(xideg/2.q0)
           z(j1)=exp(cmplx(0.q0,t*rat,16))
           j2=j*nsub-ip+1
           t=2.q0*j-(2.q0-xcen)*(float(ip)/xksub)**(xidegp/2.q0)
           z(j2)=exp(cmplx(0.q0,t*rat,16))
           imn(j2)=(im(j)-1)*nsub+ip
  12     continue
C         itmax=10
C         j0=(j-1)*nsub
C         z(j0)=exp(dcmplx(0.d0,(j-1)*rat))
C         do 12 ip=2,nsub
C           j1=(j-1)*nsub+ip
C           imn(j1)=im(j)*nsub-ip+1
C           xj0=dfloat(ip-1)/dfloat(nsub)
C           xj=xj0
C           do 21 jk=1,itmax
C              f1=xj**(2.d0/xideg)
C              f2=(1.d0-xj)**(2.d0/xidegp)
C              f=f1-f2+1.d0-2.d0*xj0
C                write(*,*)abs(f)
C              if(abs(f).lt.1.d-12)goto 22
C              fp=2.d0*(f1/(xj*xideg)+f2/((1.d0-xj)*xidegp))
C              xj=xj-f/fp
C   21      continue
C           write(*,*)' itmax exceeded'
C   22      continue
C           t=(j-1)+xj
C           z(j1)=exp(dcmplx(0.d0,t*rat))
C   12    continue
   11 continue
   13 continue
      do 3 jj=1,nint
         x=real(z(jj))
         y=imag(z(jj))
         write(4,999)x,y
    3 continue   
      do 4 jj=1,nint
         write(3,997)jj,imn(jj)  
    4 continue
C compute degrees of refined lamination
      do 20 j=1,nint
          ia=imn(j)+1
          if(ia.gt.nint)ia=1
          k=1
   25     if(ia.eq.j)goto 26
          ia=imn(ia)+1
          if(ia.gt.nint)ia=1
          k=k+1
          goto 25
   26     ideg(j)=k
   20 continue
      do 34 jj=1,nint
         write(8,997)jj,ideg(jj)
   34 continue
C find the leaves (well at least one side):
C      j=1
C      j2=1
C   30 if(ideg(j).eq.1)then
C         j1=j  
C         j=j+1
C         if(j.gt.nint)j=1
C   31    if(ideg(j).eq.2)then
C            j=j+1
C            if(j.gt.nint)j=1
C            go to 31
C         endif
C         j2=j
C         if(j2.lt.j1)j2=j2+nint
C         do 32 kk=j1,j2
C            kj=kk
C            if(kj.gt.nint)kj=kj-nint
C            x=dreal(z(kk))
C            y=dimag(z(kk))
C            write(8,999)x,y
C   32    continue
C         write(8,*)'    '
C      endif 
C      j=j+1
C      if(j2.lt.nint)goto 30
      stop
      end
