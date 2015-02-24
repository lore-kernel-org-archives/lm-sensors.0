From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Tue, 24 Feb 2015 17:42:10 +0000
Subject: [lm-sensors] [PATCH 0/4] find_closest() macro
Message-Id: <1424799734-2170-1-git-send-email-bgolaszewski@baylibre.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.de>, lm-sensors <lm-sensors@lm-sensors.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series proposes to unduplicate the code used to find the
member in an array closest to 'x'.

The first patch adds a macro implementing the algorithm in two
flavors - for arrays sorted in ascending and descending order.
Other three patches replace duplicated code with calls to one
of these macros in some hwmon drivers.

Bartosz Golaszewski (4):
  kernel.h: add find_closest() macro
  hwmon: (ina2xx) replace ina226_avg_bits() with find_closest()
  hwmon: (lm85) replace XXX_TO_REG() functions with find_closest()
  hwmon: (w83795) use find_closest_desc() in pwm_freq_to_reg()

 drivers/hwmon/ina2xx.c | 16 ++--------------
 drivers/hwmon/lm85.c   | 43 ++++++++++++-------------------------------
 drivers/hwmon/w83795.c |  7 ++-----
 include/linux/kernel.h | 23 +++++++++++++++++++++++
 4 files changed, 39 insertions(+), 50 deletions(-)

-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
