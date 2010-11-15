From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 15 Nov 2010 21:04:50 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.37
Message-Id: <20101115220450.586f9a2c@endymion.delvare>
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

The bulk of it are late fixes to the new w83795 driver.

 drivers/hwmon/amc6821.c |    2 +-
 drivers/hwmon/lm93.c    |    4 +-
 drivers/hwmon/lm95241.c |   19 +++-
 drivers/hwmon/max6650.c |    2 +-
 drivers/hwmon/w83795.c  |  207 +++++++++++++++++++++++++++++++++++++++--------
 5 files changed, 192 insertions(+), 42 deletions(-)

---------------

Hans J. Koch (1):
      hwmon: Change mail address of Hans J. Koch

Jean Delvare (8):
      hwmon: (lm95241) Check validity of input values
      hwmon: (w83795) Fix fan control mode attributes
      hwmon: (w83795) Expose fan control method
      hwmon: (w83795) List all usable temperature sources
      hwmon: (w83795) Print the actual temperature channels as sources
      hwmon: (w83795) Read the intrusion state properly
      hwmon: (w83795) Clear intrusion alarm immediately
      hwmon: (w83795) Check for BEEP pin availability

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
