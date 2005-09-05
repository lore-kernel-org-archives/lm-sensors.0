From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:48:23 +0000
Subject: [lm-sensors] [PATCH] I2C: Separate non-i2c hwmon drivers from
Message-Id: <11259567663719@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <11259567663617@kroah.com>
In-Reply-To: <11259567663617@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] I2C: Separate non-i2c hwmon drivers from i2c-core (4/9)

All ISA hardware monitoring drivers (including hybrid drivers) now have
a hard dependency on i2c-isa, so they must select I2C_ISA. As a result,
CONFIG_I2C_ISA doesn't need to be left visible to the user. The good
thing here is that users will stop complaining that some driver doesn't
work just because they forgot to compile or load i2c-isa.

At this point, all drivers are working again and the cleanup phase can
begin.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 5042c7d752fe72c6924037058367f63902e68c5c
tree 5ae9c01c08497279fb3ffeac0394261412bdd6a9
parent fde0950903ce8cc38a91dd095280decceda2ff82
author Jean Delvare <khali@linux-fr.org> Tue, 19 Jul 2005 23:53:07 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:10 -0700

 drivers/hwmon/Kconfig      |    3 +++
 drivers/i2c/busses/Kconfig |    8 +-------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -160,6 +160,7 @@ config SENSORS_IT87
 	tristate "ITE IT87xx and compatibles"
 	depends on HWMON && I2C
 	select I2C_SENSOR
+	select I2C_ISA
 	help
 	  If you say yes here you get support for ITE IT87xx sensor chips
 	  and clones: SiS960.
@@ -211,6 +212,7 @@ config SENSORS_LM78
 	tristate "National Semiconductor LM78 and compatibles"
 	depends on HWMON && I2C && EXPERIMENTAL
 	select I2C_SENSOR
+	select I2C_ISA
 	help
 	  If you say yes here you get support for National Semiconductor LM78,
 	  LM78-J and LM79.
@@ -366,6 +368,7 @@ config SENSORS_W83781D
 	tristate "Winbond W83781D, W83782D, W83783S, W83627HF, Asus AS99127F"
 	depends on HWMON && I2C
 	select I2C_SENSOR
+	select I2C_ISA
 	help
 	  If you say yes here you get support for the Winbond W8378x series
 	  of sensor chips: the W83781D, W83782D, W83783S and W83627HF,
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -182,14 +182,8 @@ config I2C_IOP3XX
 	  will be called i2c-iop3xx.
 
 config I2C_ISA
-	tristate "ISA Bus support"
+	tristate
 	depends on I2C
-	help
-	  If you say yes to this option, support will be included for i2c
-	  interfaces that are on the ISA bus.
-
-	  This driver can also be built as a module.  If so, the module
-	  will be called i2c-isa.
 
 config I2C_ITE
 	tristate "ITE I2C Adapter"

