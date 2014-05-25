From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 25 May 2014 15:45:44 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for Linux 3.15
Message-Id: <20140525174544.6b2e115a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Linus,

Please pull hwmon subsystem fixes for Linux 3.15 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

 Documentation/hwmon/sysfs-interface | 14 ++++++++++++++
 drivers/hwmon/Kconfig               |  2 +-
 drivers/hwmon/ntc_thermistor.c      | 15 +++++++++------
 3 files changed, 24 insertions(+), 7 deletions(-)

---------------

Jean Delvare (3):
      hwmon: Document temp[1-*]_min_hyst sysfs attribute
      hwmon: (ntc_thermistor) Fix dependencies
      hwmon: (ntc_thermistor) Fix OF device ID mapping

Thanks,
-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
