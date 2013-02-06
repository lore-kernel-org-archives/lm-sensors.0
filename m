From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Wed, 06 Feb 2013 11:10:37 +0000
Subject: [lm-sensors] [PATCH v2 0/2] Add ST-Ericsson AB8500 HWMON driver
Message-Id: <1360149039-7038-1-git-send-email-hongbo.zhang@linaro.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Guenter,
Please check this v2 patches, thanks.

Anton Vorontsov and David Woodhouse,
Please have a look at this [2/2] patch, thanks.


v1 -> v2 changes:
- Add Documentation/hwmon/abx500 and Documentation/hwmon/abx500
- Make devices which cannot report milli-Celsius invisible
- Add temp5_crit interface
- Re-work the old find_active_thresholds() to threshold_updated()
- Reset updated_min_alarm and updated_max_alarm at the end of each loop
- Update the hyst mechamisn to make it works as real hyst
- Remove non-stand attributes
- Re-order the operations sequence inside probe and remove functions
- Update all the lock usages to eliminate race conditions
- Make attibutes index starts from 0
also changes:
- Since the old [1/2] "ARM: ux500: rename ab8500 to abx500 for hwmon driver"
  has been merged by Samuel, so won't send it again.
- Add another new patch "ab8500_btemp: export two symblols" as [2/2] of this
  patch set.


Hongbo Zhang (2):
  hwmon: add ST-Ericsson ABX500 hwmon driver
  ab8500_btemp: export two symblols

 Documentation/hwmon/ab8500   |  22 ++
 Documentation/hwmon/abx500   |  26 +++
 drivers/hwmon/Kconfig        |  13 ++
 drivers/hwmon/Makefile       |   1 +
 drivers/hwmon/ab8500.c       | 163 +++++++++++++
 drivers/hwmon/abx500.c       | 544 +++++++++++++++++++++++++++++++++++++++++++
 drivers/hwmon/abx500.h       |  84 +++++++
 drivers/power/ab8500_btemp.c |   2 +
 8 files changed, 855 insertions(+)
 create mode 100644 Documentation/hwmon/ab8500
 create mode 100644 Documentation/hwmon/abx500
 create mode 100644 drivers/hwmon/ab8500.c
 create mode 100644 drivers/hwmon/abx500.c
 create mode 100644 drivers/hwmon/abx500.h

-- 
1.8.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
