From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 03 Feb 2015 18:53:53 +0000
Subject: [lm-sensors] [hwmon:hwmon-next 19/19] drivers/hwmon/tmp102.c:284:1: sparse: symbol 'tmp102_dev_pm_op
Message-Id: <201502040243.7wsydeCr%fengguang.wu@intel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
head:   8170089e3c31b8b50ef5d2e21bdf20d7b7fa95b7
commit: 8170089e3c31b8b50ef5d2e21bdf20d7b7fa95b7 [19/19] hwmon: (tmp102) add hibernation callbacks
reproduce:
  # apt-get install sparse
  git checkout 8170089e3c31b8b50ef5d2e21bdf20d7b7fa95b7
  make ARCH=x86_64 allmodconfig
  make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/hwmon/tmp102.c:284:1: sparse: symbol 'tmp102_dev_pm_ops' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
