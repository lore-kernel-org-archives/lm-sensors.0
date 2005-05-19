From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: [PATCH 2.6] velleman typo
Message-Id: <20031225094952.50b6a987.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031224181541.0c1cabe8.khali@linux-fr.org>
In-Reply-To: <20031224181541.0c1cabe8.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Updated version follow.

This patch replaces "K9000" with "K8000" everywhere (5 occurences) since
it seems that the "K9000" was a typo in the first place. It also rewords
the i2c-velleman doc. I have fixed it in our CVS repository too, and
have been sending a similar patch to Marcelo for Linux 2.4.

Thanks.

diff -ru linux-2.6.0/Documentation/i2c/i2c-velleman linux-2.6.0-k1/Documentation/i2c/i2c-velleman
--- linux-2.6.0/Documentation/i2c/i2c-velleman	Thu Dec 18 03:58:49 2003
+++ linux-2.6.0-k1/Documentation/i2c/i2c-velleman	Thu Dec 25 09:09:26 2003
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
diff -ru linux-2.6.0/Documentation/i2c/summary linux-2.6.0-k1/Documentation/i2c/summary
--- linux-2.6.0/Documentation/i2c/summary	Thu Dec 18 03:59:04 2003
+++ linux-2.6.0-k1/Documentation/i2c/summary	Thu Dec 25 09:08:17 2003
@@ -71,5 +71,5 @@
 i2c-adap-ibm_ocp: IBM 4xx processor I2C device (uses i2c-algo-ibm_ocp) (NOT BUILT BY DEFAULT)
 i2c-pport:       Primitive parallel port adapter (uses i2c-algo-bit)
 i2c-rpx:         RPX board Motorola 8xx I2C device (uses i2c-algo-8xx) (NOT BUILT BY DEFAULT)
-i2c-velleman:    Velleman K9000 parallel port adapter (uses i2c-algo-bit)
+i2c-velleman:    Velleman K8000 parallel port adapter (uses i2c-algo-bit)
 
diff -ru linux-2.6.0/drivers/i2c/busses/Kconfig linux-2.6.0-k1/drivers/i2c/busses/Kconfig
--- linux-2.6.0/drivers/i2c/busses/Kconfig	Thu Dec 18 03:59:28 2003
+++ linux-2.6.0-k1/drivers/i2c/busses/Kconfig	Thu Dec 25 09:08:17 2003
@@ -275,10 +275,10 @@
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
diff -ru linux-2.6.0/drivers/i2c/busses/i2c-velleman.c linux-2.6.0-k1/drivers/i2c/busses/i2c-velleman.c
--- linux-2.6.0/drivers/i2c/busses/i2c-velleman.c	Thu Dec 18 03:59:20 2003
+++ linux-2.6.0-k1/drivers/i2c/busses/i2c-velleman.c	Thu Dec 25 09:08:17 2003
@@ -1,5 +1,5 @@
 /* ------------------------------------------------------------------------- */
-/* i2c-velleman.c i2c-hw access for Velleman K9000 adapters		     */
+/* i2c-velleman.c i2c-hw access for Velleman K8000 adapters		     */
 /* ------------------------------------------------------------------------- */
 /*   Copyright (C) 1995-96, 2000 Simon G. Vogl
 


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
