From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:47:19 +0000
Subject: [lm-sensors] [PATCH] hwmon: soften lm75 initialization
Message-Id: <11259567652129@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: soften lm75 initialization

The LM75 initialization is a bit agressive, it arbitrarily reconfigures
the chip. Make it only change the bit it needs. This is a port from
the 2.4 kernel version of the driver (lm_sensors).

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit e647ecf15e365679f0528d7815ab4db0d4802918
tree c1892aa10ee99705e706680760d6bf247e5914af
parent 17f990c87a1e5addc49b99a53b3d2a2fac9680e9
author Jean Delvare <khali@linux-fr.org> Wed, 27 Jul 2005 21:28:28 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:06 -0700

 drivers/hwmon/lm75.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -251,8 +251,12 @@ static int lm75_write_value(struct i2c_c
 
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

