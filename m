From: macro@linux-mips.org (Maciej W. Rozycki)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: [PATCH] Enable I2C_PIIX4 for 64-bit platforms
Message-Id: <Pine.LNX.4.61L.0502120502580.30117@blysk.ds.pg.gda.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

 Is there any specific reason for the PIIX4 SMBus driver to be disabled on 
64-bit platforms?  If not, then please apply the following change.  The 
MIPS Technologies Malta development board has the 82371EB chip and 
supports 64-bit configurations.  I've verified the driver to work 
correctly using 64-bit kernels for both endiannesses.

  Maciej

Signed-off-by: Maciej W. Rozycki <macro@mips.com>

patch-mips-2.6.10-rc3-20041216-i2c-piix64-0
diff -up --recursive --new-file linux-mips-2.6.10-rc3-20041216.macro/drivers/i2c/busses/Kconfig linux-mips-2.6.10-rc3-20041216/drivers/i2c/busses/Kconfig
--- linux-mips-2.6.10-rc3-20041216.macro/drivers/i2c/busses/Kconfig	2004-12-09 20:07:39.000000000 +0000
+++ linux-mips-2.6.10-rc3-20041216/drivers/i2c/busses/Kconfig	2005-01-26 19:48:36.000000000 +0000
@@ -270,7 +270,7 @@ config I2C_PARPORT_LIGHT
 
 config I2C_PIIX4
 	tristate "Intel PIIX4"
-	depends on I2C && PCI && EXPERIMENTAL && !64BIT
+	depends on I2C && PCI && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for the Intel
 	  PIIX4 family of mainboard I2C interfaces.  Specifically, the following
