From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:48 +0000
Subject: [lm-sensors] [PATCH 54/82] hwmon: (s3c-hwmon) Fix multi-line comments
Message-Id: <1327017376-20466-55-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/s3c-hwmon.c |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/s3c-hwmon.c b/drivers/hwmon/s3c-hwmon.c
index f6c26d1..55bd49b 100644
--- a/drivers/hwmon/s3c-hwmon.c
+++ b/drivers/hwmon/s3c-hwmon.c
@@ -1,4 +1,5 @@
-/* linux/drivers/hwmon/s3c-hwmon.c
+/*
+ * linux/drivers/hwmon/s3c-hwmon.c
  *
  * Copyright (C) 2005, 2008, 2009 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
@@ -18,7 +19,7 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-*/
+ */
 
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -43,13 +44,13 @@ struct s3c_hwmon_attr {
 	char				label_name[12];
 };
 
-/**
+/*
  * struct s3c_hwmon - ADC hwmon client information
  * @lock: Access lock to serialise the conversions.
  * @client: The client we registered with the S3C ADC core.
  * @hwmon_dev: The hwmon device we created.
  * @attr: The holders for the channel attributes.
-*/
+ */
 struct s3c_hwmon {
 	struct mutex		lock;
 	struct s3c_adc_client	*client;
@@ -58,7 +59,7 @@ struct s3c_hwmon {
 	struct s3c_hwmon_attr	attrs[8];
 };
 
-/**
+/*
  * s3c_hwmon_read_ch - read a value from a given adc channel.
  * @dev: The device.
  * @hwmon: Our state.
@@ -86,7 +87,7 @@ static int s3c_hwmon_read_ch(struct device *dev,
 }
 
 #ifdef CONFIG_SENSORS_S3C_RAW
-/**
+/*
  * s3c_hwmon_show_raw - show a conversion from the raw channel number.
  * @dev: The device that the attribute belongs to.
  * @attr: The attribute being read.
@@ -153,7 +154,7 @@ static inline void s3c_hwmon_remove_raw(struct device *dev) { }
 
 #endif /* CONFIG_SENSORS_S3C_RAW */
 
-/**
+/*
  * s3c_hwmon_ch_show - show value of a given channel
  * @dev: The device that the attribute belongs to.
  * @attr: The attribute being read.
@@ -185,7 +186,7 @@ static ssize_t s3c_hwmon_ch_show(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%d\n", ret);
 }
 
-/**
+/*
  * s3c_hwmon_label_show - show label name of the given channel.
  * @dev: The device that the attribute belongs to.
  * @attr: The attribute being read.
@@ -206,7 +207,7 @@ static ssize_t s3c_hwmon_label_show(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%s\n", cfg->name);
 }
 
-/**
+/*
  * s3c_hwmon_create_attr - create hwmon attribute for given channel.
  * @dev: The device to create the attribute on.
  * @cfg: The channel configuration passed from the platform data.
@@ -272,10 +273,10 @@ static void s3c_hwmon_remove_attr(struct device *dev,
 	device_remove_file(dev, &attrs->label.dev_attr);
 }
 
-/**
+/*
  * s3c_hwmon_probe - device probe entry.
  * @dev: The device being probed.
-*/
+ */
 static int __devinit s3c_hwmon_probe(struct platform_device *dev)
 {
 	struct s3c_hwmon_pdata *pdata = dev->dev.platform_data;
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
