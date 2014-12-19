From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Fri, 19 Dec 2014 09:36:04 +0000
Subject: [lm-sensors] [RESEND PATCH v7 0/5] hwmon: ina2xx: implement chip reinitialization and add new attrib
Message-Id: <1418981769-11287-1-git-send-email-bgolaszewski@baylibre.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, LM Sensors <lm-sensors@lm-sensors.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series implements a mechanism to detect if the chip is in its POR state
and reinitialize it if needed. It also extends the sysfs interface to make the
driver configurable at run-time.

The shunt_resistor attribute allows to change the shunt resistance value
at run-time in cases where ina2xx used to do the measurement isn't integrated
with the shunt.

The avg_rate attribute allows to increase/decrease noise reduction.

v7:
- implemented a retry counter for the reinitialization procedure
- using msleep() (since the sleep is > 20ms) instead of mdelay()
  when waiting for the chip update

v6:
https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg787390.html

Bartosz Golaszewski (5):
  hwmon: ina2xx: reinitialize the chip in case it's been reset
  hwmon: ina2xx: remove a stray new line
  hwmon: ina2xx: don't accept shunt values greater than the calibration factor
  hwmon: ina2xx: make shunt resistance configurable at run-time
  hwmon: ina2xx: allow to change the averaging rate at run-time

 Documentation/hwmon/ina2xx |   8 +-
 drivers/hwmon/ina2xx.c     | 304 +++++++++++++++++++++++++++++++++++++++------
 2 files changed, 269 insertions(+), 43 deletions(-)

-- 
2.1.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
