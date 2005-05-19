From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: [lm-sensors] [PATCH 2.6] I2C: driver adm1026: remove die_code
Message-Id: <pf6j81hp8gaijtobuf0mtdthcs9pnre3dg@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <136j81devb8mhap9muu2adh3o2t09jehg3@4ax.com>
In-Reply-To: <136j81devb8mhap9muu2adh3o2t09jehg3@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch removes die_code from adm1021 as nothing within the 
driver uses it.  Compile tested, this time with the patch, sorry.

--Grant.


Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 adm1021.c |    8 --------
 1 files changed, 8 deletions(-)

--- linux-2.6.12-rc4-mm2/drivers/i2c/chips/adm1021.c	2005-05-17 13:00:24.000000000 +1000
+++ linux-2.6.12-rc4-mm2a/drivers/i2c/chips/adm1021.c	2005-05-17 17:04:26.000000000 +1000
@@ -102,8 +102,6 @@
 	u8	remote_temp_hyst;
 	u8	remote_temp_input;
 	u8	alarms;
-	/* special values for ADM1021 only */
-	u8	die_code;
         /* Special values for ADM1023 only */
 	u8	remote_temp_prec;
 	u8	remote_temp_os_prec;
@@ -155,7 +153,6 @@
 	return sprintf(buf, "%d\n", data->value);			\
 }
 show2(alarms);
-show2(die_code);
 
 #define set(value, reg)	\
 static ssize_t set_##value(struct device *dev, const char *buf, size_t count)	\
@@ -182,7 +179,6 @@
 static DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO, show_remote_temp_hyst, set_remote_temp_hyst);
 static DEVICE_ATTR(temp2_input, S_IRUGO, show_remote_temp_input, NULL);
 static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
-static DEVICE_ATTR(die_code, S_IRUGO, show_die_code, NULL);
 
 
 static int adm1021_attach_adapter(struct i2c_adapter *adapter)
@@ -306,8 +302,6 @@
 	device_create_file(&new_client->dev, &dev_attr_temp2_min);
 	device_create_file(&new_client->dev, &dev_attr_temp2_input);
 	device_create_file(&new_client->dev, &dev_attr_alarms);
-	if (data->type = adm1021)
-		device_create_file(&new_client->dev, &dev_attr_die_code);
 
 	return 0;
 
@@ -370,8 +364,6 @@
 		data->remote_temp_max = adm1021_read_value(client, ADM1021_REG_REMOTE_TOS_R);
 		data->remote_temp_hyst = adm1021_read_value(client, ADM1021_REG_REMOTE_THYST_R);
 		data->alarms = adm1021_read_value(client, ADM1021_REG_STATUS) & 0x7c;
-		if (data->type = adm1021)
-			data->die_code = adm1021_read_value(client, ADM1021_REG_DIE_CODE);
 		if (data->type = adm1023) {
 			data->remote_temp_prec = adm1021_read_value(client, ADM1021_REG_REM_TEMP_PREC);
 			data->remote_temp_os_prec = adm1021_read_value(client, ADM1021_REG_REM_TOS_PREC);

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
