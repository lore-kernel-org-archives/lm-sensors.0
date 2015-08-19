From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 19 Aug 2015 16:06:13 +0000
Subject: [lm-sensors] [PATCH 2/4] hwmon: (pmbus) Enable PEC if the controller supports it
Message-Id: <1440000375-3036-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

PMBus controllers optionally support PEC. Configure the driver
to use it if available to improve operational security.

Suggested-by: Michael Jones <mike@proclivis.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/pmbus_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 398198140b81..ba59eaef2e07 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -1751,6 +1751,11 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
 		}
 	}
 
+	/* Enable PEC if the controller supports it */
+	ret = i2c_smbus_read_byte_data(client, PMBUS_CAPABILITY);
+	if (ret >= 0 && (ret & PB_CAPABILITY_ERROR_CHECK))
+		client->flags |= I2C_CLIENT_PEC;
+
 	pmbus_clear_faults(client);
 
 	if (info->identify) {
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
