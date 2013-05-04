From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 04 May 2013 13:56:43 +0000
Subject: [lm-sensors] [GIT PULL] hwmon updates for Linux 3.10
Message-Id: <20130504155643.1d3a6ca9@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Linus,

Please pull hwmon subsystem updates for Linux 3.10 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

Only lm75 driver updates this time.

 Documentation/hwmon/lm75 | 15 ++++----
 drivers/hwmon/Kconfig    |  2 +-
 drivers/hwmon/lm75.c     | 92 ++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 94 insertions(+), 15 deletions(-)

---------------

Jean Delvare (4):
      hwmon: (lm75) Per-chip configuration register initialization
      hwmon: (lm75) Prepare to support per-chip resolution and sample time
      hwmon: (lm75) Tune resolution and sample time per chip
      hwmon: (lm75) Add support for the Dallas/Maxim DS7505

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
