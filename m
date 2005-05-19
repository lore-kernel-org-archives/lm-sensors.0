From: willy@w.ods.org (Willy Tarreau)
Date: Thu, 19 May 2005 06:25:41 +0000
Subject: [PATCH-2.4] build fix for amd756 in sensors 2.9
Message-Id: <20050306103039.GA18356@alpha.home.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

lm_sensors 2.9 does not fully compile under linux 2.4 because the i2c-amd756
module exports a symbol and is not referenced in the export-objs in the
makefile :

(i2c-amd756.c)
+
+EXPORT_SYMBOL(amd756_smbus);
+

(makefile)
export-objs     := i2c-core.o i2c-algo-bit.o i2c-algo-pcf.o \
                   i2c-algo-ite.o i2c-algo-sibyte.o i2c-algo-sgi.o \
                   i2c-algo-8xx.o i2c-algo-ibm_ocp.o \
                   i2c-proc.o

The trivial fix below fixes the problem. Please apply.

Thanks,
Willy
(PS: I'm not subscribed, so please CC me when replying)


--- ./drivers/i2c/Makefile.bad	Mon Feb  7 00:30:00 2005
+++ ./drivers/i2c/Makefile	Mon Feb  7 00:56:18 2005
@@ -7,7 +7,7 @@
 export-objs	:= i2c-core.o i2c-algo-bit.o i2c-algo-pcf.o \
 		   i2c-algo-ite.o i2c-algo-sibyte.o i2c-algo-sgi.o \
 		   i2c-algo-8xx.o i2c-algo-ibm_ocp.o \
-		   i2c-proc.o
+		   i2c-proc.o i2c-amd756.o
 
 obj-$(CONFIG_I2C)		+= i2c-core.o
 obj-$(CONFIG_I2C_CHARDEV)	+= i2c-dev.o

