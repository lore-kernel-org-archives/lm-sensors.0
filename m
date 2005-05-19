From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: dmi_scan: exporting dmi_broken
Message-Id: <20040404212306.09e52efe.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040119090235.GB22028@neu.nirvana>
In-Reply-To: <20040119090235.GB22028@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

BTW my mkpatch patch was incomplete, this one should work better.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
-------------- next part --------------
Index: mkpatch/FILES
=================================RCS file: /home/cvs/lm_sensors2/mkpatch/FILES,v
retrieving revision 1.26
diff -u -r1.26 FILES
--- mkpatch/FILES	23 Jan 2004 17:35:55 -0000	1.26
+++ mkpatch/FILES	4 Apr 2004 19:22:25 -0000
@@ -1,5 +1,3 @@
-kernel/busses/dmi_scan.c	drivers/i2c/dmi_scan.c
-kernel/busses/dmi_scan.h	include/linux/dmi_scan.h
 kernel/busses/i2c-ali1535.c	drivers/i2c/i2c-ali1535.c
 kernel/busses/i2c-ali15x3.c	drivers/i2c/i2c-ali15x3.c
 kernel/busses/i2c-amd756.c	drivers/i2c/i2c-amd756.c
Index: mkpatch/INCLUDES
=================================RCS file: /home/cvs/lm_sensors2/mkpatch/INCLUDES,v
retrieving revision 1.6
diff -u -r1.6 INCLUDES
--- mkpatch/INCLUDES	22 Jun 2003 16:28:45 -0000	1.6
+++ mkpatch/INCLUDES	4 Apr 2004 19:22:25 -0000
@@ -1,3 +1,2 @@
-"dmi_scan.h"		<linux/dmi_scan.h>
 "sensors_compat.h"	<linux/sensors_compat.h>
 "sensors_vid.h"		<linux/sensors_vid.h>
Index: mkpatch/mkpatch.pl
=================================RCS file: /home/cvs/lm_sensors2/mkpatch/mkpatch.pl,v
retrieving revision 1.66
diff -u -r1.66 mkpatch.pl
--- mkpatch/mkpatch.pl	23 Jan 2004 17:35:55 -0000	1.66
+++ mkpatch/mkpatch.pl	4 Apr 2004 19:22:26 -0000
@@ -966,7 +966,7 @@
 obj-$(CONFIG_I2C_I801)			+= i2c-i801.o
 obj-$(CONFIG_I2C_I810)			+= i2c-i810.o
 obj-$(CONFIG_I2C_ISA)			+= i2c-isa.o
-obj-$(CONFIG_I2C_PIIX4)			+= i2c-piix4.o dmi_scan.o
+obj-$(CONFIG_I2C_PIIX4)			+= i2c-piix4.o
 obj-$(CONFIG_I2C_SIS5595)		+= i2c-sis5595.o
 obj-$(CONFIG_I2C_SIS630)		+= i2c-sis630.o
 obj-$(CONFIG_I2C_SIS645)		+= i2c-sis645.o
@@ -975,7 +975,6 @@
 obj-$(CONFIG_I2C_VIA)			+= i2c-via.o
 obj-$(CONFIG_I2C_VIAPRO)		+= i2c-viapro.o
 obj-$(CONFIG_I2C_VOODOO3)		+= i2c-voodoo3.o
-export-objs				+= dmi_scan.o
 EOF
     }
     print OUTPUT;
