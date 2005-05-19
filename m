From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: [PATCH 2.6] w83627hf needs i2c-isa
Message-Id: <20050227114604.634d35f0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

The w83627hf driver is useless unless i2c-isa is present. All other
drivers in this case do select I2C_ISA through Kconfig, so this one
should as well do.

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.11-rc5/drivers/i2c/chips/Kconfig.orig	2005-02-25 07:59:12.000000000 +0100
+++ linux-2.6.11-rc5/drivers/i2c/chips/Kconfig	2005-02-27 11:37:52.000000000 +0100
@@ -304,6 +304,7 @@
 	tristate "Winbond W83627HF, W83627THF, W83637HF, W83697HF"
 	depends on I2C && EXPERIMENTAL
 	select I2C_SENSOR
+	select I2C_ISA
 	help
 	  If you say yes here you get support for the Winbond W836X7 series
 	  of sensor chips: the W83627HF, W83627THF, W83637HF, and the W83697HF


-- 
Jean Delvare
