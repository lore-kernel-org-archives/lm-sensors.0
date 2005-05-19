From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:41 +0000
Subject: [PATCH] I2C: w83627hf needs i2c-isa
Message-Id: <11099685973684@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11099685971963@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: khali@linux-fr.org

ChangeSet 1.2113, 2005/03/02 15:03:48-08:00, khali@linux-fr.org

[PATCH] I2C: w83627hf needs i2c-isa

The w83627hf driver is useless unless i2c-isa is present. All other
drivers in this case do select I2C_ISA through Kconfig, so this one
should as well do.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/chips/Kconfig |    1 +
 1 files changed, 1 insertion(+)


diff -Nru a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig	2005-03-04 12:22:59 -08:00
+++ b/drivers/i2c/chips/Kconfig	2005-03-04 12:22:59 -08:00
@@ -338,6 +338,7 @@
 	tristate "Winbond W83627HF, W83627THF, W83637HF, W83697HF"
 	depends on I2C && EXPERIMENTAL
 	select I2C_SENSOR
+	select I2C_ISA
 	help
 	  If you say yes here you get support for the Winbond W836X7 series
 	  of sensor chips: the W83627HF, W83627THF, W83637HF, and the W83697HF

