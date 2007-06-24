From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 24 Jun 2007 09:15:03 +0000
Subject: [lm-sensors] [PATCH 02/10] hwmon/w83627ehf: Update the Kconfig entry
Message-Id: <20070624111503.43cc35a5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: David Hubbard <david.c.hubbard@gmail.com>

Add description for the W83627DHG chip to Kconfig.

Signed-off-by: David Hubbard <david.c.hubbard@gmail.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/Kconfig |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- linux-2.6.22-rc5.orig/drivers/hwmon/Kconfig	2007-06-23 18:10:02.000000000 +0200
+++ linux-2.6.22-rc5/drivers/hwmon/Kconfig	2007-06-23 19:03:05.000000000 +0200
@@ -589,17 +589,17 @@ config SENSORS_W83627HF
 	  will be called w83627hf.
 
 config SENSORS_W83627EHF
-	tristate "Winbond W83627EHF"
+	tristate "Winbond W83627EHF/DHG"
 	depends on I2C && EXPERIMENTAL
 	select I2C_ISA
 	help
-	  If you say yes here you get preliminary support for the hardware
+	  If you say yes here you get support for the hardware
 	  monitoring functionality of the Winbond W83627EHF Super-I/O chip.
-	  Only fan and temperature inputs are supported at the moment, while
-	  the chip does much more than that.
 
 	  This driver also supports the W83627EHG, which is the lead-free
-	  version of the W83627EHF.
+	  version of the W83627EHF, and the W83627DHG, which is a similar
+	  chip suited for specific Intel processors that use PECI such as
+	  the Core 2 Duo.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called w83627ehf.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
