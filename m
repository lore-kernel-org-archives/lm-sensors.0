From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 13 Mar 2013 23:23:52 +0000
Subject: [lm-sensors] [PATCH 0/5] hwmon: (w83627ehf) Various updates
Message-Id: <1363217037-15723-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Patch 1-3 are resubmits, reparented to 3.9-rc2.
Patch 4 and 5 are new.

----------------------------------------------------------------
Guenter Roeck (5):
      hwmon: (w83627ehf) Use fixed attributes for SYSTIN, CPUTIN, and AUXTIN on NCT6775/NCT6776
      hwmon: (w83627ehf) Detect current and voltage mode for thermal diodes
      hwmon: (w83627ehf) Add support for SmartFanIV mode on W83667HG-B
      hwmon: (w83627ehf) Drop read/write lock
      hwmon: (w83627ehf) Use request_muxed_region

 drivers/hwmon/w83627ehf.c |  188 ++++++++++++++++++++++++---------------------
 1 file changed, 100 insertions(+), 88 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
