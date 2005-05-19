From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:19 +0000
Subject: [PATCH 2.6] I2C: Update Kconfig for AMD bus drivers
Message-Id: <20041016194127.14c81b9e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This updates the AMD entries i2c/busses/Kconfig in two ways:
* Add missing PCI dependancy.
* Reword the help so that users know exactly what is supported by each
  driver.

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.9-rc4-bk1/drivers/i2c/busses/Kconfig.orig	2004-10-12 19:44:25.000000000 +0200
+++ linux-2.6.9-rc4-bk1/drivers/i2c/busses/Kconfig	2004-10-16 19:37:33.000000000 +0200
@@ -40,21 +40,23 @@
 	  will be called i2c-ali15x3.
 
 config I2C_AMD756
-	tristate "AMD 756/766"
-	depends on I2C && EXPERIMENTAL
+	tristate "AMD 756/766/768/8111 and nVidia nForce"
+	depends on I2C && PCI && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for the AMD
-	  756/766/768 mainboard I2C interfaces.
+	  756/766/768 mainboard I2C interfaces.  The driver also includes
+	  support for the first (SMBus 1.0) I2C interface of the AMD 8111 and
+	  the nVidia nForce I2C interface.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-amd756.
 
 config I2C_AMD8111
 	tristate "AMD 8111"
-	depends on I2C && EXPERIMENTAL
+	depends on I2C && PCI && EXPERIMENTAL
 	help
-	  If you say yes to this option, support will be included for the AMD
-	  8111 mainboard I2C interfaces.
+	  If you say yes to this option, support will be included for the
+	  second (SMBus 2.0) AMD 8111 mainboard I2C interface.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-amd8111.


-- 
Jean Delvare
http://khali.linux-fr.org/
