From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:18 +0000
Subject: [PATCH] i2c driver fixes for 2.6.0-test5
Message-Id: <10642734242947@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10642734242958@kroah.com>
References: <1064273416272@kroah.com>
In-Reply-To: <1064273416272@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1315.1.16, 2003/09/22 13:10:15-07:00, greg@kroah.com

[PATCH] I2C: fix up dependancies in the i2c/busses/Kconfig file


 drivers/i2c/busses/Kconfig |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Mon Sep 22 16:13:27 2003
+++ b/drivers/i2c/busses/Kconfig	Mon Sep 22 16:13:27 2003
@@ -64,7 +64,7 @@
 
 config I2C_I810
 	tristate "Intel 810/815"
-	depends on I2C && PCI && EXPERIMENTAL
+	depends on I2C_ALGOBIT && PCI && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for the Intel
 	  810/815 family of mainboard I2C interfaces.  Specifically, the 
@@ -129,7 +129,7 @@
 
 config I2C_SAVAGE4
 	tristate "S3 Savage 4"
-	depends on I2C && PCI && EXPERIMENTAL
+	depends on I2C_ALGOBIT && PCI && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for the 
 	  S3 Savage 4 I2C interface.
@@ -176,7 +176,7 @@
 
 config I2C_VIA
 	tristate "VIA 82C58B"
-	depends on I2C && PCI && EXPERIMENTAL
+	depends on I2C_ALGOBIT && PCI && EXPERIMENTAL
 	help
 
 	  If you say yes to this option, support will be included for the VIA
@@ -205,7 +205,7 @@
 
 config I2C_VOODOO3
 	tristate "Voodoo 3"
-	depends on I2C && PCI && EXPERIMENTAL
+	depends on I2C_ALGOBIT && PCI && EXPERIMENTAL
 	help
 
 	  If you say yes to this option, support will be included for the

