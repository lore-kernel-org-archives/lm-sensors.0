From: kbuild test robot <fengguang.wu@intel.com>
Date: Sun, 23 Dec 2012 19:39:53 +0000
Subject: [lm-sensors] coretemp.c:(.text+0x12cc56e): undefined reference to `__divdi3'
Message-Id: <50d75e09.JvGELCmHUG8sX0lp%fengguang.wu@intel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-staging
head:   5722b1cb8c0d3bb13a0077de60cfe0a63a64fa17
commit: 5722b1cb8c0d3bb13a0077de60cfe0a63a64fa17 hwmon: (coretemp) Report package power and energy consumption
date:   25 hours ago
config: make ARCH=i386 allyesconfig

All error/warnings:

drivers/built-in.o: In function `coretemp_rapl_work':
coretemp.c:(.text+0x12cc56e): undefined reference to `__divdi3'
drivers/built-in.o: In function `show_power_cap':
coretemp.c:(.text+0x12cc611): undefined reference to `__divdi3'
drivers/built-in.o: In function `coretemp_add_core':
coretemp.c:(.cpuinit.text+0xfe1): undefined reference to `__divdi3'

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
