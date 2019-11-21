# Electrical Impedance Tomography
This is a package authored by Peter J. Kostelec and Dan Rockmore of Dartmouth
University to compute the coefficient of spherical harmonic expansions of
arbitrary functions. It was originally available on Kostelec's website, but
his site is no longer available online. This repository is here to keep the 
package available.

## Dependancies

Currently, the sole dependancy is [FFTW](http://www.fftw.org). Installation
instructions are available on their website, but we provide a walkthrough here
for people inexperienced with installing software from source who want to use 
s2kit with MATLAB. Note that installing from source may not be the best option.
There are precompiled binaries available for many operating systems, and many 
linux distros offer fftw through their usual package management systems.

### Installing FFTW on \*nix systems
Essentially, all you need to do is download the source, open a terminal in the
directory where the source is located and run the following commands:

    ./configure --enable-shared
    make
    sudo make install

Configuring the library as shared is essential for it to integrate with MATLAB.
User on OS X should be sure to have developer tools installed.

### Installing FFTW on Windows systems
We don't really know... We have some precompiled dlls that we have managed to
get to work. 

### \*nix instructions
Assuming you installed fftw in the default locations, if you are on linux, go into the makefile and set 
    FFTWINC = -I/usr/local/include 
    FFTWLIB = -L/usr/local/lib -lfftw3 
and if you are on MACOS, set
    FFTWINC = -I/usr/local/include
    FFTWLIB = -L/usr/local/lib
    CFLAGS = -O3 ${FFTWINC}
    LDFLAGS = -lm -lfftw3

Once this is done, regardless of which unix operating system you are on, open a terminal in whatever directory you downloaded S2kit into and execute
    make all

There are two lines of code which need to be changed in order to get the mex to run properly. First, change line 124 of FST_semi_fly_mex.c so that 
it reads:

  if (mxGetNumberOfDimensions(mxaData)!=2 || mxGetM(mxaData) != mxGetN(mxaData) || (mxGetM(mxaData)%2)!=0)

and change line 160 of InvFST_semi_fly_mex.c so that it reads:

  if (mxGetNumberOfDimensions(mxaData)!=2 || mxGetM(mxaData) != mxGetN(mxaData) || (mxGetM(mxaData)%2)!=0)
