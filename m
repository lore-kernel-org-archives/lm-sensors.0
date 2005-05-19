From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:18 +0000
Subject: [PATCH] i2c driver fixes for 2.6.0-test5
Message-Id: <10642734231255@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <1064273422761@kroah.com>
References: <1064273416272@kroah.com>
In-Reply-To: <1064273416272@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1315.1.13, 2003/09/22 12:26:49-07:00, greg@kroah.com

I2C: clean up the drivers/i2c/Kconfig file


 drivers/i2c/Kconfig |  102 +++++++++++++++++++---------------------------------
 1 files changed, 38 insertions(+), 64 deletions(-)


diff -Nru a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
--- a/drivers/i2c/Kconfig	Mon Sep 22 16:13:58 2003
+++ b/drivers/i2c/Kconfig	Mon Sep 22 16:13:58 2003
@@ -22,10 +22,20 @@
 	  If you want I2C support, you should say Y here and also to the
 	  specific driver for your bus adapter(s) below.
 
-	  This I2C support is also available as a module.  If you want to
-	  compile it as a module, say M here and read
-	  <file:Documentation/modules.txt>.
-	  The module will be called i2c-core.
+	  This I2C support can also be built as a module.  If so, the module
+	  will be called i2c-core.
+
+config I2C_CHARDEV
+	tristate "I2C device interface"
+	depends on I2C
+	help
+	  Say Y here to use i2c-* device files, usually found in the /dev
+	  directory on your system.  They make it possible to have user-space
+	  programs use the I2C bus.  Information on how to do this is
+	  contained in the file <file:Documentation/i2c/dev-interface>.
+
+	  This support is also available as a module.  If so, the module 
+	  will be called i2c-dev.
 
 config I2C_ALGOBIT
 	tristate "I2C bit-banging interfaces"
@@ -35,10 +45,8 @@
 	  adapters.  Say Y if you own an I2C adapter belonging to this class
 	  and then say Y to the specific driver for you adapter below.
 
-	  This support is also available as a module.  If you want to compile
-	  it as a module, say M here and read
-	  <file:Documentation/modules.txt>.
-	  The module will be called i2c-algo-bit.
+	  This support is also available as a module.  If so, the module 
+	  will be called i2c-algo-bit.
 
 config I2C_PROSAVAGE
 	tristate "S3/VIA (Pro)Savage"
@@ -51,14 +59,8 @@
 	    S3/VIA KM266/VT8375 aka ProSavage8
 	    S3/VIA KM133/VT8365 aka Savage4
 
-	  This can also be built as a module which can be inserted and removed
-	  while the kernel is running.  If you want to compile it as a module,
-	  say M here and read <file:Documentation/modules.txt>.
-	  The module will be called i2c-prosavage.
-
-	  You will also need the latest user-space utilties: you can find them
-	  in the lm_sensors package, which you can download at
-	  http://www.lm-sensors.nu
+	  This support is also available as a module.  If so, the module 
+	  will be called i2c-prosavage.
 
 config I2C_PHILIPSPAR
 	tristate "Philips style parallel port adapter"
@@ -67,13 +69,8 @@
 	  This supports parallel-port I2C adapters made by Philips.  Say Y if
 	  you own such an adapter.
 
-	  This driver is also available as a module.  If you want to compile
-	  it as a module, say M here and read
-	  <file:Documentation/modules.txt>.
-	  The module will be called i2c-philips-par.
-
-	  Note that if you want support for different parallel port devices,
-	  life will be much easier if you compile them all as modules.
+	  This support is also available as a module.  If so, the module 
+	  will be called i2c-philips-par.
 
 config I2C_ELV
 	tristate "ELV adapter"
@@ -82,10 +79,8 @@
 	  This supports parallel-port I2C adapters called ELV.  Say Y if you
 	  own such an adapter.
 
-	  This driver is also available as a module.  If you want to compile
-	  it as a module, say M here and read
-	  <file:Documentation/modules.txt>.
-	  The module will be called i2c-elv.
+	  This support is also available as a module.  If so, the module 
+	  will be called i2c-elv.
 
 config I2C_VELLEMAN
 	tristate "Velleman K9000 adapter"
@@ -94,10 +89,8 @@
 	  This supports the Velleman K9000 parallel-port I2C adapter.  Say Y
 	  if you own such an adapter.
 
-	  This driver is also available as a module.  If you want to compile
-	  it as a module, say M here and read
-	  <file:Documentation/modules.txt>.
-	  The module will be called i2c-velleman.
+	  This support is also available as a module.  If so, the module 
+	  will be called i2c-velleman.
 
 config SCx200_I2C
 	tristate "NatSemi SCx200 I2C using GPIO pins"
@@ -107,7 +100,8 @@
 
 	  If you don't know what to do here, say N.
 
-	  If compiled as a module, it will be called scx200_i2c.
+	  This support is also available as a module.  If so, the module 
+	  will be called scx200_i2c.
 
 config SCx200_I2C_SCL
 	int "GPIO pin used for SCL"
@@ -133,7 +127,8 @@
 
 	  If you don't know what to do here, say N.
 
-	  If compiled as a module, it will be called scx200_acb.
+	  This support is also available as a module.  If so, the module 
+	  will be called scx200_acb.
 
 config I2C_ALGOPCF
 	tristate "I2C PCF 8584 interfaces"
@@ -143,10 +138,8 @@
 	  Say Y if you own an I2C adapter belonging to this class and then say
 	  Y to the specific driver for you adapter below.
 
-	  This support is also available as a module.  If you want to compile
-	  it as a module, say M here and read
-	  <file:Documentation/modules.txt>.
-	  The module will be called i2c-algo-pcf.
+	  This support is also available as a module.  If so, the module 
+	  will be called i2c-algo-pcf.
 
 config I2C_ELEKTOR
 	tristate "Elektor ISA card"
@@ -155,10 +148,8 @@
 	  This supports the PCF8584 ISA bus I2C adapter.  Say Y if you own
 	  such an adapter.
 
-	  This driver is also available as a module.  If you want to compile
-	  it as a module, say M here and read
-	  <file:Documentation/modules.txt>.
-	  The module will be called i2c-elektor.
+	  This support is also available as a module.  If so, the module 
+	  will be called i2c-elektor.
 
 config I2C_KEYWEST
 	tristate "Powermac Keywest I2C interface"
@@ -167,9 +158,8 @@
 	  This supports the use of the I2C interface in the combo-I/O
 	  chip on recent Apple machines.  Say Y if you have such a machine.
 
-	  This driver is also available as a module.  If you want to compile
-	  it as a module, say M here and read Documentation/modules.txt.
-	  The module will be called i2c-keywest.
+	  This support is also available as a module.  If so, the module 
+	  will be called i2c-keywest.
 
 config ITE_I2C_ALGO
 	tristate "ITE I2C Algorithm"
@@ -179,9 +169,8 @@
 	  systems. Say Y if you have one of these. You should also say Y for
 	  the ITE I2C peripheral driver support below.
 
-	  This support is also available as a module. If you want to compile
-	  it as a module, say M here and read Documentation/modules.txt.
-	  The module will be called i2c-algo-ite.
+	  This support is also available as a module.  If so, the module 
+	  will be called i2c-algo-ite.
 
 config ITE_I2C_ADAP
 	tristate "ITE I2C Adapter"
@@ -191,9 +180,8 @@
 	  systems. Say Y if you have one of these. You should also say Y for
 	  the ITE I2C driver algorithm support above.
 
-	  This support is also available as a module. If you want to compile
-	  it as a module, say M here and read Documentation/modules.txt.
-	  The module will be called i2c-adap-ite.
+	  This support is also available as a module.  If so, the module 
+	  will be called i2c-adap-ite.
 
 config I2C_ALGO8XX
 	tristate "MPC8xx CPM I2C interface"
@@ -210,20 +198,6 @@
 config I2C_IOP3XX
 	tristate "Intel XScale IOP3xx on-chip I2C interface"
 	depends on ARCH_IOP3XX && I2C
-
-config I2C_CHARDEV
-	tristate "I2C device interface"
-	depends on I2C
-	help
-	  Say Y here to use i2c-* device files, usually found in the /dev
-	  directory on your system.  They make it possible to have user-space
-	  programs use the I2C bus.  Information on how to do this is
-	  contained in the file <file:Documentation/i2c/dev-interface>.
-
-	  This code is also available as a module.  If you want to compile
-	  it as a module, say M here and read
-	  <file:Documentation/modules.txt>.
-	  The module will be called i2c-dev.
 
 	source drivers/i2c/busses/Kconfig
 	source drivers/i2c/chips/Kconfig

