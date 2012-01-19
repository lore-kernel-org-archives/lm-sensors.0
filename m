From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:04 +0000
Subject: [lm-sensors] [PATCH 10/82] hwmon: (ads7871) Fix multi-line comments
Message-Id: <1327017376-20466-11-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ads7871.c |   26 +++++++++++++++++---------
 1 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/ads7871.c b/drivers/hwmon/ads7871.c
index 04450f8..3987ccd 100644
--- a/drivers/hwmon/ads7871.c
+++ b/drivers/hwmon/ads7871.c
@@ -34,9 +34,11 @@
 #define REG_SER_CONTROL 24 /*Serial Interface Control Register*/
 #define REG_ID		31 /*ID Register*/
 
-/*From figure 17 in the datasheet
-* These bits get ORed with the address to form
-* the instruction byte */
+/*
+ * From figure 17 in the datasheet
+ * These bits get ORed with the address to form
+ * the instruction byte
+ */
 /*Instruction Bit masks*/
 #define INST_MODE_bm	(1<<7)
 #define INST_READ_bm	(1<<6)
@@ -105,8 +107,10 @@ static ssize_t show_voltage(struct device *dev,
 	uint8_t channel, mux_cnv;
 
 	channel = attr->index;
-	/*TODO: add support for conversions
-	 *other than single ended with a gain of 1*/
+	/*
+	 * TODO: add support for conversions
+	 * other than single ended with a gain of 1
+	 */
 	/*MUX_M3_bm forces single ended*/
 	/*This is also where the gain of the PGA would be set*/
 	ads7871_write_reg8(spi, REG_GAIN_MUX,
@@ -114,8 +118,10 @@ static ssize_t show_voltage(struct device *dev,
 
 	ret = ads7871_read_reg8(spi, REG_GAIN_MUX);
 	mux_cnv = ((ret & MUX_CNV_bm)>>MUX_CNV_bv);
-	/*on 400MHz arm9 platform the conversion
-	 *is already done when we do this test*/
+	/*
+	 * on 400MHz arm9 platform the conversion
+	 * is already done when we do this test
+	 */
 	while ((i < 2) && mux_cnv) {
 		i++;
 		ret = ads7871_read_reg8(spi, REG_GAIN_MUX);
@@ -179,8 +185,10 @@ static int __devinit ads7871_probe(struct spi_device *spi)
 	ret = ads7871_read_reg8(spi, REG_OSC_CONTROL);
 
 	dev_dbg(&spi->dev, "REG_OSC_CONTROL write:%x, read:%x\n", val, ret);
-	/*because there is no other error checking on an SPI bus
-	we need to make sure we really have a chip*/
+	/*
+	 * because there is no other error checking on an SPI bus
+	 * we need to make sure we really have a chip
+	 */
 	if (val != ret) {
 		err = -ENODEV;
 		goto exit;
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
