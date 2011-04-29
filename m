From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 29 Apr 2011 15:36:27 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.39
Message-Id: <20110429173627.11b02646@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1301169714-25636-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1301169714-25636-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>, rob@curates-egg.org

Hi Linus,

Please pull hwmon subsystem fixes for Linux 2.6.39 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

 Documentation/hwmon/adm1021 |   36 +++++++++++++++++++-----------------
 Documentation/hwmon/lm90    |   29 ++++++++++++++++++++---------
 drivers/hwmon/Kconfig       |   11 +++++------
 drivers/hwmon/lm85.c        |    6 ++++--
 drivers/hwmon/lm90.c        |   22 +++++++++++++++-------
 5 files changed, 63 insertions(+), 41 deletions(-)

---------------

Guenter Roeck (2):
      hwmon: (lm90) Add support for ADT7461A and NCT1008
      hwmon: (lm90) Fix update interval information in driver documentation

Jean Delvare (3):
      hwmon: (adm1021) Clarify documentation regarding Xeon processors
      hwmon: (lm85) Add missing list terminators
      hwmon: (lm85) Fix error paths in probe function

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
