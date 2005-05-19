From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: [PATCH 2.6] I2C: Missing newlines in debug messages
Message-Id: <20041109210252.6cc251bb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

As discussed on IRC, this simple patch fixes broken debug messages
missing their trailing newlines. I just applied something similar to
CVS, and will prepare patches for 2.4 as well.

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

diff -ruN linux-2.6.10-rc1-bk19/drivers/i2c.orig/i2c-core.c linux-2.6.10-rc1-bk19/drivers/i2c/i2c-core.c
--- linux-2.6.10-rc1-bk19/drivers/i2c.orig/i2c-core.c	2004-11-09 19:33:36.000000000 +0100
+++ linux-2.6.10-rc1-bk19/drivers/i2c/i2c-core.c	2004-11-09 20:41:06.000000000 +0100
@@ -760,7 +760,7 @@
 			if (addr = address_data->normal_i2c[i]) {
 				found = 1;
 				dev_dbg(&adapter->dev, "found normal i2c entry for adapter %d, "
-					"addr %02x", adap_id,addr);
+					"addr %02x\n", adap_id, addr);
 			}
 		}
 
diff -ruN linux-2.6.10-rc1-bk19/drivers/i2c.orig/i2c-dev.c linux-2.6.10-rc1-bk19/drivers/i2c/i2c-dev.c
--- linux-2.6.10-rc1-bk19/drivers/i2c.orig/i2c-dev.c	2004-08-24 18:42:40.000000000 +0200
+++ linux-2.6.10-rc1-bk19/drivers/i2c/i2c-dev.c	2004-11-09 20:47:26.000000000 +0100
@@ -539,7 +539,7 @@
 out_unreg_chrdev:
 	unregister_chrdev(I2C_MAJOR, "i2c");
 out:
-	printk(KERN_ERR "%s: Driver Initialisation failed", __FILE__);
+	printk(KERN_ERR "%s: Driver Initialisation failed\n", __FILE__);
 	return res;
 }
 
diff -ruN linux-2.6.10-rc1-bk19/drivers/i2c.orig/i2c-sensor-detect.c linux-2.6.10-rc1-bk19/drivers/i2c/i2c-sensor-detect.c
--- linux-2.6.10-rc1-bk19/drivers/i2c.orig/i2c-sensor-detect.c	2004-11-09 19:33:36.000000000 +0100
+++ linux-2.6.10-rc1-bk19/drivers/i2c/i2c-sensor-detect.c	2004-11-09 20:40:42.000000000 +0100
@@ -115,7 +115,7 @@
 			for (i = 0; !found && (normal_i2c[i] != I2C_CLIENT_END); i += 1) {
 				if (addr = normal_i2c[i]) {
 					found = 1;
-					dev_dbg(&adapter->dev, "found normal i2c entry for adapter %d, addr %02x", adapter_id, addr);
+					dev_dbg(&adapter->dev, "found normal i2c entry for adapter %d, addr %02x\n", adapter_id, addr);
 				}
 			}
 		}


-- 
Jean Delvare
http://khali.linux-fr.org/
