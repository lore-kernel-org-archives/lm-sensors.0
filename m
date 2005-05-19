From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: [PATCH] More i2c driver fixes for 2.6.0-test7
Message-Id: <10662411472283@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10662411473410@kroah.com>
References: <1064526609700@kroah.com>
In-Reply-To: <1064526609700@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1347.1.2, 2003/10/13 12:31:27-07:00, kronos@kronoz.cjb.net

[PATCH] I2C: sensors/w83781d.c creates useless sysfs entries

Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz> ha scritto:
> here is a trivial fix for Winbond sensor driver, which currently creates
> useless entries in sys/bus/i2c due to missing braces after if statements
> - author probably forgot about the macro expansion.

IMHO it's better to fix the macro:


 drivers/i2c/chips/w83781d.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)


diff -Nru a/drivers/i2c/chips/w83781d.c b/drivers/i2c/chips/w83781d.c
--- a/drivers/i2c/chips/w83781d.c	Wed Oct 15 10:57:59 2003
+++ b/drivers/i2c/chips/w83781d.c	Wed Oct 15 10:57:59 2003
@@ -422,9 +422,11 @@
 sysfs_in_offsets(8);
 
 #define device_create_file_in(client, offset) \
+do { \
 device_create_file(&client->dev, &dev_attr_in_input##offset); \
 device_create_file(&client->dev, &dev_attr_in_min##offset); \
-device_create_file(&client->dev, &dev_attr_in_max##offset);
+device_create_file(&client->dev, &dev_attr_in_max##offset); \
+} while (0);
 
 #define show_fan_reg(reg) \
 static ssize_t show_##reg (struct device *dev, char *buf, int nr) \

