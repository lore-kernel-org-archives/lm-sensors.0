From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 06 Sep 2011 16:13:28 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 3.1
Message-Id: <1315325608-17922-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Linus,

Please pull hwmon subsystem fixes for Linux 3.1 from:

    git://github.com/groeck/linux.git hwmon-for-linus

Thanks,
Guenter Roeck

------

The following changes since commit ddf28352b80c86754a6424e3a61e8bdf9213b3c7:

  Linux 3.1-rc5 (2011-09-04 15:45:10 -0700)

are available in the git repository at:
  git://github.com/groeck/linux.git hwmon-for-linus

Guenter Roeck (2):
      hwmon: (max16065) Fix current calculation
      hwmon: (max16065) Add chip access warning to documentation

Jean Delvare (1):
      hwmon: (ucd9000/ucd9200) Optimize array walk

 Documentation/hwmon/max16065  |    7 +++++++
 drivers/hwmon/max16065.c      |    2 +-
 drivers/hwmon/pmbus/ucd9000.c |    6 ++----
 drivers/hwmon/pmbus/ucd9200.c |    6 ++----
 4 files changed, 12 insertions(+), 9 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
