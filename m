From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 04 Oct 2008 09:44:57 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.27
Message-Id: <20081004114457.27a2fd70@hyperion.delvare>
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

 drivers/hwmon/it87.c        |   70 +++++++++++++++++++++++++++++++-----------
 drivers/misc/eeepc-laptop.c |   16 ++++++++--
 2 files changed, 64 insertions(+), 22 deletions(-)

---------------

Corentin Chary (1):
      eeepc-laptop: Fix hwmon interface

Jean Delvare (1):
      hwmon: (it87) Prevent power-off on Shuttle SN68PT

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
