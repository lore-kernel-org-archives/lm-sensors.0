From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 06 Apr 2013 01:02:52 +0000
Subject: [lm-sensors] [PATCH 0/5] hwmon: (tmp401) Cleanup and add support for TMP432
Message-Id: <1365210177-24656-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Along the line, also add support for update_interval.

----------------------------------------------------------------
Guenter Roeck (5):
      hwmon: (tmp401) Drop unused defines, use BIT for bit masks
      hwmon: (tmp401) Use sysfs_create_group / sysfs_remove_group
      hwmon: (tmp401) Simplification and cleanup
      hwmon: (tmp401) Add support for update_interval attribute
      hwmon: (tmp401) Add support for TMP432

 Documentation/hwmon/tmp401 |    7 +
 drivers/hwmon/tmp401.c     |  676 +++++++++++++++++++++++++-------------------
 2 files changed, 392 insertions(+), 291 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
