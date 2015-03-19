From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Thu, 19 Mar 2015 17:27:40 +0000
Subject: [lm-sensors] [PATCH v4 0/5] new macro: find_closest()
Message-Id: <1426786065-9798-1-git-send-email-bgolaszewski@baylibre.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, lm-sensors <lm-sensors@lm-sensors.org>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series proposes to unduplicate the code used to find the
member in an array closest to 'x'.

The first patch adds a macro implementing the algorithm in two
flavors - for arrays sorted in ascending and descending order.
The second updates Documentation/CodingStyle on the naming
convention for local variables in macros resembling functions.
Other three patches replace duplicated code with calls to one
of these macros in some hwmon drivers.

v4:
- use >= instead of > in find_closest_descending()
- fix kernel docs
- make local variables in added macros less likely to cause namespace
  collisions
- use consistent statement expression syntax

v3:
https://lkml.org/lkml/2015/3/19/369

v2:
https://lkml.org/lkml/2015/3/10/582

v1:
https://lkml.org/lkml/2015/2/24/509

Bartosz Golaszewski (5):
  util_macros.h: add find_closest() macro
  documentation: update CodingStyle on local variables naming in macros
  hwmon: (ina2xx) replace ina226_avg_bits() with find_closest()
  hwmon: (lm85) use find_closest() in x_TO_REG() functions
  hwmon: (w83795) use find_closest_descending() in pwm_freq_to_reg()

 Documentation/CodingStyle   | 13 +++++++++++++
 drivers/hwmon/ina2xx.c      | 17 +++--------------
 drivers/hwmon/lm85.c        | 26 ++++++++------------------
 drivers/hwmon/w83795.c      |  8 +++-----
 include/linux/util_macros.h | 40 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 67 insertions(+), 37 deletions(-)
 create mode 100644 include/linux/util_macros.h

-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
