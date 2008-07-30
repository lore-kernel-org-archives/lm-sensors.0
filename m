From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Wed, 30 Jul 2008 22:14:24 +0000
Subject: [lm-sensors] [PATCH] i5k_amb: Provide labels for temperature sensors
Message-Id: <20080730221424.GE28331@tree.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors <lm-sensors@lm-sensors.org>, "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>

Export the sensor -> channel/dimm mapping in tempX_label.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/hwmon/i5k_amb.c |   28 +++++++++++++++++++++++++++-
 1 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_amb.c
index f9e2ed6..2ede938 100644
--- a/drivers/hwmon/i5k_amb.c
+++ b/drivers/hwmon/i5k_amb.c
@@ -81,6 +81,8 @@ static unsigned long amb_reg_temp(unsigned int amb)
 #define MAX_AMBS_PER_CHANNEL		16
 #define MAX_AMBS			(MAX_MEM_CHANNELS * \
 					 MAX_AMBS_PER_CHANNEL)
+#define CHANNEL_SHIFT			4
+#define DIMM_MASK			0xF
 /*
  * Ugly hack: For some reason the highest bit is set if there
  * are _any_ DIMMs in the channel.  Attempting to read from
@@ -89,7 +91,7 @@ static unsigned long amb_reg_temp(unsigned int amb)
  * might prevent us from seeing the 16th DIMM in the channel.
  */
 #define REAL_MAX_AMBS_PER_CHANNEL	15
-#define KNOBS_PER_AMB			5
+#define KNOBS_PER_AMB			6
 
 static unsigned long amb_num_from_reg(unsigned int byte_num, unsigned int bit)
 {
@@ -238,6 +240,16 @@ static ssize_t show_amb_temp(struct device *dev,
 		500 * amb_read_byte(data, amb_reg_temp(attr->index)));
 }
 
+static ssize_t show_label(struct device *dev,
+			  struct device_attribute *devattr,
+			  char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+
+	return sprintf(buf, "Ch. %d DIMM %d\n", attr->index >> CHANNEL_SHIFT,
+		       attr->index & DIMM_MASK);
+}
+
 static int __devinit i5k_amb_hwmon_init(struct platform_device *pdev)
 {
 	int i, j, k, d = 0;
@@ -268,6 +280,20 @@ static int __devinit i5k_amb_hwmon_init(struct platform_device *pdev)
 				continue;
 			d++;
 
+			/* sysfs label */
+			iattr = data->attrs + data->num_attrs;
+			snprintf(iattr->name, AMB_SYSFS_NAME_LEN,
+				 "temp%d_label", d);
+			iattr->s_attr.dev_attr.attr.name = iattr->name;
+			iattr->s_attr.dev_attr.attr.mode = S_IRUGO;
+			iattr->s_attr.dev_attr.show = show_label;
+			iattr->s_attr.index = k;
+			res = device_create_file(&pdev->dev,
+						 &iattr->s_attr.dev_attr);
+			if (res)
+				goto exit_remove;
+			data->num_attrs++;
+
 			/* Temperature sysfs knob */
 			iattr = data->attrs + data->num_attrs;
 			snprintf(iattr->name, AMB_SYSFS_NAME_LEN,

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
