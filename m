From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 30 Jun 2011 17:29:53 +0000
Subject: [lm-sensors] [PATCH 4/4] hwmon: (pmbus) Auto-detect temp2 and temp3
Message-Id: <1309454993-8641-5-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Additional temperature attribute support is easy to detect, so do it.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/pmbus.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/pmbus.c b/drivers/hwmon/pmbus.c
index b0ea00b..931d940 100644
--- a/drivers/hwmon/pmbus.c
+++ b/drivers/hwmon/pmbus.c
@@ -65,6 +65,10 @@ static void pmbus_find_sensor_groups(struct i2c_client *client,
 					      PMBUS_STATUS_TEMPERATURE))
 			info->func[0] |= PMBUS_HAVE_STATUS_TEMP;
 	}
+	if (pmbus_check_word_register(client, 0, PMBUS_READ_TEMPERATURE_2))
+		info->func[0] |= PMBUS_HAVE_TEMP2;
+	if (pmbus_check_word_register(client, 0, PMBUS_READ_TEMPERATURE_3))
+		info->func[0] |= PMBUS_HAVE_TEMP3;
 
 	/* Sensors detected on all pages */
 	for (page = 0; page < info->pages; page++) {
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
