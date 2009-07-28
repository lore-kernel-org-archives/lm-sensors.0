From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 28 Jul 2009 16:51:32 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.31
Message-Id: <20090728185132.43bacebf@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090711142610.048b69f5@hyperion.delvare>
In-Reply-To: <20090711142610.048b69f5@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hi Linus,

Please pull some hwmon subsystem fixes for Linux 2.6.31 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

 drivers/hwmon/asus_atk0110.c |    6 +++++-
 drivers/hwmon/smsc47m1.c     |   11 +++++++++++
 2 files changed, 16 insertions(+), 1 deletions(-)

---------------

Jean Delvare (1):
      hwmon: (smsc47m1) Differentiate between LPC47M233 and LPC47M292

Luca Tettamanti (1):
      hwmon: (asus_atk0110) Fix upper limit readings

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
