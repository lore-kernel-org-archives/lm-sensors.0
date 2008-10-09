From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 09 Oct 2008 13:40:38 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.27
Message-Id: <20081009154038.64a329f2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080920103111.2f0f512b@hyperion.delvare>
In-Reply-To: <20080920103111.2f0f512b@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hi Linus,

Please pull hwmon subsystem fixes for Linux 2.6.27 from:

git://jdelvare.pck.nerim.net/jdelvare-2.6 hwmon-for-linus

 Documentation/hwmon/adt7473         |   18 ++------
 Documentation/hwmon/sysfs-interface |   12 ++++++
 drivers/hwmon/abituguru3.c          |    3 +-
 drivers/hwmon/it87.c                |   70 +++++++++++++++++++++++++---------
 drivers/misc/eeepc-laptop.c         |   16 ++++++-
 5 files changed, 83 insertions(+), 36 deletions(-)

---------------

Alistair John Strachan (2):
      hwmon: (abituguru3) Enable reading from AUX3 fan on Abit AT8 32X
      hwmon: (abituguru3) Enable DMI probing feature on Abit AT8 32X

Corentin Chary (1):
      eeepc-laptop: Fix hwmon interface

Darrick J. Wong (2):
      hwmon: Define sysfs interface for energy consumption register
      hwmon: (adt7473) Fix some bogosity in documentation file

Jean Delvare (1):
      hwmon: (it87) Prevent power-off on Shuttle SN68PT

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
