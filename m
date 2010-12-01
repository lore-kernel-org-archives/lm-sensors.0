From: Gabriele Gorla <gorlik@penguintown.net>
Date: Wed, 01 Dec 2010 00:54:12 +0000
Subject: [lm-sensors] [PATCH] adm1026: allow 1 as a valid divider value
Message-Id: <20101201005412.GC30973@penguintown.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Allow 1 as a valid div value as specified in the adm1026 datasheet.

Signed-off-by: Gabriele Gorla <gorlik at penguintown.net>
---

diff -r -U 5 linux-source-2.6.26_orig/drivers/hwmon/adm1026.c linux-source-2.6.26/drivers/hwmon/adm1026.c
--- linux-source-2.6.26_orig/drivers/hwmon/adm1026.c	2008-07-13 14:51:29.000000000 -0700
+++ linux-source-2.6.26/drivers/hwmon/adm1026.c	2010-11-30 16:43:08.000000000 -0800
@@ -922,13 +922,10 @@
 	struct adm1026_data *data = i2c_get_clientdata(client);
 	int val, orig_div, new_div, shift;
 
 	val = simple_strtol(buf, NULL, 10);
 	new_div = DIV_TO_REG(val);
-	if (new_div = 0) {
-		return -EINVAL;
-	}
 	mutex_lock(&data->update_lock);
 	orig_div = data->fan_div[nr];
 	data->fan_div[nr] = DIV_FROM_REG(new_div);
 
 	if (nr < 4) { /* 0 <= nr < 4 */

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
