From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 21 Nov 2005 19:21:36 +0000
Subject: [lm-sensors] [PATCH] hwmon: Fix missing it87 fan div init
Message-Id: <20051121192216.3a72d4c4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This one is for 2.6.15-rc3.

Thanks.

* * * * *

Fix a bug where setting the low fan speed limits will not work if no
data was ever read through the sysfs interface and the fan clock
dividers have not been explicitely set yet either. The reason is that
data->fan_div[nr] may currently be used before it is initialized from
the chip register values. The fix is to explicitely initialize
data->fan_div[nr] before using it.

Bug reported, and fix tested, by Nicolas Mailhot.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---

 drivers/hwmon/it87.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- linux-2.6.15-rc1.orig/drivers/hwmon/it87.c	2005-11-14 22:31:07.000000000 +0100
+++ linux-2.6.15-rc1/drivers/hwmon/it87.c	2005-11-15 19:17:33.000000000 +0100
@@ -522,8 +522,15 @@
 	struct i2c_client *client = to_i2c_client(dev);
 	struct it87_data *data = i2c_get_clientdata(client);
 	int val = simple_strtol(buf, NULL, 10);
+	u8 reg = it87_read_value(client, IT87_REG_FAN_DIV);
 
 	down(&data->update_lock);
+	switch (nr) {
+	case 0: data->fan_div[nr] = reg & 0x07; break;
+	case 1: data->fan_div[nr] = (reg >> 3) & 0x07; break;
+	case 2: data->fan_div[nr] = (reg & 0x40) ? 3 : 1; break;
+	}
+
 	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
 	it87_write_value(client, IT87_REG_FAN_MIN(nr), data->fan_min[nr]);
 	up(&data->update_lock);


-- 
Jean Delvare
