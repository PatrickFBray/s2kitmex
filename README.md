# Electrical Impedance Tomography

## Dependancies

Currently, the sole dependancy is [FFTW](http://www.fftw.org). Installation
instructions are available on their website, but we provide a walkthrough here
for people inexperienced with installing software from source who want to use 
`s2kit` with MATLAB. Note that installing from source may not be the best option.
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
Instructions for windows provided by [Dr. Peter Muller](https://sites.google.com/site/petermullermath/)
Please refer to the [installation instructions provided by the developers of 
FFTW](http://www.fftw.org/install/windows.html).

To run Linux commands on Windows 10 (this is needed to follow s2kit10's
intructions):
1. Open Powershell and run as administrator
2. Enter the following and hit "Enter"

       Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

3. Go to the Microsoft Store and search for Ubuntu (or your preferred Linux 
system and install that

4. Launch Ubuntu and navigate to where you downloaded the fftw folder. (In 
Ubuntu, the `C:\` drive is can be access from `/mnt/c/`.)

You will need to install make and gcc with the following two commands

    sudo apt install make
    sudo apt-get install gcc

For the Makefile in S2kit10:
The FFTWINC and FFTWLIB should both point to the dll folder

    CFLAGS = -O3 ${FFTWINC} -fPIC -m64
    LDFLAGS = -lm -lfftw3 -fPIC -m64

After s2kit10 and FFTW are installed, in Matlab, when you want to run code that
uses the mex files, you need to use the `addpath` command to include the
`s2kit10` subfolder and the `fftw-3.3.5-dll64` folder. After, the line 

    loadlibrary('libfftw3-3.dll','fftw3.h')

needs to be included.  Warning messages will pop up, but everything will run fine.

### \*nix instructions
Assuming you installed fftw in the default locations, if you are on linux, go 
into the makefile and set

    FFTWINC = -I/usr/local/include 
    FFTWLIB = -L/usr/local/lib -lfftw3 

and if you are on MACOS, set

    FFTWINC = -I/usr/local/include
    FFTWLIB = -L/usr/local/lib
    CFLAGS = -O3 ${FFTWINC}
    LDFLAGS = -lm -lfftw3

Once this is done, regardless of which unix operating system you are on, open a 
terminal in whatever directory you downloaded S2kit into and execute

    make all

There are two lines of code which need to be changed in order to get the mex to 
run properly. First, change `line 124` of `FST_semi_fly_mex.c` so that it reads:

    if (mxGetNumberOfDimensions(mxaData)!=2 || mxGetM(mxaData) != mxGetN(mxaData) || (mxGetM(mxaData)%2)!=0)

and change `line 160` of `InvFST_semi_fly_mex.c` so that it reads:

    if (mxGetNumberOfDimensions(mxaData)!=2 || mxGetM(mxaData) != mxGetN(mxaData) || (mxGetM(mxaData)%2)!=0)
