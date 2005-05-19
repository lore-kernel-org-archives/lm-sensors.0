From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:53 +0000
Subject: [PATCH] i2c driver changes for 2.5.67
Message-Id: <10499274991641@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10499274991425@kroah.com>
References: <10499274993464@kroah.com>
In-Reply-To: <10499274993464@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1133.1.2, 2003/04/08 02:48:29-07:00, kraxel@bytesex.org

[PATCH] i2c: add i2c_clientname()

This patch just adds a #define and a inline function to hide the
"i2c_client->name" => "i2c_client->dev.name" move introduced by
the recent i2c updates.  That makes it easier to build i2c drivers
on both 2.4 and 2.5 kernels.


 include/linux/i2c.h |    7 +++++++
 1 files changed, 7 insertions(+)


diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	Wed Apr  9 15:16:15 2003
+++ b/include/linux/i2c.h	Wed Apr  9 15:16:15 2003
@@ -182,6 +182,13 @@
 	return dev_set_drvdata (&dev->dev, data);
 }
 
+#define I2C_DEVNAME(str)   .dev = { .name = str }
+
+static inline char *i2c_clientname(struct i2c_client *c)
+{
+	return c->dev.name;
+}
+
 /*
  * The following structs are for those who like to implement new bus drivers:
  * i2c_algorithm is the interface to a class of hardware solutions which can

