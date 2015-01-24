From: Jean Delvare <jdelvare@suse.de>
Date: Sat, 24 Jan 2015 16:54:27 +0000
Subject: [lm-sensors] [GIT PULL] hwmon updates for Linux 3.19
Message-Id: <20150124175427.1c2a25c5@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Linus,

Please pull hwmon subsystem updates for Linux 3.19 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

It contains a single thing: a new driver for the temperature sensor
embedded in the Intel 5500/5520/X58 chipsets. Sorry for the late
request, it's been so long since I last sent a pull request and I've
been so busy with other tasks meanwhile that I simply forgot about
these patches. But given that this is a new driver, it can't introduce
any regression so I thought it could still be OK. This has been in
linux-next for months now.

 drivers/hwmon/Kconfig      |  10 +++
 drivers/hwmon/Makefile     |   1 +
 drivers/hwmon/i5500_temp.c | 149 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 160 insertions(+)
 create mode 100644 drivers/hwmon/i5500_temp.c

---------------

Axel Lin (2):
      hwmon: (i5500_temp) Convert to module_pci_driver
      hwmon: (i5500_temp) Convert to use ATTRIBUTE_GROUPS macro

Jean Delvare (3):
      hwmon: (i5500_temp) New driver for the Intel 5500/5520/X58 chipsets
      hwmon: (i5500_temp) Convert to devm_hwmon_device_register_with_groups
      hwmon: (i5500_temp) Don't bind to disabled sensors

Thanks,
-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
