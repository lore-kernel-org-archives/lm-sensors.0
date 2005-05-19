From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [PATCH 2.6] Fix bugs in the new w83627ehf driver
Message-Id: <20050502230822.14db6bc3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

These are the fixes for the bugs you spotted in my new w83627ehf driver:
1* w83627ehf_detect should be declared static.
2* Explicit division by 0.

I'm very sorry for introducing them in the first place, especially the
second one. I'm glad you spotted them, thanks a lot.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

Index: linux-2.6.12-rc3/drivers/i2c/chips/w83627ehf.c
=================================--- linux-2.6.12-rc3.orig/drivers/i2c/chips/w83627ehf.c	2005-04-25 22:36:11.000000000 +0200
+++ linux-2.6.12-rc3/drivers/i2c/chips/w83627ehf.c	2005-05-02 23:02:07.000000000 +0200
@@ -450,7 +450,7 @@
 		data->fan_min[nr] = 1;
 		new_div = 0; /* 1 = (1 << 0) */
 		dev_warn(dev, "fan%u low limit %u above maximum %u, set to "
-			 "maximum\n", nr + 1, val, fan_from_reg(1, 0));
+			 "maximum\n", nr + 1, val, fan_from_reg(1, 1));
 	} else {
 		/* Automatically pick the best divider, i.e. the one such
 		   that the min limit will correspond to a register value
@@ -659,7 +659,7 @@
 	}
 }
 
-int w83627ehf_detect(struct i2c_adapter *adapter, int address, int kind)
+static int w83627ehf_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *client;
 	struct w83627ehf_data *data;


-- 
Jean Delvare
