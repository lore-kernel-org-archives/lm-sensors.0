From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 03 Jul 2015 17:28:59 +0000
Subject: [lm-sensors] [GIT PULL] hwmon updates for Linux 4.2
Message-Id: <20150703192859.5e3d43af@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Linus,

Please pull hwmon subsystem updates for Linux 4.2 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

 Documentation/hwmon/submitting-patches |  7 +++++++
 Documentation/hwmon/w83792d            | 18 +++++++++++++-----
 drivers/hwmon/w83627ehf.c              | 26 +++++---------------------
 drivers/hwmon/w83792d.c                | 27 ++++++++++++++++++++++-----
 4 files changed, 47 insertions(+), 31 deletions(-)

---------------

Fabian Frederick (1):
      hwmon: (w83627ehf) Use swap() in w82627ehf_swap_tempreg()

Jean Delvare (1):
      hwmon: Document which I2C addresses can be probed

Roger Lucas (1):
      hwmon: (w83792d) Additional PWM outputs support

Thanks,
-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
