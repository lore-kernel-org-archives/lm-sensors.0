From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 17 Jun 2012 17:01:22 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for Linux 3.5
Message-Id: <20120617190122.48e05149@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Linus,

Please pull hwmon subsystem fixes for Linux 3.5 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

 Documentation/hwmon/coretemp |   22 +++++++++++++++++++++-
 drivers/hwmon/coretemp.c     |   33 +++++++++++++++++++++++++++++++--
 2 files changed, 52 insertions(+), 3 deletions(-)

---------------

Guenter Roeck (3):
      hwmon: (coretemp) Add support for Atom D2000 and N2000 series CPU models
      hwmon: (coretemp) Improve support for TjMax detection on Atom CPUs
      hwmon: (coretemp) Document TjMax for 3rd generation i5/i7 processors

Jean Delvare (2):
      hwmon: (coretemp) Improve support of recent Atom CPU models
      hwmon: (coretemp) Drop needless initialization

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
