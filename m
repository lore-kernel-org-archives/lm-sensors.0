From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Wed, 03 Dec 2014 13:06:08 +0000
Subject: [lm-sensors] [PATCH v4 0/3] hwmon: ina2xx: new attributes
Message-Id: <1417611971-10360-1-git-send-email-bgolaszewski@baylibre.com>
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

v4:
- corrected the wrong e-mail address in the Signed-off-by field

v3:
- avg_rate is now only created for ina226
- avg_rate displays available averaging rates on read
- other minor fixes according to the code review

v2: https://www.mail-archive.com/linux-kernel%40vger.kernel.org/msg776942.html

The following patches have been rebased against the hwmon-next branch.

Bartosz Golaszewski (3):
  hwmon: ina2xx: make shunt resistance configurable at run-time
  hwmon: ina2xx: allow to change the averaging rate at run-time
  hwmon: ina2xx: documentation update for new sysfs attributes

 Documentation/hwmon/ina2xx |  10 ++-
 drivers/hwmon/ina2xx.c     | 195 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 190 insertions(+), 15 deletions(-)

-- 
2.1.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
