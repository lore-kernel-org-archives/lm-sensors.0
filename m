From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: [PATCH 2.6] velleman typo
Message-Id: <20031224181541.0c1cabe8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Merry Christmas Greg ;)

That one replaces "K9000" with "K8000" everywhere (5 occurences) since
it seems that the "K9000" was a typo in the first place. I will fix it
in our CVS repository too, and then send a similar patch to Marcelo.

diff -ru linux-2.6.0/Documentation/i2c/i2c-velleman linux-2.6.0-k1/Documentation/i2c/i2c-velleman
--- linux-2.6.0/Documentation/i2c/i2c-velleman	2003-12-18 03:58:49.000000000 +0100
+++ linux-2.6.0-k1/Documentation/i2c/i2c-velleman	2003-12-24 17:57:23.000000000 +0100
@@ -1,6 +1,6 @@
 i2c-velleman driver
 -------------------
-This is a driver for i2c-hw access for Velleman K9000 and other adapters.
+This is a driver for i2c-hw access for Velleman K8000 and other adapters.
 
 Useful links
 ------------
diff -ru linux-2.6.0/Documentation/i2c/summary linux-2.6.0-k1/Documentation/i2c/summary
--- linux-2.6.0/Documentation/i2c/summary	2003-12-18 03:59:04.000000000 +0100
+++ linux-2.6.0-k1/Documentation/i2c/summary	2003-12-24 17:57:14.000000000 +0100
@@ -71,5 +71,5 @@
 i2c-adap-ibm_ocp: IBM 4xx processor I2C device (uses i2c-algo-ibm_ocp) (NOT BUILT BY DEFAULT)
 i2c-pport:       Primitive parallel port adapter (uses i2c-algo-bit)
 i2c-rpx:         RPX board Motorola 8xx I2C device (uses i2c-algo-8xx) (NOT BUILT BY DEFAULT)
-i2c-velleman:    Velleman K9000 parallel port adapter (uses i2c-algo-bit)
+i2c-velleman:    Velleman K8000 parallel port adapter (uses i2c-algo-bit)
 
diff -ru linux-2.6.0/drivers/i2c/busses/Kconfig linux-2.6.0-k1/drivers/i2c/busses/Kconfig
--- linux-2.6.0/drivers/i2c/busses/Kconfig	2003-12-18 03:59:28.000000000 +0100
+++ linux-2.6.0-k1/drivers/i2c/busses/Kconfig	2003-12-24 17:56:55.000000000 +0100
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
--- linux-2.6.0/drivers/i2c/busses/i2c-velleman.c	2003-12-18 03:59:20.000000000 +0100
+++ linux-2.6.0-k1/drivers/i2c/busses/i2c-velleman.c	2003-12-24 17:57:06.000000000 +0100
@@ -1,5 +1,5 @@
 /* ------------------------------------------------------------------------- */
-/* i2c-velleman.c i2c-hw access for Velleman K9000 adapters		     */
+/* i2c-velleman.c i2c-hw access for Velleman K8000 adapters		     */
 /* ------------------------------------------------------------------------- */
 /*   Copyright (C) 1995-96, 2000 Simon G. Vogl
 


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
