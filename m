From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 29 Apr 2008 11:25:55 +0000
Subject: [lm-sensors] [PATCH] hwmon: (f71882fg) Delete needless forward
Message-Id: <20080429132555.5f6b0291@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

These functions aren't used before being defined, so there's no point
in forward-declaring them.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Hans de Goede <j.w.r.degoede@hhs.nl>
---
 drivers/hwmon/f71882fg.c |    6 ------
 1 file changed, 6 deletions(-)

--- linux-2.6.26-rc0.orig/drivers/hwmon/f71882fg.c	2008-04-29 13:08:05.000000000 +0200
+++ linux-2.6.26-rc0/drivers/hwmon/f71882fg.c	2008-04-29 13:20:35.000000000 +0200
@@ -88,8 +88,6 @@ static inline void superio_enter(int bas
 static inline void superio_select(int base, int ld);
 static inline void superio_exit(int base);
 
-static inline u16 fan_from_reg ( u16 reg );
-
 struct f71882fg_data {
 	unsigned short addr;
 	struct device *hwmon_dev;
@@ -117,10 +115,6 @@ struct f71882fg_data {
 	u8	temp_diode_open;
 };
 
-static u8 f71882fg_read8(struct f71882fg_data *data, u8 reg);
-static u16 f71882fg_read16(struct f71882fg_data *data, u8 reg);
-static void f71882fg_write8(struct f71882fg_data *data, u8 reg, u8 val);
-
 /* Sysfs in*/
 static ssize_t show_in(struct device *dev, struct device_attribute *devattr,
 	char *buf);


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
