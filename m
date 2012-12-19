From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 19 Dec 2012 21:33:53 +0000
Subject: [lm-sensors] [GIT PULL] hwmon updates for Linux 3.8
Message-Id: <20121219223353.7b671d1f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Linus,

Please pull hwmon subsystem updates for Linux 3.8 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

There are many improvements to the it87 driver, as well as suspend
support for the Winbond Super-I/O chips, and a few other fixes.

 Documentation/hwmon/it87  |   10 +
 drivers/hwmon/hwmon-vid.c |   10 +
 drivers/hwmon/hwmon.c     |   24 +-
 drivers/hwmon/it87.c      |  890 +++++++++++++++++++++++---------------------
 drivers/hwmon/w83627ehf.c |   99 +++++-
 drivers/hwmon/w83627hf.c  |   81 ++++-
 6 files changed, 674 insertions(+), 440 deletions(-)

---------------

Guenter Roeck (10):
      hwmon: (it87) Save temperature registers in 2-dimensional array
      hwmon: (it87) Save voltage register values in 2-dimensional array
      hwmon: (it87) Replace macro defining tempX_type sensors with direct definitions
      hwmon: (it87) Introduce support for tempX_offset sysfs attribute
      hwmon: (it87) Save fan registers in 2-dimensional array
      hwmon: (it87) Avoid quoted string splits across lines
      hwmon: (it87) Replace pwm group macro with direct attribute definitions
      hwmon: (it87) Manage device specific features with table
      hwmon: (it87) Report thermal sensor type as Intel PECI if appropriate
      hwmon: (it87) Support PECI for additional chips

Jean Delvare (6):
      hwmon: Fix PCI device reference leak in quirk
      hwmon: (w83627hf) Add support for suspend
      hwmon: (w83627ehf) Add support for suspend
      hwmon: (w83627hf) Don't touch nonexistent I2C address registers
      hwmon: (w83627ehf) Get rid of smatch warnings
      hwmon-vid: Add support for AMD family 11h to 15h processors

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
