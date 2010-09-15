From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Sep 2010 13:41:00 +0000
Subject: [lm-sensors] [patch 02/36] hwmon: (w83795) Misc cleanups
Message-Id: <20100915154100.27a4ba6d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Improve driver description.
* Drop unused macro.
* Drop unreachable code.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83795.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- linux-2.6.36-rc4.orig/drivers/hwmon/w83795.c	2010-09-15 15:09:49.000000000 +0200
+++ linux-2.6.36-rc4/drivers/hwmon/w83795.c	2010-09-15 15:10:28.000000000 +0200
@@ -183,8 +183,6 @@ static const u8 IN_LSB_SHIFT_IDX[][2]  #define W83795_REG_FAN_MIN_LSB(index)	(0xC4 + (index) / 2)
 #define W83795_REG_FAN_MIN_LSB_SHIFT(index) \
 	(((index) % 1) ? 4 : 0)
-#define W83795_REG_FAN_CTRL_SHIFT(index) \
-	(((index) > 7) ? ((index) - 8) : (index))
 
 #define W83795_REG_VID_CTRL		0x6A
 
@@ -793,9 +791,6 @@ store_pwm_enable(struct device *dev, str
 	}
 	mutex_unlock(&data->update_lock);
 	return count;
-
-	mutex_unlock(&data->update_lock);
-	return -EINVAL;
 }
 
 static ssize_t
@@ -2131,7 +2126,7 @@ static void __exit sensors_w83795_exit(v
 }
 
 MODULE_AUTHOR("Wei Song");
-MODULE_DESCRIPTION("w83795 driver");
+MODULE_DESCRIPTION("W83795G/ADG hardware monitoring driver");
 MODULE_LICENSE("GPL");
 
 module_init(sensors_w83795_init);


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
