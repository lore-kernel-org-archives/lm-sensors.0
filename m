From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 20 Oct 2008 12:47:56 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (lm90) Fix handling of hysteresis
Message-Id: <20081020144756.03248432@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

There are several problems in the way the hysteresis value is handled
by the lm90 driver:

* In show_temphyst(), specific handling of the MAX6646 is missing, so
  the hysteresis is reported incorrectly if the critical temperature
  is over 127 degrees C.
* In set_temphyst(), the new hysteresis register value is written to
  the chip but data->temp_hyst isn't updated accordingly, so there is
  a short period of time (up to 2 seconds) where the old hystereris
  value will be returned while the new one is already active.
* In set_temphyst(), the critical temperature which is used as a base
  to compute the value of the hysteresis register lacks
  device-specific handling. As a result, the value of the hysteresis
  register might be incorrect for the ADT7461 and MAX6646 chips.

Fix these 3 bugs.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Ben Hutchings <bhutchings@solarflare.com>
Cc: Nate Case <ncase@xes-inc.com>
---
Ben, Nate, can you please review and test this patch?

 drivers/hwmon/lm90.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- linux-2.6.28-rc0.orig/drivers/hwmon/lm90.c	2008-10-20 13:53:08.000000000 +0200
+++ linux-2.6.28-rc0/drivers/hwmon/lm90.c	2008-10-20 13:58:48.000000000 +0200
@@ -461,6 +461,8 @@ static ssize_t show_temphyst(struct devi
 
 	if (data->kind = adt7461)
 		temp = temp_from_u8_adt7461(data, data->temp8[attr->index]);
+	else if (data->kind = max6646)
+		temp = temp_from_u8(data->temp8[attr->index]);
 	else
 		temp = temp_from_s8(data->temp8[attr->index]);
 
@@ -473,12 +475,19 @@ static ssize_t set_temphyst(struct devic
 	struct i2c_client *client = to_i2c_client(dev);
 	struct lm90_data *data = i2c_get_clientdata(client);
 	long val = simple_strtol(buf, NULL, 10);
-	long hyst;
+	int temp;
 
 	mutex_lock(&data->update_lock);
-	hyst = temp_from_s8(data->temp8[2]) - val;
+	if (data->kind = adt7461)
+		temp = temp_from_u8_adt7461(data, data->temp8[2]);
+	else if (data->kind = max6646)
+		temp = temp_from_u8(data->temp8[2]);
+	else
+		temp = temp_from_s8(data->temp8[2]);
+
+	data->temp_hyst = hyst_to_reg(temp - val);
 	i2c_smbus_write_byte_data(client, LM90_REG_W_TCRIT_HYST,
-				  hyst_to_reg(hyst));
+				  data->temp_hyst);
 	mutex_unlock(&data->update_lock);
 	return count;
 }


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
