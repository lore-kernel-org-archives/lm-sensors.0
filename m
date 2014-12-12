From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Fri, 12 Dec 2014 14:37:52 +0000
Subject: [lm-sensors] [PATCH v6 2/5] hwmon: ina2xx: remove a stray new line
Message-Id: <1418395075-16850-3-git-send-email-bgolaszewski@baylibre.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1418395075-16850-1-git-send-email-bgolaszewski@baylibre.com>
In-Reply-To: <1418395075-16850-1-git-send-email-bgolaszewski@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, LM Sensors <lm-sensors@lm-sensors.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/hwmon/ina2xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index 4c5c9ab..24fce2a 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -52,7 +52,6 @@
 #define INA226_ALERT_LIMIT		0x07
 #define INA226_DIE_ID			0xFF
 
-
 /* register count */
 #define INA219_REGISTERS		6
 #define INA226_REGISTERS		8
-- 
2.1.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
