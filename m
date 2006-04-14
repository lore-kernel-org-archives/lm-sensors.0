From: gregkh@suse.de (Greg KH)
Date: Fri, 14 Apr 2006 20:00:52 +0000
Subject: [lm-sensors] [GIT PATCH] I2C and hwmon bugfixes for 2.6.17-rc1
Message-Id: <20060414200052.GA5559@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Here are some i2c and hwmon fixes for against your current git tree.
They all have been in the -mm tree for a few weeks.

They fix a number of various bugs in the different i2c and hwmon
drivers, and update the documentation a bit.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
or from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
if it isn't synced up yet.

The full patch series will sent to the sensors mailing list, if anyone
wants to see them.

thanks,

greg k-h


 Documentation/i2c/busses/i2c-parport   |   16 ++++++++++------
 drivers/hwmon/w83792d.c                |    5 +++--
 drivers/i2c/busses/Kconfig             |    5 ++++-
 drivers/i2c/busses/i2c-parport-light.c |    9 +++++++--
 drivers/i2c/busses/i2c-parport.c       |    9 +++++++--
 drivers/i2c/busses/i2c-parport.h       |    2 +-
 drivers/i2c/busses/i2c-sis96x.c        |    8 --------
 drivers/i2c/chips/ds1374.c             |   16 ++++++++++------
 drivers/i2c/chips/m41t00.c             |   16 +++++++++-------
 9 files changed, 51 insertions(+), 35 deletions(-)

---------------

Jean Delvare:
      i2c: convert ds1374 to use a workqueue
      w83792d: Be quiet on misdetection

Mark A. Greer:
      i2c: convert m41t00 to use a workqueue

Mark M. Hoffman:
      i2c-sis96x: Remove an init-time log message
      i2c-parport: Make type parameter mandatory


