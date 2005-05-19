From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: [PATCH] I2C update for 2.6.5
Message-Id: <1081981453446@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10819814531232@kroah.com>
References: <10819814492866@kroah.com>
In-Reply-To: <10819814492866@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1643.36.26, 2004/04/12 15:16:36-07:00, khali@linux-fr.org

[PATCH] I2C: make I2C chip drivers return -EINVAL on error


 drivers/i2c/chips/fscher.c  |    2 +-
 drivers/i2c/chips/it87.c    |    2 +-
 drivers/i2c/chips/pcf8591.c |    3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/chips/fscher.c b/drivers/i2c/chips/fscher.c
--- a/drivers/i2c/chips/fscher.c	Wed Apr 14 15:12:39 2004
+++ b/drivers/i2c/chips/fscher.c	Wed Apr 14 15:12:39 2004
@@ -512,7 +512,7 @@
 	default:
 		dev_err(&client->dev, "fan_div value %ld not "
 			 "supported. Choose one of 2, 4 or 8!\n", v);
-		return -1;
+		return -EINVAL;
 	}
 
 	/* bits 2..7 reserved => mask with 0x03 */
diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Wed Apr 14 15:12:39 2004
+++ b/drivers/i2c/chips/it87.c	Wed Apr 14 15:12:39 2004
@@ -367,7 +367,7 @@
 	else if (val = 2)
 	    data->sensor |= 8 << nr;
 	else if (val != 0)
-		return -1;
+		return -EINVAL;
 	it87_write_value(client, IT87_REG_TEMP_ENABLE, data->sensor);
 	return count;
 }
diff -Nru a/drivers/i2c/chips/pcf8591.c b/drivers/i2c/chips/pcf8591.c
--- a/drivers/i2c/chips/pcf8591.c	Wed Apr 14 15:12:39 2004
+++ b/drivers/i2c/chips/pcf8591.c	Wed Apr 14 15:12:39 2004
@@ -129,8 +129,9 @@
 	if ((value = (simple_strtoul(buf, NULL, 10) + 5) / 10) <= 255) {
 		data->aout = value;
 		i2c_smbus_write_byte_data(client, data->control, data->aout);
+		return count;
 	}
-	return count;
+	return -EINVAL;
 }
 
 static DEVICE_ATTR(out0_output, S_IWUSR | S_IRUGO, 

