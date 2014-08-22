From: <atull@opensource.altera.com>
Date: Fri, 22 Aug 2014 21:11:32 +0000
Subject: [lm-sensors] [PATCH v2 0/2] dd regulator support for pmbus and ltc2978
Message-Id: <1408741894-24879-1-git-send-email-atull@opensource.altera.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux@roeck-us.net, jdelvare@suse.de
Cc: lm-sensors@lm-sensors.org, lgirdwood@gmail.com, broonie@kernel.org, linux-kernel@vger.kernel.org, delicious.quinoa@gmail.com, dinguyen@opensource.altera.com, yvanderv@opensource.altera.com, Alan Tull <atull@opensource.altera.com>

From: Alan Tull <atull@opensource.altera.com>

Version 2 :
  * Get regulator_init_data from platform data or device tree.
  * One regulator per pmbus part.
  * Clean up Kconfig and #includes.

This set of patches adds regulator support to pmbus_core.c and to
ltc2978.c.  Other pmbus parts can use this to add their own
regulator support.  Current ltc2978 support is limited to
enable/disable.

Tested on ltc2978.  Looking at the datasheets for the other parts
supported by ltc2978.c, it looks like it should work.

Thanks,
Alan

Alan Tull (2):
  pmbus: add regulator support
  pmbus: ltc2978: add regulator gating

 drivers/hwmon/pmbus/Kconfig      |    7 +++++
 drivers/hwmon/pmbus/ltc2978.c    |   60 ++++++++++++++++++++++++++++++++++++++
 drivers/hwmon/pmbus/pmbus.h      |    5 ++++
 drivers/hwmon/pmbus/pmbus_core.c |   51 ++++++++++++++++++++++++++++++++
 include/linux/i2c/pmbus.h        |    1 +
 5 files changed, 124 insertions(+)

-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
