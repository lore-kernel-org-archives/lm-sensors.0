From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 14 Mar 2013 00:02:42 +0000
Subject: [lm-sensors] [PATCH 2/4] hwmon: (w83627hf) Drop read/write lock
Message-Id: <1363219364-5221-3-git-send-email-linux@roeck-us.net>
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
 drivers/hwmon/w83627hf.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index 83f674a..4ec5692 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -359,7 +359,6 @@ struct w83627hf_data {
 	unsigned short addr;
 	const char *name;
 	struct device *hwmon_dev;
-	struct mutex lock;
 	enum chips type;
 
 	struct mutex update_lock;
@@ -1458,7 +1457,6 @@ static int w83627hf_probe(struct platform_device *pdev)
 	data->addr = res->start;
 	data->type = sio_data->type;
 	data->name = names[sio_data->type];
-	mutex_init(&data->lock);
 	mutex_init(&data->update_lock);
 	platform_set_drvdata(pdev, data);
 
@@ -1624,11 +1622,11 @@ static inline void w83627hf_reset_bank(struct w83627hf_data *data, u16 reg)
 	}
 }
 
+/* Caller must hold update_lock except if called during initialization */
 static int w83627hf_read_value(struct w83627hf_data *data, u16 reg)
 {
 	int res, word_sized;
 
-	mutex_lock(&data->lock);
 	word_sized = (((reg & 0xff00) = 0x100)
 		   || ((reg & 0xff00) = 0x200))
 		  && (((reg & 0x00ff) = 0x50)
@@ -1645,7 +1643,6 @@ static int w83627hf_read_value(struct w83627hf_data *data, u16 reg)
 				       W83781D_DATA_REG_OFFSET);
 	}
 	w83627hf_reset_bank(data, reg);
-	mutex_unlock(&data->lock);
 	return res;
 }
 
@@ -1710,11 +1707,11 @@ exit:
 	return res;
 }
 
+/* Caller must hold update_lock except if called during initialization */
 static int w83627hf_write_value(struct w83627hf_data *data, u16 reg, u16 value)
 {
 	int word_sized;
 
-	mutex_lock(&data->lock);
 	word_sized = (((reg & 0xff00) = 0x100)
 		   || ((reg & 0xff00) = 0x200))
 		  && (((reg & 0x00ff) = 0x53)
@@ -1730,7 +1727,6 @@ static int w83627hf_write_value(struct w83627hf_data *data, u16 reg, u16 value)
 	outb_p(value & 0xff,
 	       data->addr + W83781D_DATA_REG_OFFSET);
 	w83627hf_reset_bank(data, reg);
-	mutex_unlock(&data->lock);
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
