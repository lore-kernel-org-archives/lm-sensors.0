From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Mon, 12 Jan 2015 13:47:20 +0000
Subject: [lm-sensors] [PATCH 0/2] hwmon: (ina2xx) code clean-up and minor fixes
Message-Id: <1421070442-9635-1-git-send-email-bgolaszewski@baylibre.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, LM Sensors <lm-sensors@lm-sensors.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

This small series fixes two minor issues in the driver after recent
implementation of new attributes. The first patch removes an unnecessary
result check after calling dev_get_drvdata() and the second one adds
calls to DIV_ROUND_CLOSEST() to avoid rounding errors.

This series is rebased against current hwmon-next.

Bartosz Golaszewski (2):
  hwmon: (ina2xx) remove an unnecessary dev_get_drvdata() result check
  hwmon: (ina2xx) use DIV_ROUND_CLOSEST() to avoid rounding errors

 drivers/hwmon/ina2xx.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

-- 
2.1.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
