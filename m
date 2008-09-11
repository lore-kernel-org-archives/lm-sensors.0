From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 11 Sep 2008 10:04:40 +0000
Subject: [lm-sensors] [PATCH 0/5] Improvements and fixes to the lm78 driver
Message-Id: <20080911120440.25a6c22b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Here are 5 patches fixing bugs in the lm78 driver, improving it, and
converting it to the new I2C device driver binding model:

[PATCH 1/5] hwmon: (lm78) Fix I/O resource conflict with PNP
[PATCH 2/5] hwmon: (lm78) Detect alias chips
[PATCH 3/5] hwmon: (lm78) Prevent misdetection of Winbond chips
[PATCH 4/5] hwmon: (lm78) Stop abusing struct i2c_client for ISA devices
[PATCH 5/5] hwmon: (lm78) Convert to a new-style i2c driver

 drivers/hwmon/lm78.c |  274 +++++++++++++++++++++++++++++----------------------
 1 file changed, 160 insertions(+), 114 deletions(-)

The first 2 patches had already been sent to the lm-sensors list back
in June. I want all of these patches to go in kernel 2.6.28, so I have
included them in my personal hwmon tree [1]. I would welcome reviewers
and testers for these patches.

[1] http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
