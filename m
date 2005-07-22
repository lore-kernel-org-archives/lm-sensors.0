From: jcromie@divsol.com (Jim Cromie)
Date: Fri, 22 Jul 2005 03:06:12 +0000
Subject: [lm-sensors] [patch]  KERNELVERSION=2.6.12-something make
Message-Id: <42E04664.3020001@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


attached patches allow making with setting in environment.

it apparently is effective only right after make clean,
but dependencies are remembered in all the foo.d files


Separately, Ive been trying to hack around my lack of
include/linux/modversions.h,  which is not present in the 2.6.12, 13-rc
trees that Ive built

Ive tried turning off CONFIG_MODVERSIONS,
despite some ifdefs in some of the code that suggest it shoul help,
I get almost nowhere doing so.


is modversions.h a synthesized file (written based upon config) ?
is it a holdover from earlier kernel releases ?

-------------- next part --------------
--- lm_sensors2/Makefile.~1.96.~	2005-07-21 18:54:47.000000000 -0600
+++ lm_sensors2/Makefile	2005-07-21 18:55:45.000000000 -0600
@@ -28,7 +28,7 @@
 
 # The currently running kernel version. This is used right below to
 # determine where the kernel sources can be found.
-KERNELVERSION := $(shell uname -r)
+KERNELVERSION ?= $(shell uname -r)
 
 # The location of linux itself. This is used to find the kernel headers
 # and other things.
-------------- next part --------------
--- i2c/Makefile.~1.38.~	2005-03-19 04:10:34.000000000 -0700
+++ i2c/Makefile	2005-07-21 18:37:06.000000000 -0600
@@ -25,7 +25,7 @@
 
 # The currently running kernel version. This is used right below to
 # determine where the kernel sources can be found.
-KERNELVERSION := $(shell uname -r)
+KERNELVERSION ?= $(shell uname -r)
 
 # The location of linux itself. This is used to find the kernel headers
 # and other things.
