From: gregkh@suse.de (Greg KH)
Date: Thu, 19 May 2005 06:25:47 +0000
Subject: [PATCH] I2C: group Intel on I2C Hardware Bus support
Message-Id: <11123113911463@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <1112311391247@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: grant_nospam@dodo.com.au

ChangeSet 1.2330, 2005/03/31 14:07:43-08:00, grant_nospam@dodo.com.au

[PATCH] I2C: group Intel on I2C Hardware Bus support

 From an end-user perspective it is easy to miss the third Intel PIIX
entry on the menuconfig "I2C Hardware Bus support" screen.
Also the Intel 801 menu item does not mention ICH.

This trivial patch groups three Intel entries together, adds ICH to
menu item, and ICH5/ICH5R to the help section.  Includes suggestions
from Jean Delvare.

Signed-off-by: Grant Coady <gcoady@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/busses/Kconfig |   38 +++++++++++++++++++-------------------
 1 files changed, 19 insertions(+), 19 deletions(-)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	2005-03-31 15:18:22 -08:00
+++ b/drivers/i2c/busses/Kconfig	2005-03-31 15:18:22 -08:00
@@ -108,7 +108,7 @@
 	  will be called i2c-hydra.
 
 config I2C_I801
-	tristate "Intel 801"
+	tristate "Intel 82801 (ICH)"
 	depends on I2C && PCI && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for the Intel
@@ -119,7 +119,7 @@
 	    82801BA
 	    82801CA/CAM
 	    82801DB
-	    82801EB
+	    82801EB/ER (ICH5/ICH5R)
 	    6300ESB
 	    ICH6
 	    ICH7
@@ -143,6 +143,23 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-i810.
 
+config I2C_PIIX4
+	tristate "Intel PIIX4"
+	depends on I2C && PCI
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
@@ -284,23 +301,6 @@
 
 	  This support is also available as a module.  If so, the module 
 	  will be called i2c-parport-light.
-
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
 
 config I2C_PROSAVAGE
 	tristate "S3/VIA (Pro)Savage"

