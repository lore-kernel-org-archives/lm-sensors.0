From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Wed, 10 Dec 2014 10:38:54 +0000
Subject: [lm-sensors] [PATCH v5 0/3] hwmon: ina2xx: new attributes
Message-Id: <1418207937-11648-1-git-send-email-bgolaszewski@baylibre.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, LM Sensors <lm-sensors@lm-sensors.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series extends the sysfs interface to make the driver configurable
at run-time.

The shunt_resistor attribute allows to change the shunt resistance value
at run-time in cases where ina2xx used to do the measurement isn't integrated
with the shunt.

The avg_rate attribute allows to increase/decrease noise reduction.

v5:
- avoid a "division by zero in kernel" if reading from an uninitialized
  register

v4:
https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg781119.html

Bartosz Golaszewski (3):
  hwmon: ina2xx: make shunt resistance configurable at run-time
  hwmon: ina2xx: allow to change the averaging rate at run-time
  hwmon: ina2xx: documentation update for new sysfs attributes

 Documentation/hwmon/ina2xx |  10 ++-
 drivers/hwmon/ina2xx.c     | 199 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 194 insertions(+), 15 deletions(-)

-- 
2.1.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
