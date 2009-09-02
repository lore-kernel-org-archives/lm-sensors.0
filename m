From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Date: Wed, 02 Sep 2009 19:24:35 +0000
Subject: [lm-sensors] [PATCH] hwmon: ltc4245: clear faults at startup
Message-Id: <20090902192435.GJ2328@ovro.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

When power is applied to the ltc4245 chip it sometimes reports spurious
faults, which are exposed as alarms in the hwmon output. Clear the fault
register when the driver is installed to clear the alarms.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
 drivers/hwmon/ltc4245.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/ltc4245.c b/drivers/hwmon/ltc4245.c
index 034b2c5..e389643 100644
--- a/drivers/hwmon/ltc4245.c
+++ b/drivers/hwmon/ltc4245.c
@@ -382,7 +382,8 @@ static int ltc4245_probe(struct i2c_client *client,
 	mutex_init(&data->update_lock);
 
 	/* Initialize the LTC4245 chip */
-	/* TODO */
+	i2c_smbus_write_byte_data(client, LTC4245_FAULT1, 0x00);
+	i2c_smbus_write_byte_data(client, LTC4245_FAULT2, 0x00);
 
 	/* Register sysfs hooks */
 	ret = sysfs_create_group(&client->dev.kobj, &ltc4245_group);
-- 
1.5.4.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
