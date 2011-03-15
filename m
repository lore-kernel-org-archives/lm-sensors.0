From: Ilkka Koskinen <ilkka.koskinen@nokia.com>
Date: Tue, 15 Mar 2011 16:02:40 +0000
Subject: [lm-sensors] [RFC PATCH 0/5] hwmon: lis3 patches
Message-Id: <1300204965-7209-1-git-send-email-ilkka.koskinen@nokia.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org, eric.piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org, samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The first patch fixes a bug in lis3 i2c driver when probe() fails.

The rest of the patches converts statically allocated lis3 device
to dynamically allocated one, which enables support for
multiple lis3 devices on board. In addition, this patch set makes
it possible to load both i2c and spi drivers so that they don't
disturb each other. hp_accel is hacked to work and, thus, doesn't
support multiple devices.

I have tested the i2c based driver on target device, but haven't
the other two. 

The patches apply on top of hwmon-staging branch in 
git://localhost/pub/scm/linux/kernel/git/groeck/staging.git


Ilkka Koskinen (5):
  hwmon: lis3: Free regulators if probe() fails.
  hwmon: lis3: Change naming to consistent
  hwmon: lis3: Change exported function to use given device
  hwmon: lis3: Remove the referencies to the global variable in core
    driver
  hwmon: lis3: Register hwif and remove references to global variable

 drivers/hwmon/hp_accel.c      |   52 ++++---
 drivers/hwmon/lis3lv02d.c     |  392 +++++++++++++++++++++++------------------
 drivers/hwmon/lis3lv02d.h     |   11 +-
 drivers/hwmon/lis3lv02d_i2c.c |   67 ++++---
 drivers/hwmon/lis3lv02d_spi.c |   35 +++--
 5 files changed, 319 insertions(+), 238 deletions(-)


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
