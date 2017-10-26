#truetrees
This is a MATLAB library for working with plane trees and finding their conformally balanced tree approximations using harmonic measure calculations. 

To use the code, first locally compile the source Fortran files using GNU Fortran or a similar compiler:
```
gfortran -c refine4q.f ziptree4q.f
gfortran -o executable refine4q.o
gfortran -o executable2 ziptree4q.o
```
 and set the ``PATH`` variable via ``setenv`` in ``call_marshall.m`` and ``call_marshall2.m`` to the location of your local copy.
