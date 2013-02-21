From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Thu, 21 Feb 2013 10:32:38 +0000
Subject: [lm-sensors] [PATCH v3 0/3] Add ST-Ericsson AB8500 HWMON driver
Message-Id: <1361442761-2690-1-git-send-email-hongbo.zhang@linaro.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Guenter,
Please check this v3 patches, thanks.

Anton Vorontsov and David Woodhouse,
Please have a look at this 1/3 and 2/3 patches, thanks.

v2 -> v3 changes:
- Add interface for converting voltage to temperature
- Remove temp5 sensor since we cannot offer temperature read interface of it
- Update hyst to use absolute temperature instead of a difference
- Add the 3/3 patch

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
Hongbo Zhang (3):
  ab8500_btemp: make get_temp interface public
  ab8500: make res_to_temp tables public
  hwmon: add ST-Ericsson ABX500 hwmon driver

 Documentation/hwmon/ab8500           |  22 ++
 Documentation/hwmon/abx500           |  26 ++
 drivers/hwmon/Kconfig                |  13 +
 drivers/hwmon/Makefile               |   1 +
 drivers/hwmon/ab8500.c               | 178 +++++++++++++
 drivers/hwmon/abx500.c               | 501 +++++++++++++++++++++++++++++++++++
 drivers/hwmon/abx500.h               |  87 ++++++
 drivers/power/ab8500_bmdata.c        |   8 +-
 drivers/power/ab8500_btemp.c         |   2 +-
 include/linux/mfd/abx500/ab8500-bm.h |   5 +
 10 files changed, 840 insertions(+), 3 deletions(-)
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
