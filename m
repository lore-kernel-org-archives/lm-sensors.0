From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 30 Jun 2011 17:29:52 +0000
Subject: [lm-sensors] [PATCH 3/4] hwmon: (pmbus) Improve fan detection
Message-Id: <1309454993-8641-4-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Some PMBus devices return no error when reading fan speed registers, but don't
really support fans. Strengthen fan detection by also checking if fan
configuration registers exist.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/pmbus.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pmbus.c b/drivers/hwmon/pmbus.c
index 98e2e28..b0ea00b 100644
--- a/drivers/hwmon/pmbus.c
+++ b/drivers/hwmon/pmbus.c
@@ -47,12 +47,14 @@ static void pmbus_find_sensor_groups(struct i2c_client *client,
 	if (info->func[0]
 	    && pmbus_check_byte_register(client, 0, PMBUS_STATUS_INPUT))
 		info->func[0] |= PMBUS_HAVE_STATUS_INPUT;
-	if (pmbus_check_word_register(client, 0, PMBUS_READ_FAN_SPEED_1)) {
+	if (pmbus_check_byte_register(client, 0, PMBUS_FAN_CONFIG_12) &&
+	    pmbus_check_word_register(client, 0, PMBUS_READ_FAN_SPEED_1)) {
 		info->func[0] |= PMBUS_HAVE_FAN12;
 		if (pmbus_check_byte_register(client, 0, PMBUS_STATUS_FAN_12))
 			info->func[0] |= PMBUS_HAVE_STATUS_FAN12;
 	}
-	if (pmbus_check_word_register(client, 0, PMBUS_READ_FAN_SPEED_3)) {
+	if (pmbus_check_byte_register(client, 0, PMBUS_FAN_CONFIG_34) &&
+	    pmbus_check_word_register(client, 0, PMBUS_READ_FAN_SPEED_3)) {
 		info->func[0] |= PMBUS_HAVE_FAN34;
 		if (pmbus_check_byte_register(client, 0, PMBUS_STATUS_FAN_34))
 			info->func[0] |= PMBUS_HAVE_STATUS_FAN34;
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
