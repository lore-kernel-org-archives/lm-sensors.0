From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 14 Mar 2013 16:42:02 +0000
Subject: [lm-sensors] [PATCH] hwmon: (nct6775) Drop read/write lock
Message-Id: <1363279322-10518-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The read/write lock is acquired for each read/write operation from/to the chip.
This occurs either during initialization, when it is not needed, or during
updates, when the update_lock is held as well, and it is not needed either.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
This patch applies on top of the other patches introducing the new
nct6775 driver.

 drivers/hwmon/nct6775.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 2f30991..896f231 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -554,7 +554,6 @@ struct nct6775_data {
 	const char *name;
 
 	struct device *hwmon_dev;
-	struct mutex lock;
 
 	u16 reg_temp[4][NUM_TEMP]; /* 0=temp, 1=temp_over, 2=temp_hyst,
 				    * 3=temp_crit
@@ -745,8 +744,6 @@ static u16 nct6775_read_value(struct nct6775_data *data, u16 reg)
 {
 	int res, word_sized = is_word_sized(data, reg);
 
-	mutex_lock(&data->lock);
-
 	nct6775_set_bank(data, reg);
 	outb_p(reg & 0xff, data->addr + ADDR_REG_OFFSET);
 	res = inb_p(data->addr + DATA_REG_OFFSET);
@@ -755,8 +752,6 @@ static u16 nct6775_read_value(struct nct6775_data *data, u16 reg)
 		       data->addr + ADDR_REG_OFFSET);
 		res = (res << 8) + inb_p(data->addr + DATA_REG_OFFSET);
 	}
-
-	mutex_unlock(&data->lock);
 	return res;
 }
 
@@ -764,8 +759,6 @@ static int nct6775_write_value(struct nct6775_data *data, u16 reg, u16 value)
 {
 	int word_sized = is_word_sized(data, reg);
 
-	mutex_lock(&data->lock);
-
 	nct6775_set_bank(data, reg);
 	outb_p(reg & 0xff, data->addr + ADDR_REG_OFFSET);
 	if (word_sized) {
@@ -774,8 +767,6 @@ static int nct6775_write_value(struct nct6775_data *data, u16 reg, u16 value)
 		       data->addr + ADDR_REG_OFFSET);
 	}
 	outb_p(value & 0xff, data->addr + DATA_REG_OFFSET);
-
-	mutex_unlock(&data->lock);
 	return 0;
 }
 
@@ -3416,7 +3407,6 @@ static int nct6775_probe(struct platform_device *pdev)
 
 	data->kind = sio_data->kind;
 	data->addr = res->start;
-	mutex_init(&data->lock);
 	mutex_init(&data->update_lock);
 	data->name = nct6775_device_names[data->kind];
 	data->bank = 0xff;		/* Force initial bank selection */
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
