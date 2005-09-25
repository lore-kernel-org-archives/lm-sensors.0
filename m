From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 25 Sep 2005 16:05:13 +0000
Subject: [lm-sensors] [PATCH] (0/13) hwmon and i2c updates
Message-Id: <20050925160441.204d2b8d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Here comes a 13-piece hwmon and i2c update patchset. These are fixes I
gathered in the last few weeks or wrote myself. Details are given in
the header of each patch. None of these is meant for Linux 2.6.14. I'd
like you to have them included in the next -mm releases so that they get
enough testing and can be merged in Linux 2.6.15.

Here's the summary:

Grant Coady:
 o adm9240 whitespace cleanups

Hideki Iwamoto:
 o Fix I2C_FUNC_PROTOCOL_MANGLING documentation
 o Fix union i2c_smbus_data definition
 o Several PEC-related fixes in software SMBus emulation

Jean Delvare:
 o Do not forcibly enable via686a by default
 o Discard explicit static initializations to 0 in drivers/{i2c,hwmon}
 o Discard bogus comment about init setting limits in hwmon drivers
 o Reuse name strings in i2c bus drivers
 o w83l785ts converted to dynamic sysfs callbacks
 o Minor w83l785ts optimization
 o Adjust i2c_probe() for busses without SMBUS_QUICK
 o Minor i2c-amd8111 cleanup

Statistics:

 Documentation/hwmon/via686a         |   17 ++++++++++++++--
 Documentation/i2c/functionality     |    7 ++++---
 drivers/hwmon/adm1021.c             |    2 +-
 drivers/hwmon/adm9240.c             |   33 ++++++++++++++++++++-----------
 drivers/hwmon/lm78.c                |    1 -
 drivers/hwmon/via686a.c             |   21 +++++++++++---------
 drivers/hwmon/w83627hf.c            |    1 -
 drivers/hwmon/w83781d.c             |    1 -
 drivers/hwmon/w83792d.c             |    1 -
 drivers/hwmon/w83l785ts.c           |   38 ++++++++++++++++++------------------
 drivers/i2c/algos/i2c-algo-pca.c    |    2 +-
 drivers/i2c/algos/i2c-algo-sibyte.c |    2 +-
 drivers/i2c/busses/i2c-ali1535.c    |    6 +++---
 drivers/i2c/busses/i2c-ali1563.c    |    6 ++++--
 drivers/i2c/busses/i2c-ali15x3.c    |    9 +++++----
 drivers/i2c/busses/i2c-amd756.c     |    7 +++----
 drivers/i2c/busses/i2c-amd8111.c    |    5 +++--
 drivers/i2c/busses/i2c-i801.c       |    4 ++--
 drivers/i2c/busses/i2c-iop3xx.c     |    2 +-
 drivers/i2c/busses/i2c-nforce2.c    |    4 ++--
 drivers/i2c/busses/i2c-piix4.c      |   12 +++++-----
 drivers/i2c/busses/i2c-sis5595.c    |    9 +++++----
 drivers/i2c/busses/i2c-sis630.c     |    8 +++++---
 drivers/i2c/busses/i2c-sis96x.c     |    7 ++++---
 drivers/i2c/busses/i2c-via.c        |    6 +++---
 drivers/i2c/i2c-core.c              |   23 ++++++++++++++--------
 include/linux/i2c.h                 |    3 +--
 27 files changed, 136 insertions(+), 101 deletions(-)

Thanks,
-- 
Jean Delvare
