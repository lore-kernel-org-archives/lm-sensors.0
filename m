From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: [PATCH] I2C update for 2.6.5
Message-Id: <10819814521034@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10819814522824@kroah.com>
References: <10819814492866@kroah.com>
In-Reply-To: <10819814492866@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1643.36.22, 2004/04/09 12:06:16-07:00, greg@kroah.com

[PATCH] I2C: clean up out of order bus Makefile and Kconfig entries.


 drivers/i2c/busses/Kconfig  |   16 ++++++++--------
 drivers/i2c/busses/Makefile |    2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Wed Apr 14 15:13:05 2004
+++ b/drivers/i2c/busses/Kconfig	Wed Apr 14 15:13:05 2004
@@ -5,29 +5,29 @@
 menu "I2C Hardware Bus support"
 	depends on I2C
 
-config I2C_ALI1563
-	tristate "ALI 1563"
+config I2C_ALI1535
+	tristate "ALI 1535"
 	depends on I2C && PCI && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for the SMB
-	  Host controller on Acer Labs Inc. (ALI) M1563 South Bridges.  The SMB
+	  Host controller on Acer Labs Inc. (ALI) M1535 South Bridges.  The SMB
 	  controller is part of the 7101 device, which is an ACPI-compliant
 	  Power Management Unit (PMU).
 
 	  This driver can also be built as a module.  If so, the module
-	  will be called i2c-ali1563.
+	  will be called i2c-ali1535.
 
-config I2C_ALI1535
-	tristate "ALI 1535"
+config I2C_ALI1563
+	tristate "ALI 1563"
 	depends on I2C && PCI && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for the SMB
-	  Host controller on Acer Labs Inc. (ALI) M1535 South Bridges.  The SMB
+	  Host controller on Acer Labs Inc. (ALI) M1563 South Bridges.  The SMB
 	  controller is part of the 7101 device, which is an ACPI-compliant
 	  Power Management Unit (PMU).
 
 	  This driver can also be built as a module.  If so, the module
-	  will be called i2c-ali1535.
+	  will be called i2c-ali1563.
 
 config I2C_ALI15X3
 	tristate "ALI 15x3"
diff -Nru a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
--- a/drivers/i2c/busses/Makefile	Wed Apr 14 15:13:05 2004
+++ b/drivers/i2c/busses/Makefile	Wed Apr 14 15:13:05 2004
@@ -3,8 +3,8 @@
 #
 
 obj-$(CONFIG_I2C_ALI1535)	+= i2c-ali1535.o
-obj-$(CONFIG_I2C_ALI15X3)	+= i2c-ali15x3.o
 obj-$(CONFIG_I2C_ALI1563)	+= i2c-ali1563.o
+obj-$(CONFIG_I2C_ALI15X3)	+= i2c-ali15x3.o
 obj-$(CONFIG_I2C_AMD756)	+= i2c-amd756.o
 obj-$(CONFIG_I2C_AMD8111)	+= i2c-amd8111.o
 obj-$(CONFIG_I2C_ELEKTOR)	+= i2c-elektor.o

