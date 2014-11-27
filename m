From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Thu, 27 Nov 2014 09:59:05 +0000
Subject: [lm-sensors] [PATCH v2 0/5] hwmon: ina2xx: fixes & extensions
Message-Id: <1417082350-23470-1-git-send-email-bgolaszewski@baylibre.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, LM Sensors <lm-sensors@lm-sensors.org>, Jean Delvare <jdelvare@suse.de>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series fixes an initialization issue we've experienced with the ina2xx
driver and extends the sysfs interface to make the driver configurable
at run-time.

The shunt_resistor attribute allows to change the shunt resistance value
at run-time in cases where ina2xx used to do the measurement isn't integrated
with the shunt.

The avg_rate attribute allows to increase/decrease noise reduction.

Bartosz Golaszewski (5):
  hwmon: ina2xx: bail-out from ina2xx_probe() in case of configuration errors
  hwmon: ina2xx: make shunt resistance configurable at run-time
  hwmon: ina2xx: allow to change the averaging rate at run-time
  hwmon: ina2xx: change hex constants to lower-case
  hwmon: ina2xx: documentation update for new sysfs attributes

 Documentation/hwmon/ina2xx |  10 ++-
 drivers/hwmon/ina2xx.c     | 187 +++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 181 insertions(+), 16 deletions(-)

-- 
2.1.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
