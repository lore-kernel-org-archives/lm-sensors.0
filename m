From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 23 Mar 2012 10:59:21 +0000
Subject: [lm-sensors] [GIT PULL] hwmon updates for Linux 3.4
Message-Id: <20120323115921.7e495774@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Linus,

Please pull hwmon subsystem updates for Linux 3.4 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

We have support for the MCP3021, MC13892 and GMT G781, automatic fan
speed control for LM63/LM64 chips, and a few clean-ups.

 Documentation/hwmon/lm90        |    4 +
 Documentation/hwmon/mc13783-adc |   50 +++-
 Documentation/hwmon/mcp3021     |   22 ++
 drivers/hwmon/Kconfig           |   28 ++-
 drivers/hwmon/Makefile          |    1 +
 drivers/hwmon/fam15h_power.c    |   10 +-
 drivers/hwmon/lm63.c            |  586 ++++++++++++++++++++++-----------------
 drivers/hwmon/lm90.c            |   98 +++++---
 drivers/hwmon/mc13783-adc.c     |  103 ++++++--
 drivers/hwmon/mcp3021.c         |  171 ++++++++++++
 drivers/hwmon/w83795.c          |  132 ++++++---
 11 files changed, 826 insertions(+), 379 deletions(-)
 create mode 100644 Documentation/hwmon/mcp3021
 create mode 100644 drivers/hwmon/mcp3021.c

---------------

Andre Przywara (1):
      hwmon: (fam15h_power) Increase output resolution

Andreas Herrmann (1):
      hwmon: (fam15h_power) Correct sign extension of running_avg_capture

Frans Meulenbroeks (1):
      hwmon: (mc13783-adc) Remove space before tab

Guenter Roeck (4):
      hwmon: (w83795) Fix multi-line comments
      hwmon: (lm90) Fix multi-line comments
      hwmon: (lm90) Add support for GMT G781
      hwmon: (lm90) Restore original configuration if probe function fails

Jean Delvare (4):
      hwmon: (w83795) Unconditionally support manual fan speed control
      hwmon: (lm63) Reorganize the code
      hwmon: (lm63) Make fan speed control strategy changeable
      hwmon: (lm63) Let the user adjust the lookup table

Uwe Kleine-Koenig (1):
      hwmon: (mc13783-adc) Add support for the MC13892 PMIC

Xie Xiaobo (1):
      hwmon: Add MCP3021 ADC driver

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
