From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 06 Aug 2008 20:53:18 +0000
Subject: [lm-sensors] [GIT PULL] hwmon updates for 2.6.27
Message-Id: <20080806225318.3d1ce657@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

Hi Linus,

Please pull hwmon subsystem updates for Linux 2.6.27 from:

git://jdelvare.pck.nerim.net/jdelvare-2.6 hwmon-for-linus

In the absence of a maintainer for the hwmon subsystem, I have gathered
a number of patches which have been posted to the lm-sensors mailing
list over the past few months and reviewed publicly. This will ensure
that these patches, which I consider ready for upstream, aren't lost,
so developers can spend their time to something else than resending
these patches over and over again. This will also make an hypothetical
future hwmon subsystem maintainer's job easier by limiting the backlog
he or she would have to go through.

There is one new temperature driver (ad7414) and support for a new
device (SMSC SCH5027.) The rest is random driver fixes and improvements
- no core changes.


 Documentation/hwmon/dme1737  |   53 ++++++---
 Documentation/hwmon/it87     |   13 +-
 Documentation/hwmon/w83627hf |    4 -
 Documentation/hwmon/w83791d  |    6 +-
 drivers/hwmon/Kconfig        |   16 ++-
 drivers/hwmon/Makefile       |    1 +
 drivers/hwmon/ad7414.c       |  268 ++++++++++++++++++++++++++++++++++++++
 drivers/hwmon/dme1737.c      |  292 ++++++++++++++++++++++++++----------------
 drivers/hwmon/f71882fg.c     |    6 -
 drivers/hwmon/hwmon-vid.c    |  144 +++++++++++-----------
 drivers/hwmon/it87.c         |   45 +++++--
 drivers/hwmon/thmc50.c       |   28 ++++-
 drivers/hwmon/w83627hf.c     |  101 +++++++++++----
 drivers/hwmon/w83791d.c      |   24 +++-
 14 files changed, 734 insertions(+), 267 deletions(-)
 create mode 100644 drivers/hwmon/ad7414.c

---------------

Andrew Paprocki (2):
      hwmon: (it87) Support for 16-bit fan reading in it8712 >= rev 0x07
      hwmon: (it87) Support for 16-bit fan reading in it8705 >= rev 0x03

Dominik Geyer (1):
      hwmon: (w83627hf) Add pwm_enable sysfs interface

Frank Myhr (2):
      hwmon: (hwmon-vid) Trivial format multi-line comments per CodingStyle
      hwmon: (hwmon-vid) Add 6-bit vid codes for AMD NPT 0Fh cpus

Grant Coady (1):
      hwmon: (adm9240) Remove EXPERIMENTAL dependency

Jean Delvare (2):
      hwmon: (f71882fg) Delete needless forward declarations
      hwmon: (w83627hf) Drop reset module parameter

Juerg Haefliger (3):
      hwmon: (dme1737) Cleanups
      hwmon: (dme1737) Skip detection if forced
      hwmon: (dme1737) Add support for the SMSC SCH5027

Krzysztof Helt (1):
      hwmon: (thmc50) Add support for critical temperature limits

Marc Hulsman (1):
      hwmon: (w83791d) Use fan divisor bits from vbat register

Sean MacLennan (1):
      hwmon: ad7414 driver


Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
