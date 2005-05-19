From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: [PATCH] I2C fixes for 2.6.10-rc1
Message-Id: <11003020051927@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11003020053782@kroah.com>
References: <11003020053782@kroah.com>
In-Reply-To: <11003020053782@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.2095, 2004/11/12 13:20:15-08:00, khali@linux-fr.org

[PATCH] I2C: Missing newlines in debug messages

As discussed on IRC, this simple patch fixes broken debug messages
missing their trailing newlines. I just applied something similar to
CVS, and will prepare patches for 2.4 as well.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/i2c-core.c          |    2 +-
 drivers/i2c/i2c-dev.c           |    2 +-
 drivers/i2c/i2c-sensor-detect.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	2004-11-12 15:22:38 -08:00
+++ b/drivers/i2c/i2c-core.c	2004-11-12 15:22:38 -08:00
@@ -760,7 +760,7 @@
 			if (addr = address_data->normal_i2c[i]) {
 				found = 1;
 				dev_dbg(&adapter->dev, "found normal i2c entry for adapter %d, "
-					"addr %02x", adap_id,addr);
+					"addr %02x\n", adap_id, addr);
 			}
 		}
 
diff -Nru a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c	2004-11-12 15:22:38 -08:00
+++ b/drivers/i2c/i2c-dev.c	2004-11-12 15:22:38 -08:00
@@ -539,7 +539,7 @@
 out_unreg_chrdev:
 	unregister_chrdev(I2C_MAJOR, "i2c");
 out:
-	printk(KERN_ERR "%s: Driver Initialisation failed", __FILE__);
+	printk(KERN_ERR "%s: Driver Initialisation failed\n", __FILE__);
 	return res;
 }
 
diff -Nru a/drivers/i2c/i2c-sensor-detect.c b/drivers/i2c/i2c-sensor-detect.c
--- a/drivers/i2c/i2c-sensor-detect.c	2004-11-12 15:22:38 -08:00
+++ b/drivers/i2c/i2c-sensor-detect.c	2004-11-12 15:22:38 -08:00
@@ -115,7 +115,7 @@
 			for (i = 0; !found && (normal_i2c[i] != I2C_CLIENT_END); i += 1) {
 				if (addr = normal_i2c[i]) {
 					found = 1;
-					dev_dbg(&adapter->dev, "found normal i2c entry for adapter %d, addr %02x", adapter_id, addr);
+					dev_dbg(&adapter->dev, "found normal i2c entry for adapter %d, addr %02x\n", adapter_id, addr);
 				}
 			}
 		}

