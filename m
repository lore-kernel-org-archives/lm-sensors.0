From: Steve Glendinning <steve.glendinning@smsc.com>
Date: Fri, 17 Jun 2011 15:44:48 +0000
Subject: [lm-sensors] [PATCH] [RFC] lm85: fix PWM control on SMSC EMC2300 &
Message-Id: <1308325488-26386-1-git-send-email-steve.glendinning@smsc.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch works around a quirk of the hardware's implementation to
allow raw PWM fan drive values to be set.  Without it the device
never leaves auto control mode so the PWM output request is ignored.

I'm not sure if this is the right place for the workaround, comments?

Signed-off-by: Steve Glendinning <steve.glendinning@smsc.com>
---
 drivers/hwmon/lm85.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index da72dc1..f4e124b 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -1146,8 +1146,21 @@ static const struct attribute_group lm85_group_in567 = {
 
 static void lm85_init_client(struct i2c_client *client)
 {
+	struct lm85_data *data = i2c_get_clientdata(client);
 	int value;
 
+	/* For emc2300 & emc6d103s when auto temp min is the default value,
+	 * pwm can never be controlled manually, so change this */
+	if (data->type = emc6d103s) {
+		int nr;
+
+		for (nr = 0; nr < 3; nr++) {
+			data->zone[nr].limit = TEMP_TO_REG(-127000);
+			lm85_write_value(client, LM85_REG_AFAN_LIMIT(nr),
+				data->zone[nr].limit);
+		}
+	}
+
 	/* Start monitoring if needed */
 	value = lm85_read_value(client, LM85_REG_CONFIG);
 	if (!(value & 0x01)) {
-- 
1.7.4.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
