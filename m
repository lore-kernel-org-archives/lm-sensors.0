From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 02 Jun 2005 05:29:37 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc5-mm1 0/3] i2c: new sysfs class "hwmon"
Message-Id: <20050602032840.GA4906@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg:

Here's the hwmon patchset again; this time I would like you to consider
applying it.  The device class ID string is now chosen by the (chip) driver.
That required a small change to the driver/core class code, which is the
first patch.  The third patch modifies all hwmon-type drivers, instead of
just a couple.  Also, thanks for your comments re: my previous patchset -
I've addressed those here.

With these patches applied, 'tree -d /sys/class/hwmon' looks like this:

/sys/class/hwmon
`-- w83627thf-0
    `-- device -> ../../../devices/platform/i2c-1/1-0290

Here is the diffstat:

 drivers/Kconfig                |    2 +
 drivers/Makefile               |    1 
 drivers/base/class.c           |   25 ++++++++++++-
 drivers/hwmon/Kconfig          |   15 +++++++
 drivers/hwmon/Makefile         |    5 ++
 drivers/hwmon/hwmon.c          |   77 +++++++++++++++++++++++++++++++++++++++++
 drivers/i2c/chips/adm1021.c    |   15 +++++++
 drivers/i2c/chips/adm1025.c    |   15 +++++++
 drivers/i2c/chips/adm1026.c    |   14 +++++++
 drivers/i2c/chips/adm1031.c    |   15 +++++++
 drivers/i2c/chips/adm9240.c    |   16 ++++++++
 drivers/i2c/chips/asb100.c     |   17 +++++++++
 drivers/i2c/chips/ds1621.c     |   15 +++++++
 drivers/i2c/chips/fscher.c     |   15 +++++++
 drivers/i2c/chips/fscpos.c     |   15 +++++++
 drivers/i2c/chips/gl518sm.c    |   15 +++++++
 drivers/i2c/chips/gl520sm.c    |   15 +++++++
 drivers/i2c/chips/it87.c       |   16 +++++++-
 drivers/i2c/chips/lm63.c       |   15 +++++++
 drivers/i2c/chips/lm75.c       |   14 +++++++
 drivers/i2c/chips/lm77.c       |   15 +++++++
 drivers/i2c/chips/lm78.c       |   15 +++++++
 drivers/i2c/chips/lm80.c       |   15 +++++++
 drivers/i2c/chips/lm83.c       |   15 +++++++
 drivers/i2c/chips/lm85.c       |   14 +++++++
 drivers/i2c/chips/lm87.c       |   15 +++++++
 drivers/i2c/chips/lm90.c       |   15 +++++++
 drivers/i2c/chips/lm92.c       |   16 +++++++-
 drivers/i2c/chips/max1619.c    |   16 +++++++-
 drivers/i2c/chips/pc87360.c    |   15 +++++++
 drivers/i2c/chips/sis5595.c    |   17 ++++++++-
 drivers/i2c/chips/smsc47b397.c |   15 +++++++
 drivers/i2c/chips/smsc47m1.c   |   16 ++++++++
 drivers/i2c/chips/via686a.c    |   23 ++++++++++--
 drivers/i2c/chips/w83627ehf.c  |   15 +++++++
 drivers/i2c/chips/w83627hf.c   |   15 +++++++
 drivers/i2c/chips/w83781d.c    |   23 ++++++++++++
 drivers/i2c/chips/w83l785ts.c  |   15 +++++++
 include/linux/device.h         |    7 +++
 include/linux/hwmon.h          |   24 ++++++++++++
 include/linux/i2c.h            |    1 
 41 files changed, 647 insertions(+), 12 deletions(-)

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

