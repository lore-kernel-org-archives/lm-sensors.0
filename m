From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 09 Jan 2013 16:59:09 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: Retire SENSORS_LIMIT
Message-Id: <1357750750-30512-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1357750750-30512-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1357750750-30512-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: Jean Delvare <khali@linux-fr.org>, "Mark M. Hoffman" <mhoffman@lightlink.com>, George Joseph <george.joseph@fairview5.com>, Juerg Haefliger <juergh@gmail.com>, Steve Glendinning <steve.glendinning@shawell.net>, Riku Voipio <riku.voipio@iki.fi>, Guillaume Ligneul <guillaume.ligneul@gmail.com>, "Hans J. Koch" <hjk@hansjkoch.de>, Roger Lucas <vt8231@hiddenengine.co.uk>, Marc Hulsman <m.hulsman@tudelft.nl>, Rudolf Marek <r.marek@assembler.cz>, Corentin Chary <corentin.chary@gmail.com>, Matthew Garrett <mjg@redhat.com>, platform-driver-x86@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

SENSORS_LIMIT and clamp_val have the same functionality, so retire SENSORS_LIMIT
as it is no longer needed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/sysfs-interface |    8 ++++----
 include/linux/hwmon.h               |   12 ------------
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
index 1f4dd85..79f8257 100644
--- a/Documentation/hwmon/sysfs-interface
+++ b/Documentation/hwmon/sysfs-interface
@@ -722,14 +722,14 @@ add/subtract if it has been divided before the add/subtract.
 What to do if a value is found to be invalid, depends on the type of the
 sysfs attribute that is being set. If it is a continuous setting like a
 tempX_max or inX_max attribute, then the value should be clamped to its
-limits using SENSORS_LIMIT(value, min_limit, max_limit). If it is not
-continuous like for example a tempX_type, then when an invalid value is
-written, -EINVAL should be returned.
+limits using clamp_val(value, min_limit, max_limit). If it is not continuous
+like for example a tempX_type, then when an invalid value is written,
+-EINVAL should be returned.
 
 Example1, temp1_max, register is a signed 8 bit value (-128 - 127 degrees):
 
 	long v = simple_strtol(buf, NULL, 10) / 1000;
-	v = SENSORS_LIMIT(v, -128, 127);
+	v = clamp_val(v, -128, 127);
 	/* write v to register */
 
 Example2, fan divider setting, valid values 2, 4 and 8:
diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index 82b29ae..b2514f7 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -20,16 +20,4 @@ struct device *hwmon_device_register(struct device *dev);
 
 void hwmon_device_unregister(struct device *dev);
 
-/* Scale user input to sensible values */
-static inline int SENSORS_LIMIT(long value, long low, long high)
-{
-	if (value < low)
-		return low;
-	else if (value > high)
-		return high;
-	else
-		return value;
-}
-
 #endif
-
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
