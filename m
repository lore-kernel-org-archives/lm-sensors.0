From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 14 Dec 2005 19:16:20 +0000
Subject: [lm-sensors] i2cdetect fails on a Asus P5ND2-Sli Deluxe
Message-Id: <20051214201620.25edfc9f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4399D312.1010109@free.fr>
In-Reply-To: <4399D312.1010109@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Fred,

> That works much better !
> I don't have 1024 MB but 1 24 MB : 0 does not appears.
> I don't know why.

Looks like a bug in xsensors, it has code to drop leading zeroes in
memory module sizes, but that code is broken and actually strips all
zeroes, not just leading ones. 1024 is the first power of 2 which needs
a zero, so I guess the bug went unnoticed because even now, 1 GB memory
modules are quite rare.

Please give a try to the following patch, which I expect to fix it:

 src/gui.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- xsensors-0.47.orig/src/gui.c	2005-12-14 19:44:10.000000000 +0100
+++ xsensors-0.47/src/gui.c	2005-12-14 19:44:36.000000000 +0100
@@ -460,13 +460,11 @@
                                  (widget) ], theme, x, highLow, 
                                  54, 0, 18, 30 );
                     
-                if ( result >= 100 ) {
+                if ( result >= 100 || x != 198 ) {
                     curInt = result / 100;
                     result = result % 100;
             
                     get_pm_location( curInt, &x );
-                } else {
-                    x = 198;
                 }
             
                 gdk_draw_drawable( widget->window, 
@@ -474,13 +472,11 @@
                                  (widget) ], theme, x, highLow, 
                                  72, 0, 18, 30 );
 
-                if ( result >= 10 ) {
+                if ( result >= 10 || x != 198 ) {
                     curInt = result / 10;
                     result = result % 10;
             
                     get_pm_location( curInt, &x );
-                } else {
-                    x = 198;
                 }
             
                 gdk_draw_drawable( widget->window, 


> PS :  xsensors works fine, but sensord still complains :
> Dec 13 23:25:01 marsu sensord: Adapter: SMBus nForce2 adapter at 5000
> Dec 13 23:25:01 marsu sensord: Algorithm: Unavailable from sysfs

Note that it isn't an error. You may ignore any message related to
algorithms safely, see my other post. We'll drop them soon (I hope).

> Dec 13 23:25:01 marsu sensord:   Memory type: Invalid
> Dec 13 23:25:01 marsu sensord:   Memory size (MB): Invalid 14 10 97 4

Lack of support for DDR2 SDRAM. We have dropped eeprom support entirely
from sensord in the next release anyway. There's little interest in
continuously polling read-only data, isn't it?

> PS2 : why it87 is not supported by xsensors ?

it87 is. You have (I guess) it8712, which is only supported in xsensors
0.47, while Sarge ships 0.46. Try 0.47 with my two patches and it
should work fine.

-- 
Jean Delvare

