From: Constantine Shulyupin <const@MakeLinux.com>
Date: Fri, 26 Jun 2015 14:47:44 +0000
Subject: [lm-sensors] [PATCH] hwmon: (nct7802) fix visibility of temp3
Message-Id: <1435330064-21565-1-git-send-email-const@MakeLinux.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jdelvare@suse.de, linux@roeck-us.net, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Cc: const <const@ctera.com>, Constantine Shulyupin <const@MakeLinux.com>

From: const <const@ctera.com>

Excerpt from datasheet:
7.2.32 Mode Selection Register
RTD3_MD : 00=Closed , 01=Reserved , 10=Thermistor mode , 11=Voltage sense

Show temp3 only in Thermistor mode

Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
---
 drivers/hwmon/nct7802.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
index 5418417..dcca5fc 100644
--- a/drivers/hwmon/nct7802.c
+++ b/drivers/hwmon/nct7802.c
@@ -649,7 +649,7 @@ static umode_t nct7802_temp_is_visible(struct kobject *kobj,
 	if (index >= 9 && index < 18 &&
 	    (reg & 0x0c) != 0x04 && (reg & 0x0c) != 0x08)	/* RD2 */
 		return 0;
-	if (index >= 18 && index < 27 && (reg & 0x30) != 0x10)	/* RD3 */
+	if (index >= 18 && index < 27 && (reg & 0x30) != 0x20)	/* RD3 */
 		return 0;
 	if (index >= 27 && index < 35)				/* local */
 		return attr->mode;
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
