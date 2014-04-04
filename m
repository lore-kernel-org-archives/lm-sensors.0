From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 04 Apr 2014 16:14:55 +0000
Subject: [lm-sensors] [GIT PULL] hwmon updates for Linux 3.15
Message-Id: <20140404181455.0352b329@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Linus,

Please pull hwmon subsystem updates for Linux 3.15 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

This includes a number of driver conversions to
devm_hwmon_device_register_with_groups, a few cleanups, and support for
the ITE IT8623E.

 Documentation/hwmon/it87  |  10 +--
 drivers/hwmon/adm1021.c   |  70 +++++++--------------
 drivers/hwmon/asc7621.c   |   1 -
 drivers/hwmon/atxp1.c     |   2 -
 drivers/hwmon/f71805f.c   |   2 +-
 drivers/hwmon/it87.c      |   9 ++-
 drivers/hwmon/lm63.c      | 157 +++++++++++++++++++---------------------------
 drivers/hwmon/lm77.c      |   1 -
 drivers/hwmon/lm80.c      |  70 +++++++--------------
 drivers/hwmon/lm83.c      |   1 -
 drivers/hwmon/lm87.c      |   1 -
 drivers/hwmon/lm90.c      | 111 ++++++++++++++------------------
 drivers/hwmon/lm92.c      |   1 -
 drivers/hwmon/lm93.c      |   1 -
 drivers/hwmon/max1619.c   |   1 -
 drivers/hwmon/pc87360.c   |  12 ++--
 drivers/hwmon/w83792d.c   |   1 -
 drivers/hwmon/w83l785ts.c |   4 --
 18 files changed, 173 insertions(+), 282 deletions(-)

---------------

Guenter Roeck (10):
      hwmon: (lm63) Add additional sysfs group for temp2_type attribute
      hwmon: (lm63) Introduce 'dev' variable to point to client->dev
      hwmon: (lm63) Create all sysfs groups in one call
      hwmon: (lm63) Convert to use devm_hwmon_device_register_with_groups
      hwmon: (adm1021) Convert to use devm_hwmon_device_register_with_groups
      hwmon: (lm80) Convert to use devm_hwmon_device_register_with_groups
      hwmon: (lm90) Create most optional attributes with sysfs_create_group
      hwmon: (lm90) Always use the dev variable in the probe function
      hwmon: (lm90) Create all sysfs groups in one call
      hwmon: (lm90) Convert to use hwmon_device_register_with_groups

Jean Delvare (4):
      hwmon: (f71805f) Fix author's address
      hwmon: (lm63) Avoid initializing the same field twice
      hwmon: (pc87360) Avoid initializing the same field twice
      hwmon: Avoid initializing the same field twice

Rudolf Marek (2):
      hwmon: (it87) Fix IT8603E define name
      hwmon: (it87) Add support for IT8623E

Thanks,
-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
