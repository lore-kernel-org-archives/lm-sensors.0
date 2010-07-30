From: "Fenghua Yu" <fenghua.yu@intel.com>
Date: Fri, 30 Jul 2010 00:13:41 +0000
Subject: [lm-sensors] [PATCH V3 0/5] Package Level Thermal Control and Power
Message-Id: <1280448826-12004-1-git-send-email-fenghua.yu@intel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, H Peter Anvin <hpa@zytor.com>, Len Brown <lenb@kernel.org>, Guenter Roeck <guenter.roeck@ericsson.com>, Chen Gong <gong.chen@linux.intel.com>, Jean Delvare <khali@linux-fr.org>, Huaxu Wan <huaxu.wan@intel.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, Fenghua Yu <fenghua.yu@intel.com>

From: Fenghua Yu <fenghua.yu@intel.com>

The new MSRs PACKAGE_THERM_STATUS and PACKAGE_THERM_INTERRUPT and power limit
notification are published in Intel 64 and IA32 SDM and first implemented on
Intel Sandy Bridge platform. The following patch set supports the new features
in Linux kernel. 

Fenghua Yu (5):
  Package Level Thermal Control and Power Limit Notification: enable
    features
  Package Level Thermal Control and Power Limit Notification: pkgtemp
    hwmon driver
  Package Level Thermal Control and Power Limit Notification: thermal
    throttling handler
  Package Level Thermal Control and Power Limit Notification: power
    limit
  Package Level Thermal Control and Power Limit Notification: pkgtemp
    doc

 Documentation/hwmon/pkgtemp                |   36 +++
 arch/x86/configs/i386_defconfig            |    1 +
 arch/x86/configs/x86_64_defconfig          |    1 +
 arch/x86/include/asm/cpufeature.h          |    2 +
 arch/x86/include/asm/msr-index.h           |   17 +-
 arch/x86/kernel/cpu/addon_cpuid_features.c |    2 +
 arch/x86/kernel/cpu/mcheck/therm_throt.c   |  206 ++++++++++---
 drivers/hwmon/Kconfig                      |    7 +
 drivers/hwmon/Makefile                     |    1 +
 drivers/hwmon/pkgtemp.c                    |  456 ++++++++++++++++++++++++++++
 10 files changed, 688 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/hwmon/pkgtemp
 create mode 100644 drivers/hwmon/pkgtemp.c


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
