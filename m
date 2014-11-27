From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Thu, 27 Nov 2014 09:59:09 +0000
Subject: [lm-sensors] [PATCH v2 4/5] hwmon: ina2xx: change hex constants to lower-case
Message-Id: <1417082350-23470-5-git-send-email-bgolaszewski@baylibre.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1417082350-23470-1-git-send-email-bgolaszewski@baylibre.com>
In-Reply-To: <1417082350-23470-1-git-send-email-bgolaszewski@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, LM Sensors <lm-sensors@lm-sensors.org>, Jean Delvare <jdelvare@suse.de>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

Make ina2xx uniform with the majority of the kernel code.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/hwmon/ina2xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index 7fdb586..5095a7a 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -49,7 +49,7 @@
 /* INA226 register definitions */
 #define INA226_MASK_ENABLE		0x06
 #define INA226_ALERT_LIMIT		0x07
-#define INA226_DIE_ID			0xFF
+#define INA226_DIE_ID			0xff
 
 /* shunt resistor sysfs attribute index */
 #define INA2XX_RSHUNT			0x8
@@ -64,7 +64,7 @@
 #define INA2XX_MAX_REGISTERS		8
 
 /* settings - depend on use case */
-#define INA219_CONFIG_DEFAULT		0x399F	/* PGA=8 */
+#define INA219_CONFIG_DEFAULT		0x399f	/* PGA=8 */
 #define INA226_CONFIG_DEFAULT		0x4527	/* averages */
 
 /* worst case is 68.10 ms (~14.6Hz, ina219) */
@@ -74,8 +74,8 @@
 #define INA2XX_RSHUNT_DEFAULT		10000
 
 /* bit masks for the averaging setting in the configuration register */
-#define INA226_AVG_RD_MASK		0x0E00
-#define INA226_AVG_WR_MASK		0xF1FF
+#define INA226_AVG_RD_MASK		0x0e00
+#define INA226_AVG_WR_MASK		0xf1ff
 
 #define INA226_READ_AVG(reg) ((reg & INA226_AVG_RD_MASK) >> 9)
 
-- 
2.1.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
