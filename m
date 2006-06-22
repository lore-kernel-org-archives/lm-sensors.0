From: greg@kroah.com (Greg KH)
Date: Thu, 22 Jun 2006 18:27:55 +0000
Subject: [lm-sensors] [PATCH 29/44] [PATCH] abituguru: Fix fan detection
Message-Id: <11510010131599-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Hans de Goede <j.w.r.degoede at hhs.nl>

One of my testers had a problem where the driver only saw 2 of the 4 fan
sensors his uGuru has, this fixes this.
 -accept 0x40 (bit 6) being high as a valid fan sensor setting for all fans
  not just fan 1, I have a feeling this bit indicates whether or not a fan is
  actually connected .

Signed-off-by: Hans de Goede <j.w.r.degoede at hhs.nl>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/hwmon/abituguru.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/abituguru.c b/drivers/hwmon/abituguru.c
index ab80b41..59122cc 100644
--- a/drivers/hwmon/abituguru.c
+++ b/drivers/hwmon/abituguru.c
@@ -529,9 +529,8 @@ abituguru_detect_no_bank2_sensors(struct
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
1.4.0


