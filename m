From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 27 Feb 2006 22:00:26 +0000
Subject: [lm-sensors] [PATCH 0/6] i2c and hwmon updates
Message-Id: <20060227230026.c133e839.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Here comes a 6-piece i2c and hwmon update patchset, containing some
cleanups I wrote or gathered in the last few weeks. They are all meant
for -mm, no 2.6.16 material here. This set is significantly smaller
than what I usually send, sorry about that, but I hardly have time to
do more these days.

Here's the summary:

Alessandro Zummo:
 o i2c-ixp4xx: Add hwmon class

Darren Jenkins:
 o hwmon: Rename register parameters

Jean Delvare:
 o i2c-ali1535: Drop a redundant mutex
 o i2c-amd756-s4882: Improve static mutex initialization
 o i2c: Drop unneeded i2c-dev.h includes

Martin Devera:
 o i2c-piix4: Add Broadcom HT-1000 support

Statistics:

 Documentation/i2c/busses/i2c-piix4    |    2 +-
 drivers/hwmon/adm1026.c               |    5 ++---
 drivers/hwmon/fscpos.c                |    4 ++--
 drivers/hwmon/it87.c                  |    5 ++---
 drivers/hwmon/lm78.c                  |    4 ++--
 drivers/hwmon/lm85.c                  |    4 ++--
 drivers/hwmon/sis5595.c               |    4 ++--
 drivers/hwmon/w83627hf.c              |    5 ++---
 drivers/hwmon/w83781d.c               |    5 ++---
 drivers/i2c/busses/Kconfig            |    4 +++-
 drivers/i2c/busses/i2c-ali1535.c      |    4 ----
 drivers/i2c/busses/i2c-amd756-s4882.c |    4 +---
 drivers/i2c/busses/i2c-ixp4xx.c       |    1 +
 drivers/i2c/busses/i2c-piix4.c        |    4 +++-
 drivers/media/video/adv7170.c         |    1 -
 drivers/media/video/adv7175.c         |    1 -
 drivers/media/video/bt819.c           |    1 -
 drivers/media/video/bt856.c           |    1 -
 drivers/media/video/saa7110.c         |    1 -
 drivers/media/video/saa7111.c         |    1 -
 drivers/media/video/saa7114.c         |    1 -
 drivers/media/video/saa711x.c         |    1 -
 drivers/media/video/saa7185.c         |    1 -
 drivers/media/video/vpx3220.c         |    1 -
 include/linux/pci_ids.h               |    1 +
 sound/oss/dmasound/dmasound_awacs.c   |    2 --
 sound/ppc/daca.c                      |    1 -
 sound/ppc/keywest.c                   |    1 -
 sound/ppc/toonie.c                    |    1 -
 sound/ppc/tumbler.c                   |    1 -
 30 files changed, 26 insertions(+), 46 deletions(-)

Thanks,
-- 
Jean Delvare

