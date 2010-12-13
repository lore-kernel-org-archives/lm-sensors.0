From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Date: Mon, 13 Dec 2010 16:42:30 +0000
Subject: [lm-sensors] [PATCH] hwmon: (ltc4215) make sysfs file match the
Message-Id: <1292258550-14783-1-git-send-email-iws@ovro.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The ltc4215 driver used the chip's "power good" status bit to provide
the power1_alarm file. This is wrong: the chip is really reporting the
status of one of the monitored voltages.

Change the sysfs file from power1_alarm to in2_min_alarm instead. This
matches the voltage that the chip is raising an alarm for.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
 drivers/hwmon/ltc4215.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/ltc4215.c b/drivers/hwmon/ltc4215.c
index 00d975e..c7e6d8e 100644
--- a/drivers/hwmon/ltc4215.c
+++ b/drivers/hwmon/ltc4215.c
@@ -205,7 +205,6 @@ LTC4215_ALARM(curr1_max_alarm,	(1 << 2),	LTC4215_STATUS);
 
 /* Power (virtual) */
 LTC4215_POWER(power1_input);
-LTC4215_ALARM(power1_alarm,	(1 << 3),	LTC4215_STATUS);
 
 /* Input Voltage */
 LTC4215_VOLTAGE(in1_input,			LTC4215_ADIN);
@@ -214,6 +213,7 @@ LTC4215_ALARM(in1_min_alarm,	(1 << 1),	LTC4215_STATUS);
 
 /* Output Voltage */
 LTC4215_VOLTAGE(in2_input,			LTC4215_SOURCE);
+LTC4215_ALARM(in2_min_alarm,	(1 << 3),	LTC4215_STATUS);
 
 /* Finally, construct an array of pointers to members of the above objects,
  * as required for sysfs_create_group()
@@ -223,13 +223,13 @@ static struct attribute *ltc4215_attributes[] = {
 	&sensor_dev_attr_curr1_max_alarm.dev_attr.attr,
 
 	&sensor_dev_attr_power1_input.dev_attr.attr,
-	&sensor_dev_attr_power1_alarm.dev_attr.attr,
 
 	&sensor_dev_attr_in1_input.dev_attr.attr,
 	&sensor_dev_attr_in1_max_alarm.dev_attr.attr,
 	&sensor_dev_attr_in1_min_alarm.dev_attr.attr,
 
 	&sensor_dev_attr_in2_input.dev_attr.attr,
+	&sensor_dev_attr_in2_min_alarm.dev_attr.attr,
 
 	NULL,
 };
-- 
1.7.2.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
