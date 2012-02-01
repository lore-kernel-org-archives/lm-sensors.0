From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 01 Feb 2012 19:11:05 +0000
Subject: [lm-sensors] [PATCH 17/24] hwmon: (w83627ehf) Drop vrm attribute, and make cpu0_vid conditional
Message-Id: <1328123472-27816-18-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

vrm is now maintained in hwmon-vid, no need to keep a local copy.
Only create the cpu0_vid attribute if vrm is valid.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83627ehf.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index b11306c..8893707 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -494,7 +494,6 @@ struct w83627ehf_data {
 	u8 fan_step_output[4]; /* rate of change output value */
 
 	u8 vid;
-	u8 vrm;
 
 	u16 have_temp;
 	u8 in6_skip:1;
@@ -1699,11 +1698,10 @@ static ssize_t
 show_vid(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct w83627ehf_data *data = dev_get_drvdata(dev);
-	return sprintf(buf, "%d\n", vid_from_reg(data->vid, data->vrm));
+	return sprintf(buf, "%d\n", vid_from_reg(data->vid));
 }
 static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid, NULL);
 
-
 /* Case open detection */
 
 static ssize_t
@@ -2290,10 +2288,11 @@ static int __devinit w83627ehf_probe(struct platform_device *pdev)
 	/* Initialize the chip */
 	w83627ehf_init_device(data, sio_data->kind);
 
-	data->vrm = vid_which_vrm();
 	superio_enter(sio_data->sioreg);
 	/* Read VID value */
-	if (sio_data->kind = w83667hg || sio_data->kind = w83667hg_b ||
+	if (vid_which_vrm() = 0) {
+		/* vrm not set, nothing to do */
+	} else if (sio_data->kind = w83667hg || sio_data->kind = w83667hg_b ||
 	    sio_data->kind = nct6775 || sio_data->kind = nct6776) {
 		/*
 		 * W83667HG has different pins for VID input and output, so
@@ -2316,16 +2315,17 @@ static int __devinit w83627ehf_probe(struct platform_device *pdev)
 			 * respect.
 			 */
 			if (sio_data->kind = w83627ehf) {
+				u8 vrm = vid_which_vrm();
+
 				en_vrm10 = superio_inb(sio_data->sioreg,
 						       SIO_REG_EN_VRM10);
-				if ((en_vrm10 & 0x08) && data->vrm = 90) {
+				if ((en_vrm10 & 0x08) && vrm = 90) {
 					dev_warn(dev, "Setting VID input "
 						 "voltage to TTL\n");
 					superio_outb(sio_data->sioreg,
 						     SIO_REG_EN_VRM10,
 						     en_vrm10 & ~0x08);
-				} else if (!(en_vrm10 & 0x08)
-					   && data->vrm = 100) {
+				} else if (!(en_vrm10 & 0x08) && vrm >= 100) {
 					dev_warn(dev, "Setting VID input "
 						 "voltage to VRM10\n");
 					superio_outb(sio_data->sioreg,
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
