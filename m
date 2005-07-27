From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 27 Jul 2005 21:28:41 +0000
Subject: [lm-sensors] [PATCH 2.6] hwmon: soften lm75 initialization
Message-Id: <20050727212828.0df56e31.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg, all,

The LM75 initialization is a bit agressive, it arbitrarily reconfigures
the chip. Make it only change the bit it needs. This is a port from
the 2.4 kernel version of the driver (lm_sensors).

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/hwmon/lm75.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

--- linux-2.6.13-rc3.orig/drivers/hwmon/lm75.c	2005-07-16 09:53:09.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/lm75.c	2005-07-16 17:35:18.000000000 +0200
@@ -264,8 +264,12 @@
 
 static void lm75_init_client(struct i2c_client *client)
 {
-	/* Initialize the LM75 chip */
-	lm75_write_value(client, LM75_REG_CONF, 0);
+	int reg;
+
+	/* Enable if in shutdown mode */
+	reg = lm75_read_value(client, LM75_REG_CONF);
+	if (reg >= 0 && (reg & 0x01))
+		lm75_write_value(client, LM75_REG_CONF, reg & 0xfe);
 }
 
 static struct lm75_data *lm75_update_device(struct device *dev)


-- 
Jean Delvare
