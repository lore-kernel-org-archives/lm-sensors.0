From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 08 Jun 2011 10:41:03 +0000
Subject: [lm-sensors] [PATCH] hwmon-vid: Fix typo in VIA CPU name
Message-Id: <20110608124103.17ea9318@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

It's Nehemiah, not Nemiah.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/hwmon-vid.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-3.0-rc2.orig/drivers/hwmon/hwmon-vid.c	2011-05-20 10:41:54.000000000 +0200
+++ linux-3.0-rc2/drivers/hwmon/hwmon-vid.c	2011-06-08 12:22:19.000000000 +0200
@@ -202,7 +202,7 @@ static struct vrm_model vrm_models[] = {
 
 	{X86_VENDOR_CENTAUR, 0x6, 0x7, ANY, 85},	/* Eden ESP/Ezra */
 	{X86_VENDOR_CENTAUR, 0x6, 0x8, 0x7, 85},	/* Ezra T */
-	{X86_VENDOR_CENTAUR, 0x6, 0x9, 0x7, 85},	/* Nemiah */
+	{X86_VENDOR_CENTAUR, 0x6, 0x9, 0x7, 85},	/* Nehemiah */
 	{X86_VENDOR_CENTAUR, 0x6, 0x9, ANY, 17},	/* C3-M, Eden-N */
 	{X86_VENDOR_CENTAUR, 0x6, 0xA, 0x7, 0},		/* No information */
 	{X86_VENDOR_CENTAUR, 0x6, 0xA, ANY, 13},	/* C7, Esther */


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
