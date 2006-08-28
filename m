From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 28 Aug 2006 12:00:20 +0000
Subject: [lm-sensors] [PATCH 00/14] hwmon updates for 2.6.19
Message-Id: <20060828140020.61c81eb0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Here comes a 14-piece hwmon update patchset. There is a new driver for
the thermal sensors embedded in AMD K8 CPUs, many fixes and
improvements to the it87 driver, including support for the IT8716F and
IT8718F, and a few other things. All these patches should go to -mm for
now, and to 2.6.19 later.

Here's the summary:

Alexey Dobriyan:
 o atxp1: Signed/unsigned char bug fix

Dmitry Torokhov:
 o hdaps: Handle errors from input_register_device

Jean Delvare:
 o smsc47m1: dev_warn fix
 o it87: Add support for the IT8716F
 o it87: No sysfs files for disabled fans
 o it87: Prevent overflow on fan clock divider write
 o it87: in8 has no limit registers
 o it87: Cleanup set_fan_div
 o it87: Add support for the IT8718F
 o it87: Overwrite broken default limits
 o it87: Copyright update
 o k8temp: Enable automatic loading

Hans de Goede:
 o abituguru: Add suspend/resume support

Rudolf Marek:
 o hwmon: New driver k8temp

Statistics:

 Documentation/hwmon/it87  |   61 +++++++--
 drivers/hwmon/Kconfig     |   14 ++
 drivers/hwmon/Makefile    |    1 +
 drivers/hwmon/abituguru.c |   30 ++++-
 drivers/hwmon/atxp1.c     |    3 -
 drivers/hwmon/hdaps.c     |    6 +
 drivers/hwmon/it87.c      |  299 +++++++++++++++++++++++++++++++++++++--------
 drivers/hwmon/k8temp.c    |  294 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/hwmon/smsc47m1.c  |    3 +
 include/linux/pci_ids.h   |    1 +
 10 files changed, 637 insertions(+), 75 deletions(-)

-- 
Jean Delvare

