From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 07 Nov 2010 15:47:19 +0000
Subject: [lm-sensors] [PATCH 6/7] hwmon: (w83795) Clear intrusion alarm
Message-Id: <20101107164719.7a29aedb@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

When asked to clear the intrusion alarm, do so immediately. We have to
invalidate the cache to make sure the new status will be read. But we
also have to read from the status register once to clear the pending
alarm, as writing to CLR_CHS surprising won't clear it automatically.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 w83795.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/hwmon/w83795.c	2010-11-06 22:37:55.000000000 +0100
+++ b/drivers/hwmon/w83795.c	2010-11-06 22:40:03.000000000 +0100
@@ -755,6 +755,10 @@ store_chassis_clear(struct device *dev,
 	val = w83795_read(client, W83795_REG_CLR_CHASSIS);
 	val |= 0x80;
 	w83795_write(client, W83795_REG_CLR_CHASSIS, val);
+
+	/* Clear status and force cache refresh */
+	w83795_read(client, W83795_REG_ALARM(5));
+	data->valid = 0;
 	mutex_unlock(&data->update_lock);
 	return count;
 }

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
