From: "Fenghua Yu" <fenghua.yu@intel.com>
Date: Sun, 25 Jul 2010 05:13:42 +0000
Subject: [lm-sensors] [PATH V2 0/5] Package Level Thermal Control and Power
Message-Id: <1280034827-5759-1-git-send-email-fenghua.yu@intel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

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
 arch/x86/kernel/cpu/mcheck/therm_throt.c   |  209 +++++++++++---
 drivers/hwmon/Kconfig                      |    7 +
 drivers/hwmon/Makefile                     |    1 +
 drivers/hwmon/pkgtemp.c                    |  456 ++++++++++++++++++++++++++++
 10 files changed, 691 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/hwmon/pkgtemp
 create mode 100644 drivers/hwmon/pkgtemp.c

-- 
1.7.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
