From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:07 +0000
Subject: [PATCH 2.6] I2C: Fix debug in w83781d driver
Message-Id: <20040731220947.7b9b0285.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

The trivial patch below fixes two debug prints in the w83781d driver
(one needless dereference and one debug print without device info).
Please apply.

Thanks.

Signed-off-by: Jean Delvare <khali at linux-fr dot org>

--- linux-2.6.8-rc2/drivers/i2c/chips/w83781d.c.orig	2004-07-31 21:22:51.000000000 +0200
+++ linux-2.6.8-rc2/drivers/i2c/chips/w83781d.c	2004-07-31 22:03:04.000000000 +0200
@@ -815,8 +815,7 @@
 		data->sens[nr - 1] = val;
 		break;
 	default:
-		dev_err(&client->dev,
-		       "Invalid sensor type %ld; must be 1, 2, or %d\n",
+		dev_err(dev, "Invalid sensor type %ld; must be 1, 2, or %d\n",
 		       (long) val, W83781D_DEFAULT_BETA);
 		break;
 	}
@@ -1593,7 +1592,7 @@
 	if (time_after
 	    (jiffies - data->last_updated, (unsigned long) (HZ + HZ / 2))
 	    || time_before(jiffies, data->last_updated) || !data->valid) {
-		pr_debug("Starting device update\n");
+		dev_dbg(dev, "Starting device update\n");
 
 		for (i = 0; i <= 8; i++) {
 			if ((data->type = w83783s || data->type = w83697hf)

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
