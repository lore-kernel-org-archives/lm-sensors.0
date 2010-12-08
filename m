From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 08 Dec 2010 17:22:22 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.37
Message-Id: <20101208182222.247ea405@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1288978399-16583-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1288978399-16583-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hi Linus,

Please pull hwmon subsystem fixes for Linux 2.6.37 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

 drivers/hwmon/adm1026.c |   20 +++++++-------
 drivers/hwmon/it87.c    |   61 ++++++++++++++++++++++++++++++++++------------
 2 files changed, 55 insertions(+), 26 deletions(-)

---------------

Gabriele Gorla (2):
      hwmon: (adm1026) Fix setting fan_div
      hwmon: (adm1026) Allow 1 as a valid divider value

Jean Delvare (1):
      hwmon: (it87) Fix manual fan speed control on IT8721F

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
