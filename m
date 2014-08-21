From: <atull@opensource.altera.com>
Date: Thu, 21 Aug 2014 22:21:24 +0000
Subject: [lm-sensors] [PATCH 0/2] add regulator support for pmbus and ltc2978
Message-Id: <1408659686-29106-1-git-send-email-atull@opensource.altera.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux@roeck-us.net, jdelvare@suse.de
Cc: lm-sensors@lm-sensors.org, lgirdwood@gmail.com, broonie@kernel.org, linux-kernel@vger.kernel.org, delicious.quinoa@gmail.com, dinguyen@opensource.altera.com, yvanderv@opensource.altera.com, Alan Tull <atull@opensource.altera.com>

From: Alan Tull <atull@opensource.altera.com>

This set of patches adds regulator support to pmbus_core.c and to
ltc2978.c.

Other pmbus parts can use this to add their own regulator support.

Current ltc2978 support is limited to enable/disable.

Tested on ltc2978.  Looking at the datasheets for the other parts
supported by ltc2978.c, it looks like it should work.

Thanks,
Alan

Alan Tull (2):
  pmbus: add regulator support
  pmbus: ltc2978: add regulator enable disable

 drivers/hwmon/pmbus/Kconfig      |    9 +++++
 drivers/hwmon/pmbus/ltc2978.c    |   69 ++++++++++++++++++++++++++++++++++++++
 drivers/hwmon/pmbus/pmbus.h      |    7 ++++
 drivers/hwmon/pmbus/pmbus_core.c |   40 ++++++++++++++++++++++
 4 files changed, 125 insertions(+)

-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
