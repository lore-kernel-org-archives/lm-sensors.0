From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 20 Apr 2013 17:18:09 +0000
Subject: [lm-sensors] [PATCH v3 0/4] hwmon: (tmp401) Cleanup and add support for TMP432
Message-Id: <1366478293-8167-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Along the line, also add support for update_interval.

v3: Fix spelling error
    Improve rounding
    tmp432: Write register for critical temperatures somehow got lost

v2: Code review feedback (see individual patches for details)
    Drop accepted patches from list
    Add patch to reset valid flag when resetting temperature history

----------------------------------------------------------------
Guenter Roeck (4):
      hwmon: (tmp401) Simplification and cleanup
      hwmon: (tmp401) Reset valid flag when resetting temperature history
      hwmon: (tmp401) Add support for update_interval attribute
      hwmon: (tmp401) Add support for TMP432

 Documentation/hwmon/tmp401 |   11 +-
 drivers/hwmon/tmp401.c     |  575 +++++++++++++++++++++++++-------------------
 2 files changed, 331 insertions(+), 255 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
