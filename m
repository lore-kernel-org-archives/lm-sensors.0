From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 02 Feb 2014 17:23:41 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for Linux 3.14
Message-Id: <20140202182341.5573d629@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Linus,

Please pull hwmon subsystem fixes for Linux 3.14 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

 drivers/hwmon/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

---------------

Jean Delvare (2):
      hwmon: Fix SENSORS_LM75 dependencies to eliminate build errors
      hwmon: Fix SENSORS_TMP102 dependencies to eliminate build errors

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
