From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 13 Mar 2012 16:10:52 +0000
Subject: [lm-sensors] [PATCH] hwmon: (zl6100) Enable interval between chip accesses for all chips
Message-Id: <1331655052-6574-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Intersil reports that all chips supported by the zl6100 driver require
an interval between chip accesses, even ZL2004 and ZL6105 which were thought
to be safe.

Reported-by: Vivek Gani <vgani@intersil.com>
Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 Documentation/hwmon/zl6100   |   14 ++++++--------
 drivers/hwmon/pmbus/zl6100.c |   12 +++---------
 2 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/Documentation/hwmon/zl6100 b/Documentation/hwmon/zl6100
index 51f76a1..a4e8d90 100644
--- a/Documentation/hwmon/zl6100
+++ b/Documentation/hwmon/zl6100
@@ -88,14 +88,12 @@ Module parameters
 delay
 -----
 
-Some Intersil/Zilker Labs DC-DC controllers require a minimum interval between
-I2C bus accesses. According to Intersil, the minimum interval is 2 ms, though
-1 ms appears to be sufficient and has not caused any problems in testing.
-The problem is known to affect ZL6100, ZL2105, and ZL2008. It is known not to
-affect ZL2004 and ZL6105. The driver automatically sets the interval to 1 ms
-except for ZL2004 and ZL6105. To enable manual override, the driver provides a
-writeable module parameter, 'delay', which can be used to set the interval to
-a value between 0 and 65,535 microseconds.
+Intersil/Zilker Labs DC-DC controllers require a minimum interval between I2C
+bus accesses. According to Intersil, the minimum interval is 2 ms, though 1 ms
+appears to be sufficient and has not caused any problems in testing. The problem
+is known to affect all currently supported chips. For manual override, the
+driver provides a writeable module parameter, 'delay', which can be used to set
+the interval to a value between 0 and 65,535 microseconds.
 
 
 Sysfs entries
diff --git a/drivers/hwmon/pmbus/zl6100.c b/drivers/hwmon/pmbus/zl6100.c
index 880b90c..e3e8420 100644
--- a/drivers/hwmon/pmbus/zl6100.c
+++ b/drivers/hwmon/pmbus/zl6100.c
@@ -200,17 +200,11 @@ static int zl6100_probe(struct i2c_client *client,
 	data->id = mid->driver_data;
 
 	/*
-	 * ZL2005, ZL2008, ZL2105, and ZL6100 are known to require a wait time
-	 * between I2C accesses. ZL2004 and ZL6105 are known to be safe.
-	 * Other chips have not yet been tested.
-	 *
-	 * Only clear the wait time for chips known to be safe. The wait time
-	 * can be cleared later for additional chips if tests show that it
-	 * is not needed (in other words, better be safe than sorry).
+	 * According to information from the chip vendor, all currently
+	 * supported chips are known to require a wait time between I2C
+	 * accesses.
 	 */
 	data->delay = delay;
-	if (data->id = zl2004 || data->id = zl6105)
-		data->delay = 0;
 
 	/*
 	 * Since there was a direct I2C device access above, wait before
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
