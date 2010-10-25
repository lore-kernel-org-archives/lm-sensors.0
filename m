From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 25 Oct 2010 21:51:50 +0000
Subject: [lm-sensors] [GIT PULL] hwmon changes for 2.6.37
Message-Id: <1288044233-6567-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Linus,

Please pull hwmon subsystem changes for Linux 2.6.37 from:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus

Thanks,
Guenter Roeck

------

The following changes since commit 72e58063d63c5f0a7bf65312f1e3a5ed9bb5c2ff:

  Merge branch 'davinci-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-davinci (2010-10-25 10:59:31 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus

Chen Gong (2):
      hwmon: (pkgtemp) align driver initialization style with coretemp
      hwmon: ({core, pkg, via-cpu}temp) remove unnecessary CONFIG_HOTPLUG_CPU ifdefs

Guenter Roeck (1):
      hwmon: LTC4261 Hardware monitoring driver

Jan Beulich (4):
      x86/hwmon: {core, pkg, via}cpu_temp_device_remove() can all be __cpuinit
      x86/hwmon: (coretemp) cosmetic cleanup
      x86/hwmon: remove inclusion of unnecessary headers from {core, pkg, via-cpu}temp.c
      hwmon: (coretemp) fix reading of microcode revision (v2)

Masanari Iida (1):
      hwmon: (hp_accel) Add HP Mini 510x family support

Samu Onkalo (12):
      hwmon: lis3: pm_runtime support
      hwmon: lis3: regulator control
      hwmon: lis3: Cleanup interrupt handling
      hwmon: lis3: Update coordinates at polled device open
      hwmon: lis3: Power on corrections
      hwmon: lis3: restore axis enabled bits
      hwmon: lis3: New parameters to platform data
      hwmon: lis3: Adjust fuzziness for 8 bit device
      hwmon: lis3: use block read to access data registers
      hwmon: lis3: Enhance lis3 selftest with IRQ line test
      hwmon: lis3: Short explanations of platform data fields
      hwmon: lis3: Release resources in case of failure

Simon Guinot (2):
      hwmon: add generic GPIO fan driver
      Kirkwood: add fan support for Network Space Max v2

Takashi Iwai (2):
      hwmon: (lis3) Add support for new LIS3DC / HP3DC chip
      hwmon: (lis3) add axes module parameter for custom axis-mapping

 Documentation/hwmon/ltc4261                |   63 ++++
 MAINTAINERS                                |    7 +
 arch/arm/mach-kirkwood/netspace_v2-setup.c |   43 +++
 drivers/hwmon/Kconfig                      |   20 +
 drivers/hwmon/Makefile                     |    2 +
 drivers/hwmon/coretemp.c                   |   28 +-
 drivers/hwmon/gpio-fan.c                   |  558 ++++++++++++++++++++++++++++
 drivers/hwmon/hp_accel.c                   |   32 +-
 drivers/hwmon/lis3lv02d.c                  |  364 +++++++++++++++---
 drivers/hwmon/lis3lv02d.h                  |   47 ++-
 drivers/hwmon/lis3lv02d_i2c.c              |  132 ++++++-
 drivers/hwmon/lis3lv02d_spi.c              |    5 +-
 drivers/hwmon/ltc4261.c                    |  315 ++++++++++++++++
 drivers/hwmon/pkgtemp.c                    |   32 +--
 drivers/hwmon/via-cputemp.c                |   11 +-
 include/linux/gpio-fan.h                   |   36 ++
 include/linux/lis3lv02d.h                  |   55 +++-
 17 files changed, 1619 insertions(+), 131 deletions(-)
 create mode 100644 Documentation/hwmon/ltc4261
 create mode 100644 drivers/hwmon/gpio-fan.c
 create mode 100644 drivers/hwmon/ltc4261.c
 create mode 100644 include/linux/gpio-fan.h

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
