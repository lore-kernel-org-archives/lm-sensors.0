From: Amit Daniel Kachhap <amit.kachhap@linaro.org>
Date: Fri, 13 Jul 2012 11:22:20 +0000
Subject: [lm-sensors] [PATCH v5 0/5] thermal: Add kernel thermal support for exynos platform
Message-Id: <1342177825-19006-1-git-send-email-amit.kachhap@linaro.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-pm@lists.linux-foundation.org, akpm@linux-foundation.org, lenb@kernel.org
Cc: linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org, amit.kachhap@linaro.org

Hi Len/Andrew,

This series is a repost of the thermal support for exynos platform.

This current patchset is based on 3.5-rc6 with hwmon-next branch merged.
(git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next)

Version v4 was accepted for 3.5 merge by Len.
(https://lkml.org/lkml/2012/6/2/7) but somehow could not go through.

I am aware that some work is going on for thermal framework improvement but
that will have minimal changes on cpufreq cooling APIs and I hope to fix them as
bug fix patches later.

Please consider them for 3.6 merge.

Thanks,
Amit Daniel


Amit Daniel Kachhap (5):
  thermal: add generic cpufreq cooling implementation
  hwmon: exynos4: move thermal sensor driver to driver/thermal
    directory
  thermal: exynos5: add exynos5 thermal sensor driver support
  thermal: exynos: register the tmu sensor with the kernel thermal
    layer
  ARM: exynos: add thermal sensor driver platform data support

 Documentation/hwmon/exynos4_tmu              |   81 ---
 Documentation/thermal/cpu-cooling-api.txt    |   60 ++
 Documentation/thermal/exynos_thermal         |   52 ++
 drivers/hwmon/Kconfig                        |   10 -
 drivers/hwmon/Makefile                       |    1 -
 drivers/hwmon/exynos4_tmu.c                  |  518 --------------
 drivers/thermal/Kconfig                      |   20 +
 drivers/thermal/Makefile                     |    4 +-
 drivers/thermal/cpu_cooling.c                |  483 +++++++++++++
 drivers/thermal/exynos_thermal.c             |  960 ++++++++++++++++++++++++++
 include/linux/cpu_cooling.h                  |   99 +++
 include/linux/platform_data/exynos4_tmu.h    |   83 ---
 include/linux/platform_data/exynos_thermal.h |  100 +++
 13 files changed, 1777 insertions(+), 694 deletions(-)
 delete mode 100644 Documentation/hwmon/exynos4_tmu
 create mode 100644 Documentation/thermal/cpu-cooling-api.txt
 create mode 100644 Documentation/thermal/exynos_thermal
 delete mode 100644 drivers/hwmon/exynos4_tmu.c
 create mode 100644 drivers/thermal/cpu_cooling.c
 create mode 100644 drivers/thermal/exynos_thermal.c
 create mode 100644 include/linux/cpu_cooling.h
 delete mode 100644 include/linux/platform_data/exynos4_tmu.h
 create mode 100644 include/linux/platform_data/exynos_thermal.h


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
