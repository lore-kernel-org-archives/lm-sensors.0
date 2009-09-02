From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Date: Wed, 02 Sep 2009 19:23:47 +0000
Subject: [lm-sensors] [PATCH] hwmon: ltc4215: clear faults at startup
Message-Id: <20090902192347.GI2328@ovro.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

When power is applied to the ltc4215 chip it sometimes reports spurious
faults. The faults are not yet exposed via sysfs, however it may be useful
for userspace to read the fault register directly with the i2cget command.
Clear the fault register when the driver is installed so userspace doesn't
have to worry about spurious fault indications.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
 drivers/hwmon/ltc4215.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/ltc4215.c b/drivers/hwmon/ltc4215.c
index 9386e2a..6c9a041 100644
--- a/drivers/hwmon/ltc4215.c
+++ b/drivers/hwmon/ltc4215.c
@@ -259,7 +259,7 @@ static int ltc4215_probe(struct i2c_client *client,
 	mutex_init(&data->update_lock);
 
 	/* Initialize the LTC4215 chip */
-	/* TODO */
+	i2c_smbus_write_byte_data(client, LTC4215_FAULT, 0x00);
 
 	/* Register sysfs hooks */
 	ret = sysfs_create_group(&client->dev.kobj, &ltc4215_group);
-- 
1.5.4.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
