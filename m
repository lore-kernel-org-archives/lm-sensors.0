From: moseley@hank.org (Bill Moseley)
Date: Thu, 19 May 2005 06:23:53 +0000
Subject: Lm-sensors docs
Message-Id: <Pine.LNX.4.10.10304172040220.19216-100000@mardy.hank.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Here's a few comments about the docs.

I've installed lm_sensors twice.  First time a few months ago on a MSI
K7T266 board, and today on an Asus P4PE.  Works great on the MSI board,
but faild to detect sensors on the Asue :-(.

I had notes from my first install.  I had noted some confusion on how to
install.  Again today I had the same confusion, so I wanted to pass that
on.

My method of installation was patch the kernel.

First bit of confusion was that the INSTALL docs say:

 2. Patching of the kernel
    This will patch your kernel source tree. You must recompile your kernel
    to take advantage of this. But it makes it possible to compile drivers
    into the kernel itself, instead of having to add them as modules.
    ** AFTER YOU COMPILED AND INSTALLED YOUR KERNEL, YOU WILL STILL HAVE TO
    ** COMPILE THIS PACKAGE TO GET THE USERLAND UTILITIES!
    ** NOT ALL MODULES ARE PATCHED INTO THE KERNEL. SEE BELOW.

It's not clear what that "SEE BELOW" is refering to.  From what I can tell
it refers to the section:

  Makefile configuration variables (compilation option 1)

where it says:

COMPILE_KERNEL
  [...]
  You may want to set this to 0 if you have just patched and compiled 
  your kernel using the same version of this package, and just want to
  compile the user-space tools.

The confusing part is that section is marked "(compilation option 1)" so
it's easy to miss that when not using that option.  It's possible to think
that section does not apply.

The other part that was confusing was this:

Installing the i2c package
=============

"Note: as of kernel 2.3.34, the i2c code is integrated into the
mainstream kernels. Unfortunately, this lm_sensors release REQUIRES
i2c-2.7.0 or later, which is not in kernels through 2.4.19.
Therefore, you must download and install the i2c package with
the same version number or higher as this lm_sensors package."

I'm using kernel 2.4.20 so that implies that I don't need to patch the
kernel with i2c-2.7.0.  My fisrt install I did patch, but had notes that I
didn't really need to.  This time I didn't and when I went to build
lm_sensors tools it said I didn't have 2.7.0.

Minor points, but maybe it can help someone else.

I'm still not 100% clear I installed correctly.  I basically did:

  - unpack fresh kernel
  - download lm_sensors and i2c and ran for both:
     mkpatch/mkpatch.pl . /usr/src/linux | patch -p1 -E -d /usr/src/linux
  - build and installed kernel

  - went back to lm_sensors direcory and ran
     make all; su -c 'make install'

  Then ran sensors detect, which failed.

[...]

Probing for `Winbond W83781D'  ( listed for ASUS at http://secure.netroedge.com/~lm78/newdrivers.html)
  Trying address 0x0290... Failed!
[...]

I noticed one person not able to get the same P4PE board to work, but they
were using an older version of lm_sensors.

I guess I'll just have to wait.

Thank you all very much for lm_sensors.


-- 
Bill Moseley moseley@hank.org
