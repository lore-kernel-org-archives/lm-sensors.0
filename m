From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 16 Nov 2009 13:21:46 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.32
Message-Id: <20091116142146.6b0a9841@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091009205722.5434b5c2@hyperion.delvare>
In-Reply-To: <20091009205722.5434b5c2@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hi Linus,

Please pull some hwmon subsystem fixes for Linux 2.6.32 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

 drivers/hwmon/adt7475.c   |   17 ++++++++---------
 drivers/hwmon/s3c-hwmon.c |   11 +++++++++--
 2 files changed, 17 insertions(+), 11 deletions(-)

---------------

Ben Dooks (1):
      hwmon: (s3c-hwmon) Ignore invalid divider settings

Jean Delvare (3):
      hwmon: (adt7475) Fix temperature fault flags
      hwmon: (adt7475) Cache limits for 60 seconds
      hwmon: (adt7475) Fix sysfs file names

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
