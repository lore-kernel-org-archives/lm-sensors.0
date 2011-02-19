From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 19 Feb 2011 20:50:29 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.38
Message-Id: <1298148629-1817-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1296078744-21895-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1296078744-21895-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Linus,

Please pull hwmon subsystem fixes for Linux 2.6.38 from:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus

Besides the bug fixes, there is added support for AMD Family 12h/14h CPUs and
for EMC6D103. I included those because they meet requirements for submission
to stable (new device IDs).

Thanks,
Guenter Roeck

------

The following changes since commit 85e2efbb1db9a18d218006706d6e4fbeb0216213:

  Linux 2.6.38-rc5 (2011-02-15 19:23:45 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus

Clemens Ladisch (4):
      hwmon: (jc42) fix type mismatch
      hwmon: (jc42) more helpful documentation
      hwmon: (jc42) do not allow writing to locked registers
      hwmon: (k10temp) add support for AMD Family 12h/14h CPUs

Guenter Roeck (1):
      MAINTAINERS: Remove stale hwmon quilt tree

Jan Beulich (1):
      hwmon: (lm85) extend to support EMC6D103 chips

 Documentation/hwmon/jc42    |   21 +++++++++++++++------
 Documentation/hwmon/k10temp |    8 +++++++-
 MAINTAINERS                 |    1 -
 drivers/hwmon/Kconfig       |   19 ++++++++++---------
 drivers/hwmon/jc42.c        |   35 ++++++++++++++++++++++++++++++-----
 drivers/hwmon/k10temp.c     |    5 +++--
 drivers/hwmon/lm85.c        |   23 +++++++++++++++++++++--
 7 files changed, 86 insertions(+), 26 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
