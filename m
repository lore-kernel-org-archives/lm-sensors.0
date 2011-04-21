From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 21 Apr 2011 00:48:48 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.39
Message-Id: <1303347743-32210-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1301169714-25636-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1301169714-25636-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Linus,

Please pull hwmon subsystem fixes for Linux 2.6.39 from:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus

Thanks,
Guenter Roeck

------

The following changes since commit f0e615c3cb72b42191b558c130409335812621d8:

  Linux 2.6.39-rc4 (2011-04-18 21:26:00 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus

Guenter Roeck (7):
      hwmon: Add submitting-patches checklist to documentation
      hwmon: (pmbus) Removed unused variable from struct pmbus_data
      hwmon: (smm665) Fix spelling error in driver documentation
      hwmon: (pmbus) Documentation updates
      hwmon: (max8688) Add driver documentation
      hwmon: (max16064) Add driver documentation
      hwmon: (max34440) Add driver documentation

 Documentation/hwmon/max16064           |   62 ++++++++++++++++++
 Documentation/hwmon/max34440           |   79 +++++++++++++++++++++++
 Documentation/hwmon/max8688            |   69 ++++++++++++++++++++
 Documentation/hwmon/pmbus              |   34 +++--------
 Documentation/hwmon/smm665             |    8 +-
 Documentation/hwmon/submitting-patches |  109 ++++++++++++++++++++++++++++++++
 drivers/hwmon/pmbus_core.c             |    1 -
 7 files changed, 331 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/hwmon/max16064
 create mode 100644 Documentation/hwmon/max34440
 create mode 100644 Documentation/hwmon/max8688
 create mode 100644 Documentation/hwmon/submitting-patches

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
