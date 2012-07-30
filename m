From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 30 Jul 2012 09:42:46 +0000
Subject: [lm-sensors] [GIT PULL] hwmon update for Linux 3.6
Message-Id: <20120730114246.11ae98c7@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Linus,

Please pull one hwmon subsystem update for Linux 3.6 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

 drivers/hwmon/coretemp.c    |    2 +-
 drivers/hwmon/via-cputemp.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

---------------

Jan Beulich (1):
      hwmon: struct x86_cpu_id arrays can be __initconst

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
