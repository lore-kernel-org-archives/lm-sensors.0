From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 15 Nov 2013 10:08:28 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes and updates for Linux 3.13
Message-Id: <20131115110828.60001526@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Linus,

Please pull hwmon subsystem updates for Linux 3.13 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

All lm90 driver fixes and improvements.

 Documentation/devicetree/bindings/hwmon/lm90.txt |  44 +++
 Documentation/hwmon/lm90                         |   6 +
 MAINTAINERS                                      |   1 +
 drivers/hwmon/lm90.c                             | 327 ++++++++++++++++-------
 4 files changed, 281 insertions(+), 97 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/lm90.txt

---------------

Guenter Roeck (1):
      hwmon: (lm90) Fix max6696 alarm handling

Wei Ni (6):
      hwmon: (lm90) Define status bits
      hwmon: (lm90) Add support to handle IRQ
      hwmon: (lm90) Use enums for the indexes of temp8 and temp11
      hwmon: (lm90) Add support for TI TMP451
      hwmon: (lm90) Add power control
      Documentation: dt: hwmon: Add OF document for LM90

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
