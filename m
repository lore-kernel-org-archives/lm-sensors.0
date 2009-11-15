From: =?UTF-8?B?w4lyaWMgUGllbA==?= <eric.piel@tremplin-utc.net>
Date: Sun, 15 Nov 2009 15:53:34 +0000
Subject: Re: [lm-sensors] [PATCH v2 04/10] lis3: fix show rate for 8 bits
Message-Id: <4B0023FE.90809@tremplin-utc.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1257856872-11612-1-git-send-email-samu.p.onkalo@nokia.com> <1257856872-11612-2-git-send-email-samu.p.onkalo@nokia.com> <1257856872-11612-3-git-send-email-samu.p.onkalo@nokia.com> <1257856872-11612-4-git-send-email-samu.p.onkalo@nokia.com> <1257856872-11612-5-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1257856872-11612-5-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Samu Onkalo <samu.p.onkalo@nokia.com>
Cc: daniel@caiaq.de, pavel@ucw.cz, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Kalhan Trisal <kalhan.trisal@intel.com>, Christoph Plattner <christoph.plattner@gmx.at>

Op 10-11-09 13:41, Samu Onkalo schreef:
> From: Éric Piel <eric.piel@tremplin-utc.net>
> 
> lis3: fix with 8 bits sensors
> 
Here is the same patch, but with a better log.

Eric
8<--------------------------------------------------------------
Subject: lis3: fixes for 8 bits chips

Originally the driver was only targeted to 12bits sensors. When support
for 8bits sensors was added, some slight difference in the registers
were overlooked. This should fix it, both for initialization, and for
displaying the rate.

Reported-by: Kalhan Trisal <kalhan.trisal@intel.com>
Reported-by: Christoph Plattner <christoph.plattner@gmx.at>
Tested-by: Christoph Plattner <christoph.plattner@gmx.at>
Tested-by: Samu Onkalo <samu.p.onkalo@nokia.com>
Signed-off-by: Éric Piel <eric.piel@tremplin-utc.net>
---
 drivers/hwmon/lis3lv02d.c |   24 ++++++++++++++++--------
 drivers/hwmon/lis3lv02d.h |    1 +
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/lis3lv02d.c b/drivers/hwmon/lis3lv02d.c
index 1c8f108..b12ee35 100644
--- a/drivers/hwmon/lis3lv02d.c
+++ b/drivers/hwmon/lis3lv02d.c
@@ -127,12 +127,14 @@ void lis3lv02d_poweron(struct lis3lv02d *lis3)
 
 	/*
 	 * Common configuration
-	 * BDU: LSB and MSB values are not updated until both have been read.
-	 *      So the value read will always be correct.
+	 * BDU: (12 bits sensors only) LSB and MSB values are not updated until
+	 *      both have been read. So the value read will always be correct.
 	 */
-	lis3->read(lis3, CTRL_REG2, &reg);
-	reg |= CTRL2_BDU;
-	lis3->write(lis3, CTRL_REG2, reg);
+	if (lis3->whoami =  WAI_12B) {
+		lis3->read(lis3, CTRL_REG2, &reg);
+		reg |= CTRL2_BDU;
+		lis3->write(lis3, CTRL_REG2, reg);
+	}
 }
 EXPORT_SYMBOL_GPL(lis3lv02d_poweron);
 
@@ -363,7 +365,8 @@ static ssize_t lis3lv02d_calibrate_store(struct device *dev,
 }
 
 /* conversion btw sampling rate and the register values */
-static int lis3lv02dl_df_val[4] = {40, 160, 640, 2560};
+static int lis3_12_rates[4] = {40, 160, 640, 2560};
+static int lis3_8_rates[2] = {100, 400};
 static ssize_t lis3lv02d_rate_show(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
@@ -371,8 +374,13 @@ static ssize_t lis3lv02d_rate_show(struct device *dev,
 	int val;
 
 	lis3_dev.read(&lis3_dev, CTRL_REG1, &ctrl);
-	val = (ctrl & (CTRL1_DF0 | CTRL1_DF1)) >> 4;
-	return sprintf(buf, "%d\n", lis3lv02dl_df_val[val]);
+
+	if (lis3_dev.whoami = WAI_12B)
+		val = lis3_12_rates[(ctrl & (CTRL1_DF0 | CTRL1_DF1)) >> 4];
+	else
+		val = lis3_8_rates[(ctrl & CTRL1_DR) >> 7];
+
+	return sprintf(buf, "%d\n", val);
 }
 
 static DEVICE_ATTR(position, S_IRUGO, lis3lv02d_position_show, NULL);
diff --git a/drivers/hwmon/lis3lv02d.h b/drivers/hwmon/lis3lv02d.h
index 2431c51..c6ae507 100644
--- a/drivers/hwmon/lis3lv02d.h
+++ b/drivers/hwmon/lis3lv02d.h
@@ -107,6 +107,7 @@ enum lis3lv02d_ctrl1 {
 	CTRL1_DF1	= 0x20,
 	CTRL1_PD0	= 0x40,
 	CTRL1_PD1	= 0x80,
+	CTRL1_DR	= 0x80, /* Data rate on 8 bits */
 };
 enum lis3lv02d_ctrl2 {
 	CTRL2_DAS	= 0x01,
-- 
1.6.5.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
