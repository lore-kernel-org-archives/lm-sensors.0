From: Constantine Shulyupin <const@MakeLinux.com>
Date: Wed, 24 Jun 2015 22:47:31 +0000
Subject: [lm-sensors] [PATCH] fix nct7802_temp_is_visible
Message-Id: <1435186051-10196-1-git-send-email-const@MakeLinux.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jdelvare@suse.de, linux@roeck-us.net, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Cc: const <const@MakeLinux.com>, Constantine Shulyupin <const@MakeLinux.com>

From: const <const@makelinux.com>

Fixed registers are invisible only when registers' mode is 0

Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
---
 drivers/hwmon/nct7802.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
index ec56782..65e40c2 100644
--- a/drivers/hwmon/nct7802.c
+++ b/drivers/hwmon/nct7802.c
@@ -541,13 +541,11 @@ static umode_t nct7802_temp_is_visible(struct kobject *kobj,
 	if (err < 0)
 		return 0;
 
-	if (index < 9 &&
-	    (reg & 03) != 0x01 && (reg & 0x03) != 0x02)		/* RD1 */
+	if (index < 9 && !(reg & 0x03))			/* RD1 */
 		return 0;
-	if (index >= 9 && index < 18 &&
-	    (reg & 0x0c) != 0x04 && (reg & 0x0c) != 0x08)	/* RD2 */
+	if (index >= 9 && index < 18 && !(reg & 0x0c))	/* RD2 */
 		return 0;
-	if (index >= 18 && index < 27 && (reg & 0x30) != 0x10)	/* RD3 */
+	if (index >= 18 && index < 27 && !(reg & 0x30))	/* RD3 */
 		return 0;
 	if (index >= 27 && index < 35)				/* local */
 		return attr->mode;
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
