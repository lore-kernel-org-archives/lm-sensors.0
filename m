From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 04 Jun 2006 18:24:11 +0000
Subject: [lm-sensors] [PATCH 11/11] abituguru: Fix fan detection
Message-Id: <20060604202411.59d7dd3f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Hans de Goede <j.w.r.degoede at hhs.nl>
Content-Disposition: inline; filename=hwmon-abituguru-nofans-detect-fix.patch

One of my testers had a problem where the driver only saw 2 of the 4 fan
sensors his uGuru has, this fixes this.
 -accept 0x40 (bit 6) being high as a valid fan sensor setting for all fans
  not just fan 1, I have a feeling this bit indicates whether or not a fan is
  actually connected .

Signed-off-by: Hans de Goede <j.w.r.degoede at hhs.nl>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/abituguru.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- linux-2.6.17-rc5.orig/drivers/hwmon/abituguru.c	2006-06-04 17:06:55.000000000 +0200
+++ linux-2.6.17-rc5/drivers/hwmon/abituguru.c	2006-06-04 17:27:25.000000000 +0200
@@ -529,9 +529,8 @@
 		   -0x08 enable beep
 		   -0x01 enable alarm
 		   All other bits should be 0, but on some motherboards
-		   0x40 (bit 6) is also high, at least for fan1 */
-		if ((!i && (data->bank2_settings[i][0] & ~0xC9)) ||
-		     (i && (data->bank2_settings[i][0] & ~0x89))) {
+		   0x40 (bit 6) is also high for some of the fans?? */
+		if (data->bank2_settings[i][0] & ~0xC9) {
 			ABIT_UGURU_DEBUG(2, "  bank2 sensor %d does not seem "
 				"to be a fan sensor: settings[0] = %02X\n",
 				i, (unsigned int)data->bank2_settings[i][0]);

-- 
Jean Delvare

