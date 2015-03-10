From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Tue, 10 Mar 2015 17:27:18 +0000
Subject: [lm-sensors] [PATCH v2 0/4] kernel.h: find_closest() macro
Message-Id: <1426008442-26236-1-git-send-email-bgolaszewski@baylibre.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, lm-sensors <lm-sensors@lm-sensors.org>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <srostedt@redhat.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series proposes to unduplicate the code used to find the
member in an array closest to 'x'.

The first patch adds a macro implementing the algorithm in two
flavors - for arrays sorted in ascending and descending order.
Other three patches replace duplicated code with calls to one
of these macros in some hwmon drivers.

v2:
- fixed an off-by-one bug in patch [3/4]

v1:
https://lkml.org/lkml/2015/2/24/509

Bartosz Golaszewski (4):
  kernel.h: add find_closest() macro
  hwmon: (ina2xx) replace ina226_avg_bits() with find_closest()
  hwmon: (lm85) replace x_TO_REG() functions with find_closest()
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
