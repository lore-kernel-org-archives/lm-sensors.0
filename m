From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 05 Feb 2006 21:07:00 +0000
Subject: [lm-sensors] [PATCH 00/11] hwmon and i2c updates
Message-Id: <20060205220700.2dbf2484.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Here comes a 11-piece hwmon and i2c update patchset. Mostly isolated
fixes and cleanups. Three of them are suitable for 2.6.16 and should be
sent to Linus. I've marked them (*) in the summary below. The rest
should spend some time in -mm for now.

Here's the summary:

Jean Delvare:
 o vt8231: Fix sysfs temperature interface (*)
 o w83781d: Use real-time status registers (*)
 o w83627hf: Document the reset module parameter (*)
 o hwmon: Support the Pentium M VID code
 o w83781d: Document the alarm and beep bits
 o w83781d: Don't reset the chip by default
 o i2c: Optimize core_lists mutex usage
 o i2c: Drop the i2c-frodo bus driver
 o i2c: Fix i2c-ite name initialization
 o i2c: Cleanup isp1301_omap

Yuan Mu:
 o w83627ehf: Refactor the sysfs interface

Statistics:

 Documentation/hwmon/w83627hf     |    4 +
 Documentation/hwmon/w83781d      |   24 ++++
 drivers/hwmon/hwmon-vid.c        |    9 ++
 drivers/hwmon/vt8231.c           |    8 
 drivers/hwmon/w83627ehf.c        |  208 +++++++++++++++-----------------------
 drivers/hwmon/w83781d.c          |   65 ++++++++----
 drivers/i2c/busses/i2c-frodo.c   |   85 ----------------
 drivers/i2c/busses/i2c-ite.c     |    4 -
 drivers/i2c/chips/isp1301_omap.c |    2 -
 drivers/i2c/i2c-core.c           |   11 +-
 include/linux/i2c-id.h           |    1 -
 11 files changed, 173 insertions(+), 248 deletions(-)


-- 
Jean Delvare

