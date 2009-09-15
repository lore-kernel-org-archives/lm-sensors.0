From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 15 Sep 2009 15:59:01 +0000
Subject: [lm-sensors] [GIT PULL] hwmon updates for 2.6.32, round 1
Message-Id: <20090915175901.6c58c83e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull some hwmon subsystem updates for Linux 2.6.32 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

There's one new driver (tmp421 for Texas Instruments TMP421, TMP422 and
TMP423 thermal sensor chips) and random cleanups and fixes.

I will probably have some more patches later for kernel 2.6.32, when I
am done processing my backlog.

 Documentation/hwmon/pcf8591 |   28 ++--
 Documentation/hwmon/tmp421  |   36 +++++
 MAINTAINERS                 |    6 +
 drivers/hwmon/Kconfig       |  110 ++++++++------
 drivers/hwmon/Makefile      |    7 +-
 drivers/hwmon/abituguru.c   |    2 +-
 drivers/hwmon/abituguru3.c  |   79 +++++-----
 drivers/hwmon/applesmc.c    |    2 +-
 drivers/hwmon/dme1737.c     |    2 +-
 drivers/hwmon/f71805f.c     |    2 +-
 drivers/hwmon/hdaps.c       |    3 +-
 drivers/hwmon/hwmon-vid.c   |   10 +-
 drivers/hwmon/it87.c        |    2 +-
 drivers/hwmon/lm78.c        |    2 +-
 drivers/hwmon/lm85.c        |   32 ++++
 drivers/hwmon/pc87360.c     |    2 +-
 drivers/hwmon/pc87427.c     |    8 +-
 drivers/hwmon/sis5595.c     |    2 +-
 drivers/hwmon/smsc47b397.c  |    2 +-
 drivers/hwmon/smsc47m1.c    |    2 +-
 drivers/hwmon/tmp421.c      |  347 +++++++++++++++++++++++++++++++++++++++++++
 drivers/hwmon/via686a.c     |    2 +-
 drivers/hwmon/vt1211.c      |    8 +-
 drivers/hwmon/vt8231.c      |    2 +-
 drivers/hwmon/w83627ehf.c   |    2 +-
 drivers/hwmon/w83627hf.c    |    2 +-
 drivers/hwmon/w83781d.c     |    2 +-
 27 files changed, 579 insertions(+), 125 deletions(-)
 create mode 100644 Documentation/hwmon/tmp421
 create mode 100644 drivers/hwmon/tmp421.c

---------------

Alistair John Strachan (1):
      hwmon: (abituguru3) Support multiple DMI strings per chip ID

Andre Prendel (2):
      hwmon: Add driver for Texas Instruments TMP421/422/423 sensor chips
      hwmon: (tmp421) Add documentation

H Hartley Sweeten (1):
      hwmon: Include <linux/io.h> instead of <asm/io.h>

Jean Delvare (4):
      hwmon-vid: Ignore 6th VID pin of AMD family 0Fh processors
      hwmon: Clearly mark ACPI drivers as such
      hwmon: (pcf8591) Documentation clean-ups
      hwmon: (lm85) Don't bind to Winbond/Nuvoton WPCD377I

Julia Lawall (1):
      hwmon: Use resource_size

Luca Tettamanti (1):
      hwmon: (asus_atk0110) Add maintainer information

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
