From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 13 Mar 2013 23:23:56 +0000
Subject: [lm-sensors] [PATCH 4/5] hwmon: (w83627ehf) Drop read/write lock
Message-Id: <1363217037-15723-5-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signeded/write lock is acquired for each read/write operation from/to the chip.
This occurs either during initialization, when it is not needed, or during
updates, when the update_lock is held as well, and it is not needed either.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83627ehf.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index 92e173d..a56c33e 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -429,7 +429,6 @@ struct w83627ehf_data {
 	const char *name;
 
 	struct device *hwmon_dev;
-	struct mutex lock;
 
 	u16 reg_temp[NUM_REG_TEMP];
 	u16 reg_temp_over[NUM_REG_TEMP];
@@ -538,8 +537,6 @@ static u16 w83627ehf_read_value(struct w83627ehf_data *data, u16 reg)
 {
 	int res, word_sized = is_word_sized(reg);
 
-	mutex_lock(&data->lock);
-
 	w83627ehf_set_bank(data, reg);
 	outb_p(reg & 0xff, data->addr + ADDR_REG_OFFSET);
 	res = inb_p(data->addr + DATA_REG_OFFSET);
@@ -548,8 +545,6 @@ static u16 w83627ehf_read_value(struct w83627ehf_data *data, u16 reg)
 		       data->addr + ADDR_REG_OFFSET);
 		res = (res << 8) + inb_p(data->addr + DATA_REG_OFFSET);
 	}
-
-	mutex_unlock(&data->lock);
 	return res;
 }
 
@@ -558,8 +553,6 @@ static int w83627ehf_write_value(struct w83627ehf_data *data, u16 reg,
 {
 	int word_sized = is_word_sized(reg);
 
-	mutex_lock(&data->lock);
-
 	w83627ehf_set_bank(data, reg);
 	outb_p(reg & 0xff, data->addr + ADDR_REG_OFFSET);
 	if (word_sized) {
@@ -568,8 +561,6 @@ static int w83627ehf_write_value(struct w83627ehf_data *data, u16 reg,
 		       data->addr + ADDR_REG_OFFSET);
 	}
 	outb_p(value & 0xff, data->addr + DATA_REG_OFFSET);
-
-	mutex_unlock(&data->lock);
 	return 0;
 }
 
@@ -2094,7 +2085,6 @@ static int w83627ehf_probe(struct platform_device *pdev)
 	}
 
 	data->addr = res->start;
-	mutex_init(&data->lock);
 	mutex_init(&data->update_lock);
 	data->name = w83627ehf_device_names[sio_data->kind];
 	data->bank = 0xff;		/* Force initial bank selection */
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
