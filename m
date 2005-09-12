From: gregkh@suse.de (Greg KH)
Date: Mon, 12 Sep 2005 22:10:27 +0000
Subject: [lm-sensors] [GIT PATCH] More I2C and hwmon patches for 2.6.13
Message-Id: <20050912200441.GA22930@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Here are some more i2c and hwmon patches.  They are all bugfixes, with
the exception of the addition of the new hdaps driver.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
or from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
if it isn't synced up yet.

The full patch series will sent to the sensors mailing lists, if anyone
wants to see them.

thanks,

greg k-h

 MAINTAINERS                      |    7 
 drivers/hwmon/Kconfig            |   17 
 drivers/hwmon/Makefile           |    1 
 drivers/hwmon/hdaps.c            |  739 +++++++++++++++++++++++++++++++++++++++
 drivers/hwmon/sis5595.c          |    5 
 drivers/hwmon/smsc47m1.c         |    4 
 drivers/hwmon/via686a.c          |    5 
 drivers/hwmon/w83627hf.c         |   14 
 drivers/i2c/busses/i2c-nforce2.c |    5 
 9 files changed, 779 insertions(+), 18 deletions(-)

Jean Delvare:
  hwmon: Update smsc47m1 head comment
  hwmon: fix sis5595, via686a force_addr module parameter
  hwmon: w83627hf: no reset by default
  I2C: i2c-nforce2: drop unused define

Robert Love:
  updated hdaps driver.

