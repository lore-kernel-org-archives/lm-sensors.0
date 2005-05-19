From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: [PATCH] i2c driver fixes for 2.6.0
Message-Id: <10728219712881@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10728219711046@kroah.com>
References: <10728219692713@kroah.com>
In-Reply-To: <10728219692713@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1496.8.39, 2003/12/30 12:10:24-08:00, khali@linux-fr.org

[PATCH] I2C: velleman typo

This patch replaces "K9000" with "K8000" everywhere (5 occurences) since
it seems that the "K9000" was a typo in the first place. It also rewords
the i2c-velleman doc. I have fixed it in our CVS repository too, and
have been sending a similar patch to Marcelo for Linux 2.4.


 Documentation/i2c/i2c-velleman    |   16 ++++++----------
 Documentation/i2c/summary         |    2 +-
 drivers/i2c/busses/Kconfig        |    4 ++--
 drivers/i2c/busses/i2c-velleman.c |    2 +-
 4 files changed, 10 insertions(+), 14 deletions(-)


diff -Nru a/Documentation/i2c/i2c-velleman b/Documentation/i2c/i2c-velleman
--- a/Documentation/i2c/i2c-velleman	Tue Dec 30 12:28:12 2003
+++ b/Documentation/i2c/i2c-velleman	Tue Dec 30 12:28:12 2003
@@ -1,6 +1,6 @@
 i2c-velleman driver
 -------------------
-This is a driver for i2c-hw access for Velleman K9000 and other adapters.
+This is a driver for i2c-hw access for Velleman K8000 and other adapters.
 
 Useful links
 ------------
@@ -10,18 +10,14 @@
 Velleman K8000 Howto:
 	http://howto.htlw16.ac.at/k8000-howto.html
 
-
 K8000 and K8005 libraries
 -------------------------
-The project has lead to new libs for the Velleman K8000 and K8005..
+The project has lead to new libs for the Velleman K8000 and K8005:
 LIBK8000 v1.99.1 and LIBK8005 v0.21
 
-With these libs you can control the K8000 and K8005 with the original
-simple commands which are in the original Velleman software.
-Like SetIOchannel, ReadADchannel, SendStepCCWFull and many more.
-Via i2c kernel device /dev/velleman
+With these libs, you can control the K8000 interface card and the K8005
+stepper motor card with the simple commands which are in the original
+Velleman software, like SetIOchannel, ReadADchannel, SendStepCCWFull and
+many more, using /dev/velleman.
 
 The libs can be found on http://groups.yahoo.com/group/k8000/files/linux/
-
-The Velleman K8000 interface card on http://www.velleman.be/kits/k8000.htm
-The Velleman K8005 steppermotorcard on http://www.velleman.be/kits/k8005.htm
diff -Nru a/Documentation/i2c/summary b/Documentation/i2c/summary
--- a/Documentation/i2c/summary	Tue Dec 30 12:28:12 2003
+++ b/Documentation/i2c/summary	Tue Dec 30 12:28:12 2003
@@ -71,5 +71,5 @@
 i2c-adap-ibm_ocp: IBM 4xx processor I2C device (uses i2c-algo-ibm_ocp) (NOT BUILT BY DEFAULT)
 i2c-pport:       Primitive parallel port adapter (uses i2c-algo-bit)
 i2c-rpx:         RPX board Motorola 8xx I2C device (uses i2c-algo-8xx) (NOT BUILT BY DEFAULT)
-i2c-velleman:    Velleman K9000 parallel port adapter (uses i2c-algo-bit)
+i2c-velleman:    Velleman K8000 parallel port adapter (uses i2c-algo-bit)
 
diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Tue Dec 30 12:28:12 2003
+++ b/drivers/i2c/busses/Kconfig	Tue Dec 30 12:28:12 2003
@@ -276,10 +276,10 @@
 	  will be called i2c-sis96x.
 
 config I2C_VELLEMAN
-	tristate "Velleman K9000 adapter"
+	tristate "Velleman K8000 adapter"
 	depends on I2C_ALGOBIT && ISA
 	help
-	  This supports the Velleman K9000 parallel-port I2C adapter.  Say Y
+	  This supports the Velleman K8000 parallel-port I2C adapter.  Say Y
 	  if you own such an adapter.
 
 	  This support is also available as a module.  If so, the module 
diff -Nru a/drivers/i2c/busses/i2c-velleman.c b/drivers/i2c/busses/i2c-velleman.c
--- a/drivers/i2c/busses/i2c-velleman.c	Tue Dec 30 12:28:12 2003
+++ b/drivers/i2c/busses/i2c-velleman.c	Tue Dec 30 12:28:12 2003
@@ -1,5 +1,5 @@
 /* ------------------------------------------------------------------------- */
-/* i2c-velleman.c i2c-hw access for Velleman K9000 adapters		     */
+/* i2c-velleman.c i2c-hw access for Velleman K8000 adapters		     */
 /* ------------------------------------------------------------------------- */
 /*   Copyright (C) 1995-96, 2000 Simon G. Vogl
 

