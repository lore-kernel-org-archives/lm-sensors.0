From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: [PATCH 2.6] Trivial: group Intel on I2C Hardware Bus support menu
Message-Id: <71ss2156tl8s8mb4afff8511nu3gke4qi8@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

From an end-user perspective it is easy to miss the third Intel PIIX 
entry on the menuconfig "I2C Hardware Bus support" screen.
Also the Intel 801 menu item does not mention ICH.

This trivial patch groups three Intel entries together, adds ICH to 
menu item, and ICH5/ICH5R to the help section.

Ref: http://developer.intel.com/design/chipsets/datashts/252516.htm 
for part numbers.

Signed-off-by: Grant Coady <gcoady@gmail.com>

--- linux-2.6.11-mm2/drivers/i2c/busses/Kconfig	2005-03-09 13:44:45.000000000 +1100
+++ linux-2.6.11-mm2-b/drivers/i2c/busses/Kconfig	2005-03-09 14:55:02.000000000 +1100
@@ -108,7 +108,7 @@
 	  will be called i2c-hydra.
 
 config I2C_I801
-	tristate "Intel 801"
+	tristate "Intel 801/ICH"
 	depends on I2C && PCI && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for the Intel
@@ -119,7 +119,7 @@
 	    82801BA
 	    82801CA/CAM
 	    82801DB
-	    82801EB
+	    82801EB/82801ER (ICH5/ICH5R)
 	    6300ESB
 	    ICH6
 	    ICH7
@@ -143,6 +143,23 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-i810.
 
+config I2C_PIIX4
+	tristate "Intel PIIX4"
+	depends on I2C && PCI && EXPERIMENTAL
+	help
+	  If you say yes to this option, support will be included for the Intel
+	  PIIX4 family of mainboard I2C interfaces.  Specifically, the following
+	  versions of the chipset are supported:
+	    Intel PIIX4
+	    Intel 440MX
+	    Serverworks OSB4
+	    Serverworks CSB5
+	    Serverworks CSB6
+	    SMSC Victory66
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-piix4.
+
 config I2C_IBM_IIC
 	tristate "IBM PPC 4xx on-chip I2C interface"
 	depends on IBM_OCP && I2C
@@ -285,23 +302,6 @@
 	  This support is also available as a module.  If so, the module 
 	  will be called i2c-parport-light.
 
-config I2C_PIIX4
-	tristate "Intel PIIX4"
-	depends on I2C && PCI && EXPERIMENTAL
-	help
-	  If you say yes to this option, support will be included for the Intel
-	  PIIX4 family of mainboard I2C interfaces.  Specifically, the following
-	  versions of the chipset are supported:
-	    Intel PIIX4
-	    Intel 440MX
-	    Serverworks OSB4
-	    Serverworks CSB5
-	    Serverworks CSB6
-	    SMSC Victory66
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called i2c-piix4.
-
 config I2C_PROSAVAGE
 	tristate "S3/VIA (Pro)Savage"
 	depends on I2C && PCI && EXPERIMENTAL
