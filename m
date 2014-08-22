From: <rob.coulson@gmail.com>
Date: Fri, 22 Aug 2014 19:28:44 +0000
Subject: [lm-sensors] [PATCH] hwmon: (ds1621) Update zbits after conversion rate change
Message-Id: <1408735724-10846-1-git-send-email-rob.coulson@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Robert Coulson <rob.coulson@gmail.com>

After the conversion rate is changed, the zbits are not updated,
but should be, since they are used later in the set_temp function.

This issue was noticed and reported by Murat Ilsever.

Signed-off-by: Robert Coulson <rob.coulson@gmail.com>
---
 drivers/hwmon/ds1621.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
index 872d767..b96d201 100644
--- a/drivers/hwmon/ds1621.c
+++ b/drivers/hwmon/ds1621.c
@@ -309,6 +309,7 @@ static ssize_t set_convrate(struct device *dev, struct device_attribute *da,
 	data->conf |= (resol << DS1621_REG_CONFIG_RESOL_SHIFT);
 	i2c_smbus_write_byte_data(client, DS1621_REG_CONF, data->conf);
 	data->update_interval = ds1721_convrates[resol];
+	data->zbits = 7 - resol;
 	mutex_unlock(&data->update_lock);
 
 	return count;
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
