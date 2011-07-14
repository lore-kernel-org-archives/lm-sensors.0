From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 14 Jul 2011 01:54:34 +0000
Subject: [lm-sensors] [PATCH 05/15] hwmon: (pmbus) Increase attribute name
Message-Id: <1310608484-20678-6-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310485300-2168-6-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1310485300-2168-6-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Some hwmon sysfs attributes have a length of 20 bytes (plus terminating 0).
I2C_NAME_SIZE is defined as 20 and thus can not be used to define the length
of hwmon sysfs attributes. Replace it with PMBUS_NAME_SIZE, set to 24.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/pmbus/pmbus_core.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index cef763c..8ff7ebf 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -74,8 +74,10 @@
 #define PB_STATUS_INPUT_BASE	(PB_STATUS_FAN34_BASE + PMBUS_PAGES)
 #define PB_STATUS_TEMP_BASE	(PB_STATUS_INPUT_BASE + 1)
 
+#define PMBUS_NAME_SIZE		24
+
 struct pmbus_sensor {
-	char name[I2C_NAME_SIZE];	/* sysfs sensor name */
+	char name[PMBUS_NAME_SIZE];	/* sysfs sensor name */
 	struct sensor_device_attribute attribute;
 	u8 page;		/* page number */
 	u8 reg;			/* register */
@@ -86,14 +88,14 @@ struct pmbus_sensor {
 };
 
 struct pmbus_boolean {
-	char name[I2C_NAME_SIZE];	/* sysfs boolean name */
+	char name[PMBUS_NAME_SIZE];	/* sysfs boolean name */
 	struct sensor_device_attribute attribute;
 };
 
 struct pmbus_label {
-	char name[I2C_NAME_SIZE];	/* sysfs label name */
+	char name[PMBUS_NAME_SIZE];	/* sysfs label name */
 	struct sensor_device_attribute attribute;
-	char label[I2C_NAME_SIZE];	/* label */
+	char label[PMBUS_NAME_SIZE];	/* label */
 };
 
 struct pmbus_data {
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
