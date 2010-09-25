From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 25 Sep 2010 01:28:01 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.36
Message-Id: <1285378081-7902-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100825165951.0c5d0955@hyperion.delvare>
In-Reply-To: <20100825165951.0c5d0955@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Linus,

Please pull hwmon subsystem fixes for Linux 2.6.36 from:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus

Thanks,
Guenter Roeck

------

Guenter Roeck (1):
      MAINTAINERS: Update hwmon entry

Jan Beulich (7):
      x86/hwmon: fix module init for hotplug-but-no-device-found case
      x86/hwmon: avoid deadlock on CPU removal in pkgtemp
      x86/hwmon: don't leak device attribute file from pkgtemp_probe() and pkgtemp_remove()
      x86/hwmon: fix initialization of coretemp
      x86/hwmon: fix initialization of pkgtemp
      x86/hwmon: register alternate sibling upon CPU removal
      x86/hwmon: pkgtemp has no dependency on PCI

Takashi Iwai (1):
      hwmon: (lis3) Fix Oops with NULL platform data

 MAINTAINERS                       |    2 +
 arch/x86/include/asm/cpufeature.h |    1 +
 arch/x86/kernel/cpu/scattered.c   |    1 +
 drivers/hwmon/Kconfig             |    2 +-
 drivers/hwmon/coretemp.c          |   56 +++++++++++++++++++++----------------
 drivers/hwmon/lis3lv02d.c         |    4 +-
 drivers/hwmon/pkgtemp.c           |   23 +++++++--------
 7 files changed, 50 insertions(+), 39 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
