From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 11 May 2006 07:57:50 +0000
Subject: [lm-sensors] [PATCH] i2c: Suggest N for rare devices
Message-Id: <20060511095750.36e15bff.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I'm adding this to my patch queue.

(Note: I'm back from a one-week trip in N?rnberg, Germany, so please
give me some time to catch up with my personnal e-mail before I can go
on with this mailing list.)

Content-Disposition: inline; filename=i2c-Kconfig-suggest-N-for-rare-devices.patch

Improve the Kconfig help text of the follwing i2c drivers:
* busses/i2c-pca-isa.c
* chips/pcf8574.c
* chips/pcf8591.c
These are hard to detect and building them into the kernel
results in long delays at boot.

March 2006, thread "I2C_PCA_ISA causes boot delays"
http://marc.theaimsgroup.com/?l=linux-kernel&m4360399415744&w=2

April 2006, thread "i2c-related 1-minute hang during bootup"
http://marc.theaimsgroup.com/?l=linux-kernel&m4640992330721&w=2

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/i2c/busses/Kconfig |    6 ++++++
 drivers/i2c/chips/Kconfig  |    8 ++++++++
 2 files changed, 14 insertions(+)

--- linux-2.6.17-rc3.orig/drivers/i2c/busses/Kconfig	2006-05-10 19:58:20.000000000 +0200
+++ linux-2.6.17-rc3/drivers/i2c/busses/Kconfig	2006-05-11 09:47:51.000000000 +0200
@@ -503,6 +503,7 @@
 	tristate "PCA9564 on an ISA bus"
 	depends on I2C
 	select I2C_ALGOPCA
+	default n
 	help
 	  This driver supports ISA boards using the Philips PCA 9564
 	  Parallel bus to I2C bus controller
@@ -510,6 +511,11 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-pca-isa.
 
+	  This device is almost undetectable and using this driver on a
+	  system which doesn't have this device will result in long
+	  delays at boot time and/or when I2C/SMBus chip drivers are
+	  loaded.  If unsure, say N.
+
 config I2C_MV64XXX
 	tristate "Marvell mv64xxx I2C Controller"
 	depends on I2C && MV64X60 && EXPERIMENTAL
--- linux-2.6.17-rc3.orig/drivers/i2c/chips/Kconfig	2006-04-03 20:12:43.000000000 +0200
+++ linux-2.6.17-rc3/drivers/i2c/chips/Kconfig	2006-05-11 09:43:11.000000000 +0200
@@ -39,6 +39,7 @@
 config SENSORS_PCF8574
 	tristate "Philips PCF8574 and PCF8574A"
 	depends on I2C && EXPERIMENTAL
+	default n
 	help
 	  If you say yes here you get support for Philips PCF8574 and 
 	  PCF8574A chips.
@@ -46,6 +47,9 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called pcf8574.
 
+	  These devices are hard to detect and rarely found on mainstream
+	  hardware.  If unsure, say N.
+
 config SENSORS_PCA9539
 	tristate "Philips PCA9539 16-bit I/O port"
 	depends on I2C && EXPERIMENTAL
@@ -59,12 +63,16 @@
 config SENSORS_PCF8591
 	tristate "Philips PCF8591"
 	depends on I2C && EXPERIMENTAL
+	default n
 	help
 	  If you say yes here you get support for Philips PCF8591 chips.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called pcf8591.
 
+	  These devices are hard to detect and rarely found on mainstream
+	  hardware.  If unsure, say N.
+
 config ISP1301_OMAP
 	tristate "Philips ISP1301 with OMAP OTG"
 	depends on I2C && ARCH_OMAP_OTG


-- 
Jean Delvare

