From: gregkh@suse.de (Greg KH)
Date: Mon, 06 Feb 2006 20:18:57 +0000
Subject: [lm-sensors] [PATCH] hwmon: Fix negative temperature readings in
Message-Id: <11392571371598@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: Fix negative temperature readings in lm77 driver

Fix negative temperature readings in lm77 driver.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Acked-by: Michael Renzmann <mrenzmann at otaku42.de>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
commit 413b64515079a4063776d81067f69cc41bdb34ad
tree 1353d1b285b84963ad48abac3327a397cbc818d2
parent 21bbd691827e3610ef975a88863859381ac8d8e0
author Jean Delvare <khali at linux-fr.org> Mon, 09 Jan 2006 22:43:08 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Mon, 06 Feb 2006 12:02:14 -0800

 drivers/hwmon/lm77.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/lm77.c b/drivers/hwmon/lm77.c
index a2f420d..df9e02a 100644
--- a/drivers/hwmon/lm77.c
+++ b/drivers/hwmon/lm77.c
@@ -87,15 +87,15 @@ static struct i2c_driver lm77_driver = {
 
 /* In the temperature registers, the low 3 bits are not part of the
    temperature values; they are the status bits. */
-static inline u16 LM77_TEMP_TO_REG(int temp)
+static inline s16 LM77_TEMP_TO_REG(int temp)
 {
 	int ntemp = SENSORS_LIMIT(temp, LM77_TEMP_MIN, LM77_TEMP_MAX);
-	return (u16)((ntemp / 500) * 8);
+	return (ntemp / 500) * 8;
 }
 
-static inline int LM77_TEMP_FROM_REG(u16 reg)
+static inline int LM77_TEMP_FROM_REG(s16 reg)
 {
-	return ((int)reg / 8) * 500;
+	return (reg / 8) * 500;
 }
 
 /* sysfs stuff */


