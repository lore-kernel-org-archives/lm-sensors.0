From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Thu, 04 Dec 2014 09:57:26 +0000
Subject: [lm-sensors] [PATCH 0/2] hwmon: tmp401: support for TMP435 and fix for a probe issue
Message-Id: <1417687048-21455-1-git-send-email-bgolaszewski@baylibre.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, LM Sensors <lm-sensors@lm-sensors.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series adds support for the TI TMP435 chip and fixes an issue similar
to the one we observed for ina2xx - ignoring the write errors when probing the
device.

Bartosz Golaszewski (1):
  hwmon: tmp401: bail-out from tmp401_probe() in case of write errors

Patrick Titiano (1):
  hwmon: tmp401: add support for TI TMP435

 drivers/hwmon/tmp401.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

-- 
2.1.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
