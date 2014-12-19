From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Fri, 19 Dec 2014 09:36:07 +0000
Subject: [lm-sensors] [RESEND PATCH v7 3/5] hwmon: ina2xx: don't accept shunt values greater than the calibra
Message-Id: <1418981769-11287-4-git-send-email-bgolaszewski@baylibre.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1418981769-11287-1-git-send-email-bgolaszewski@baylibre.com>
In-Reply-To: <1418981769-11287-1-git-send-email-bgolaszewski@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, LM Sensors <lm-sensors@lm-sensors.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

Shunt resistance values greater than the chip's calibration factor make no
sense since the actual value written to the register equals:

	<calibration factor> / <shunt>

Bail-out from ina2xx_probe() if the configured value is greater than the
calibration factor.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/hwmon/ina2xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index 39e017b..3234e57 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -313,7 +313,8 @@ static int ina2xx_probe(struct i2c_client *client,
 	data->config = &ina2xx_config[data->kind];
 	data->client = client;
 
-	if (data->rshunt <= 0)
+	if (data->rshunt <= 0 ||
+	    data->rshunt > data->config->calibration_factor)
 		return -ENODEV;
 
 	ret = ina2xx_init(data);
-- 
2.1.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
