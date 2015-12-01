From: Nishanth Menon <nm@ti.com>
Date: Tue, 01 Dec 2015 04:25:55 +0000
Subject: [lm-sensors] [PATCH] hwmon: (tmp102) Force wait for conversion time for the first valid data
Message-Id: <1448943955-2385-1-git-send-email-nm@ti.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linux-omap@vger.kernel.org, beagleboard-x15@googlegroups.com, Nishanth Menon <nm@ti.com>, Eduardo Valentin <edubezval@gmail.com>

TMP102 works based on conversions done periodically. However, as per
the TMP102 data sheet[1] the first conversion is triggered immediately
after we program the configuration register. The temperature data
registers do not reflect proper data until the first conversion is
complete (in our case HZ/4).

The driver currently sets the last_update to be jiffies - HZ, just
after the configuration is complete. When tmp102 driver registers
with the thermal framework, it immediately tries to read the sensor
temperature data. This takes place even before the conversion on the
TMP102 is complete and results in an invalid temperature read.

Depending on the value read, this may cause thermal framework to
assume that a critical temperature event has occurred and attempts to
shutdown the system.

Instead of causing an invalid mid-conversion value to be read
erroneously, we mark the last_update to be in-line with the current
jiffies. This allows the tmp102_update_device function to skip update
until the required conversion time is complete. Further, we ensure to
return -EAGAIN result instead of returning spurious temperature (such
as 0C) values to the caller to prevent any wrong decisions made with
such values.

A simpler alternative approach could be to sleep in the probe for the
duration required, but that will result in latency that is undesirable
that can delay boot sequence un-necessarily.

[1] http://www.ti.com/lit/ds/symlink/tmp102.pdf

Cc: Eduardo Valentin <edubezval@gmail.com>
Reported-by: Aparna Balasubramanian <aparnab@ti.com>
Reported-by: Elvita Lobo <elvita@ti.com>
Reported-by: Yan Liu <yan-liu@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

Example case (from Beagleboard-x15 using an older kernel revision):
	http://pastebin.ubuntu.com/13591711/
Notice the thermal shutdown trigger:
	thermal thermal_zone3: critical temperature reached(108 C),shutting down

 drivers/hwmon/tmp102.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
index 65482624ea2c..145f69108f23 100644
--- a/drivers/hwmon/tmp102.c
+++ b/drivers/hwmon/tmp102.c
@@ -50,6 +50,9 @@
 #define	TMP102_TLOW_REG			0x02
 #define	TMP102_THIGH_REG		0x03
 
+/* TMP102 range is -55 to 150C -> we use -128 as a default invalid value */
+#define TMP102_NOTREADY			-128
+
 struct tmp102 {
 	struct i2c_client *client;
 	struct device *hwmon_dev;
@@ -102,6 +105,12 @@ static int tmp102_read_temp(void *dev, int *temp)
 {
 	struct tmp102 *tmp102 = tmp102_update_device(dev);
 
+	/* Is it too early even to return a conversion? */
+	if (tmp102->temp[0] = TMP102_NOTREADY) {
+		dev_dbg(dev, "%s: Conversion not ready yet..\n", __func__);
+		return -EAGAIN;
+	}
+
 	*temp = tmp102->temp[0];
 
 	return 0;
@@ -114,6 +123,10 @@ static ssize_t tmp102_show_temp(struct device *dev,
 	struct sensor_device_attribute *sda = to_sensor_dev_attr(attr);
 	struct tmp102 *tmp102 = tmp102_update_device(dev);
 
+	/* Is it too early even to return a read? */
+	if (tmp102->temp[sda->index] = TMP102_NOTREADY)
+		return -EAGAIN;
+
 	return sprintf(buf, "%d\n", tmp102->temp[sda->index]);
 }
 
@@ -207,7 +220,11 @@ static int tmp102_probe(struct i2c_client *client,
 		status = -ENODEV;
 		goto fail_restore_config;
 	}
-	tmp102->last_update = jiffies - HZ;
+	tmp102->last_update = jiffies;
+	/* Mark that we are not ready with data until conversion is complete */
+	tmp102->temp[0] = TMP102_NOTREADY;
+	tmp102->temp[1] = TMP102_NOTREADY;
+	tmp102->temp[2] = TMP102_NOTREADY;
 	mutex_init(&tmp102->lock);
 
 	hwmon_dev = hwmon_device_register_with_groups(dev, client->name,
-- 
2.6.2.402.g2635c2b


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
