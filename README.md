this fork
=========

using with Orange Pi 2 GPIO

files changed:
-------------
1. src/jtag/drivers/sysfsgpio.c
2. tcl/interface/sysfsgpio-raspberrypi.cfg

how to build:
------------
```
$ ./my_configure.sh
$ make
$ sudo make install
```

how to change GPIO pins used for jtag/swd:
------------------------------------------
edit *tcl/interface/sysfsgpio-raspberrypi.cfg*

how to use:
-----------
this is a good article - *http://log2.ch/2014/stm32-and-jtag-via-raspberry/*

changes to call string in the article:
```
sudo openocd -f interface/sysfsgpio-raspberrypi.cfg -f target/stm32f1x.cfg
```

stm32flash from that article - *https://sourceforge.net/p/stm32flash/wiki/Home/*



Welcome to OpenOCD!
===================

OpenOCD provides on-chip programming and debugging support with a
layered architecture of JTAG interface and TAP support including:

- (X)SVF playback to faciliate automated boundary scan and FPGA/CPLD
  programming;
- debug target support (e.g. ARM, MIPS): single-stepping,
  breakpoints/watchpoints, gprof profiling, etc;
- flash chip drivers (e.g. CFI, NAND, internal flash);
- embedded TCL interpreter for easy scripting.

Several network interfaces are available for interacting with OpenOCD:
telnet, TCL, and GDB. The GDB server enables OpenOCD to function as a
"remote target" for source-level debugging of embedded systems using
the GNU GDB program (and the others who talk GDB protocol, e.g. IDA
Pro).

This README file contains an overview of the following topics:

- quickstart instructions,
- how to find and build more OpenOCD documentation,
- list of the supported hardware,
- the installation and build process,
- packaging tips.


============================
Quickstart for the impatient
============================

If you have a popular board then just start OpenOCD with its config,
e.g.:

  openocd -f board/stm32f4discovery.cfg

If you are connecting a particular adapter with some specific target,
you need to source both the jtag interface and the target configs,
e.g.:

  openocd -f interface/ftdi/jtagkey2.cfg -c "transport select jtag" \
          -f target/ti_calypso.cfg

  openocd -f interface/stlink-v2-1.cfg -c "transport select hla_swd" \
          -f target/stm32l0.cfg

NB: when using an FTDI-based adapter you should prefer configs in the
ftdi directory; the old configs for the ft2232 are deprecated.

After OpenOCD startup, connect GDB with

  (gdb) target extended-remote localhost:3333


=====================
OpenOCD Documentation
=====================

In addition to the in-tree documentation, the latest manuals may be
viewed online at the following URLs:

  OpenOCD User's Guide:
    http://openocd.org/doc/html/index.html

  OpenOCD Developer's Manual:
    http://openocd.org/doc/doxygen/html/index.html

These reflect the latest development versions, so the following section
introduces how to build the complete documentation from the package.

For more information, refer to these documents or contact the developers
by subscribing to the OpenOCD developer mailing list:

	openocd-devel@lists.sourceforge.net

Building the OpenOCD Documentation
----------------------------------

By default the OpenOCD build process prepares documentation in the
"Info format" and installs it the standard way, so that "info openocd"
can access it.

Additionally, the OpenOCD User's Guide can be produced in the
following different formats:

  # If PDFVIEWER is set, this creates and views the PDF User Guide.
  make pdf && ${PDFVIEWER} doc/openocd.pdf

  # If HTMLVIEWER is set, this creates and views the HTML User Guide.
  make html && ${HTMLVIEWER} doc/openocd.html/index.html

The OpenOCD Developer Manual contains information about the internal
architecture and other details about the code:

  # NB! make sure doxygen is installed, type doxygen --version
  make doxygen && ${HTMLVIEWER} doxygen/index.html


==================
Supported hardware
==================

JTAG adapters
-------------

AICE, ARM-JTAG-EW, ARM-USB-OCD, ARM-USB-TINY, AT91RM9200, axm0432,
BCM2835, Bus Blaster, Buspirate, Chameleon, CMSIS-DAP, Cortino, DENX,
Digilent JTAG-SMT2, DLC 5, DLP-USB1232H, embedded projects, eStick,
FlashLINK, FlossJTAG, Flyswatter, Flyswatter2, Gateworks, Hoegl, ICDI,
ICEBear, J-Link, JTAG VPI, JTAGkey, JTAGkey2, JTAG-lock-pick, KT-Link,
Lisa/L, LPC1768-Stick, MiniModule, NGX, NXHX, OOCDLink, Opendous,
OpenJTAG, Openmoko, OpenRD, OSBDM, Presto, Redbee, RLink, SheevaPlug
devkit, Stellaris evkits, ST-LINK (SWO tracing supported),
STM32-PerformanceStick, STR9-comStick, sysfsgpio, TUMPA, Turtelizer,
ULINK, USB-A9260, USB-Blaster, USB-JTAG, USBprog, VPACLink, VSLLink,
Wiggler, XDS100v2, Xverve.

Debug targets
-------------

ARM11, ARM7, ARM9, AVR32, Cortex-A, Cortex-R, Cortex-M,
Feroceon/Dragonite, DSP563xx, DSP5680xx, FA526, MIPS EJTAG, NDS32,
XScale, Intel Quark.

Flash drivers
-------------

ADUC702x, AT91SAM, AVR, CFI, DSP5680xx, EFM32, EM357, FM3, FM4, Kinetis,
LPC8xx/LPC1xxx/LPC2xxx/LPC541xx, LPC2900, LPCSPIFI, Marvell QSPI,
Milandr, NIIET, NuMicro, PIC32mx, PSoC4, SiM3x, Stellaris, STM32, STMSMI,
STR7x, STR9x, nRF51; NAND controllers of AT91SAM9, LPC3180, LPC32xx,
i.MX31, MXC, NUC910, Orion/Kirkwood, S3C24xx, S3C6400, XMC1xxx, XMC4xxx.


==================
Installing OpenOCD
==================

A Note to OpenOCD Users
-----------------------

If you would rather be working "with" OpenOCD rather than "on" it, your
operating system or JTAG interface supplier may provide binaries for
you in a convenient-enough package.

Such packages may be more stable than git mainline, where
bleeding-edge development takes place. These "Packagers" produce
binary releases of OpenOCD after the developers produces new "release"
versions of the source code. Previous versions of OpenOCD cannot be
used to diagnose problems with the current release, so users are
encouraged to keep in contact with their distribution package
maintainers or interface vendors to ensure suitable upgrades appear
regularly.

Users of these binary versions of OpenOCD must contact their Packager to
ask for support or newer versions of the binaries; the OpenOCD
developers do not support packages directly.

A Note to OpenOCD Packagers
---------------------------

You are a PACKAGER of OpenOCD if you:

- Sell dongles and include pre-built binaries;
- Supply tools or IDEs (a development solution integrating OpenOCD);
- Build packages (e.g. RPM or DEB files for a GNU/Linux distribution).

As a PACKAGER, you will experience first reports of most issues.
When you fix those problems for your users, your solution may help
prevent hundreds (if not thousands) of other questions from other users.

If something does not work for you, please work to inform the OpenOCD
developers know how to improve the system or documentation to avoid
future problems, and follow-up to help us ensure the issue will be fully
resolved in our future releases.

That said, the OpenOCD developers would also like you to follow a few
suggestions:

- Send patches, including config files, upstream, participate in the
  discussions;
- Enable all the options OpenOCD supports, even those unrelated to your
  particular hardware;
- Use "ftdi" interface adapter driver for the FTDI-based devices.

As a PACKAGER, never link against the FTD2XX library, as the resulting
binaries can't be legally distributed, due to the restrictions of the
GPL.


================
Building OpenOCD
================

The INSTALL file contains generic instructions for running 'configure'
and compiling the OpenOCD source code. That file is provided by
default for all GNU autotools packages. If you are not familiar with
the GNU autotools, then you should read those instructions first.

The remainder of this document tries to provide some instructions for
those looking for a quick-install.

OpenOCD Dependencies
--------------------

GCC or Clang is currently required to build OpenOCD. The developers
have begun to enforce strict code warnings (-Wall, -Werror, -Wextra,
and more) and use C99-specific features: inline functions, named
initializers, mixing declarations with code, and other tricks. While
it may be possible to use other compilers, they must be somewhat
modern and could require extending support to conditionally remove
GCC-specific extensions.

You'll also need:

- make
- libtool
- pkg-config >= 0.23 (or compatible)

Additionally, for building from git:

- autoconf >= 2.64
- automake >= 1.9
- texinfo

USB-based adapters depend on libusb-1.0 and some older drivers require
libusb-0.1 or libusb-compat-0.1. A compatible implementation, such as
FreeBSD's, additionally needs the corresponding .pc files.

USB-Blaster, ASIX Presto, OpenJTAG and ft2232 interface adapter
drivers need either one of:
  - libftdi: http://www.intra2net.com/en/developer/libftdi/index.php
  - ftd2xx: http://www.ftdichip.com/Drivers/D2XX.htm (proprietary,
    GPL-incompatible)

CMSIS-DAP support needs HIDAPI library.

Permissions delegation
----------------------

Running OpenOCD with root/administrative permissions is strongly
discouraged for security reasons.

For USB devices on GNU/Linux you should use the contrib/99-openocd.rules
file. It probably belongs somewhere in /etc/udev/rules.d, but
consult your operating system documentation to be sure. Do not forget
to add yourself to the "plugdev" group.

For parallel port adapters on GNU/Linux and FreeBSD please change your
"ppdev" (parport* or ppi*) device node permissions accordingly.

For parport adapters on Windows you need to run install_giveio.bat
(it's also possible to use "ioperm" with Cygwin instead) to give
ordinary users permissions for accessing the "LPT" registers directly.

Compiling OpenOCD
-----------------

To build OpenOCD, use the following sequence of commands:

  ./bootstrap (when building from the git repository)
  ./configure [options]
  make
  sudo make install

The 'configure' step generates the Makefiles required to build
OpenOCD, usually with one or more options provided to it. The first
'make' step will build OpenOCD and place the final executable in
'./src/'. The final (optional) step, ``make install'', places all of
the files in the required location.

To see the list of all the supported options, run
  ./configure --help

Cross-compiling Options
-----------------------

Cross-compiling is supported the standard autotools way, you just need
to specify the cross-compiling target triplet in the --host option,
e.g. for cross-building for Windows 32-bit with MinGW on Debian:

  ./configure --host=i686-w64-mingw32 [options]

To make pkg-config work nicely for cross-compiling, you might need an
additional wrapper script as described at

  http://www.flameeyes.eu/autotools-mythbuster/pkgconfig/cross-compiling.html

This is needed to tell pkg-config where to look for the target
libraries that OpenOCD depends on. Alternatively, you can specify
*_CFLAGS and *_LIBS environment variables directly, see "./configure
--help" for the details.

Parallel Port Dongles
---------------------

If you want to access the parallel port using the PPDEV interface you
have to specify both --enable-parport AND --enable-parport-ppdev, since the
the later option is an option to the parport driver.

The same is true for the --enable-parport-giveio option, you have to
use both the --enable-parport AND the --enable-parport-giveio option
if you want to use giveio instead of ioperm parallel port access
method.

Using FTDI's FTD2XX
-------------------

The (closed source) FTDICHIP.COM solution is faster than libftdi on
Windows. That is the motivation for supporting it even though its
licensing restricts it to non-redistributable OpenOCD binaries, and it
is not available for all operating systems used with OpenOCD. You may,
however, build such copies for personal use.

The FTDICHIP drivers come as either a (win32) ZIP file, or a (Linux)
TAR.GZ file. You must unpack them ``some where'' convenient. As of this
writing FTDICHIP does not supply means to install these files "in an
appropriate place."

You should use the following ./configure options to make use of
FTD2XX:

  --with-ftd2xx-win32-zipdir
                          Where (CYGWIN/MINGW) the zip file from ftdichip.com
                          was unpacked <default=search>
  --with-ftd2xx-linux-tardir
                          Where (Linux/Unix) the tar file from ftdichip.com
                          was unpacked <default=search>
  --with-ftd2xx-lib=(static|shared)
                          Use static or shared ftd2xx libs (default is static)

Remember, this library is binary-only, while OpenOCD is licenced
according to GNU GPLv2 without any exceptions. That means that
_distributing_ copies of OpenOCD built with the FTDI code would
violate the OpenOCD licensing terms.

Note that on Linux there is no good reason to use these FTDI binaries;
they are no faster (on Linux) than libftdi, and cause licensing issues.


==========================
Obtaining OpenOCD From GIT
==========================

You can download the current GIT version with a GIT client of your
choice from the main repository:

   git://git.code.sf.net/p/openocd/code

You may prefer to use a mirror:

   http://repo.or.cz/r/openocd.git
   git://repo.or.cz/openocd.git

Using the GIT command line client, you might use the following command
to set up a local copy of the current repository (make sure there is no
directory called "openocd" in the current directory):

   git clone git://git.code.sf.net/p/openocd/code openocd

Then you can update that at your convenience using

   git pull

There is also a gitweb interface, which you can use either to browse
the repository or to download arbitrary snapshots using HTTP:

   http://repo.or.cz/w/openocd.git

Snapshots are compressed tarballs of the source tree, about 1.3 MBytes
each at this writing.