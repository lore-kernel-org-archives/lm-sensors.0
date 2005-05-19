From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: [PATCH 2.6] Drop out-of-date code in w83781d and w83627hf
Message-Id: <20040619193753.52b353dd.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Here is a simple patch which drops some out-of-date code in the w83781d
and w83627hf i2c chip drivers. These bits are left over from the times
when chip drivers were setting default limits at init.

Should apply cleanly against your current tree.

Please apply,
Thanks.

Signed-off-by: Jean Delvare <khali at linux-fr dot org>

diff -ruN linux-2.6.7/drivers/i2c/chips.orig/w83627hf.c linux-2.6.7/drivers/i2c/chips/w83627hf.c
--- linux-2.6.7/drivers/i2c/chips.orig/w83627hf.c	Sat Jun 19 11:44:43 2004
+++ linux-2.6.7/drivers/i2c/chips/w83627hf.c	Sat Jun 19 18:21:06 2004
@@ -1240,7 +1240,7 @@
 static void w83627hf_init_client(struct i2c_client *client)
 {
 	struct w83627hf_data *data = i2c_get_clientdata(client);
-	int vid = 0, i;
+	int i;
 	int type = data->type;
 	u8 tmp;
 
@@ -1283,9 +1283,6 @@
 		/* Convert VID to voltage based on default VRM */
 		data->vrm = DEFAULT_VRM;
 	}
-
-	if (type != w83697hf)
-		vid = vid_from_reg(vid, data->vrm);
 
 	tmp = w83627hf_read_value(client, W83781D_REG_SCFG1);
 	for (i = 1; i <= 3; i++) {
diff -ruN linux-2.6.7/drivers/i2c/chips.orig/w83781d.c linux-2.6.7/drivers/i2c/chips/w83781d.c
--- linux-2.6.7/drivers/i2c/chips.orig/w83781d.c	Sat Jun 19 11:42:05 2004
+++ linux-2.6.7/drivers/i2c/chips/w83781d.c	Sat Jun 19 18:22:05 2004
@@ -1491,7 +1491,7 @@
 w83781d_init_client(struct i2c_client *client)
 {
 	struct w83781d_data *data = i2c_get_clientdata(client);
-	int vid = 0, i, p;
+	int i, p;
 	int type = data->type;
 	u8 tmp;
 
@@ -1513,14 +1513,7 @@
 		w83781d_write_value(client, W83781D_REG_BEEP_INTS2, 0);
 	}
 
-	if (type != w83697hf) {
-		vid = w83781d_read_value(client, W83781D_REG_VID_FANDIV) & 0x0f;
-		vid |-		    (w83781d_read_value(client, W83781D_REG_CHIPID) & 0x01) <<
-		    4;
-		data->vrm = DEFAULT_VRM;
-		vid = vid_from_reg(vid, data->vrm);
-	}
+	data->vrm = 82;
 
 	if ((type != w83781d) && (type != as99127f)) {
 		tmp = w83781d_read_value(client, W83781D_REG_SCFG1);


-- 
Jean Delvare
http://khali.linux-fr.org/
