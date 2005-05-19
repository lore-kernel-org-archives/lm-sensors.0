From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: [BK PATCH] i2c driver fixes for 2.6.2-rc2
Message-Id: <20040127233242.GA28891@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

Hi,

Here are some i2c driver fixes for 2.6.2-rc2.  It's all a bit of small
bugfixes and documentation updates.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.6

Individual patches will follow, sent to the sensors and linux-kernel
lists.

thanks,

greg k-h

 Documentation/i2c/porting-clients    |    5 --
 drivers/i2c/busses/i2c-parport.h     |    7 ++-
 drivers/i2c/busses/i2c-philips-par.c |    4 +-
 drivers/i2c/busses/i2c-piix4.c       |   48 +++++++++++++-----------
 drivers/i2c/chips/lm75.c             |   12 +++---
 drivers/i2c/chips/lm78.c             |   12 +++---
 drivers/i2c/chips/lm85.c             |   69 ++++++++++-------------------------
 7 files changed, 67 insertions(+), 90 deletions(-)
-----


Greg Kroah-Hartman:
  o I2C: remove printk() calls in lm85, and clean up debug logic

Jean Delvare:
  o I2C: Bring lm75 and lm78 in compliance with sysfs naming conventions
  o I2C: Add ADM1025EB support to i2c-parport
  o I2C: Fix bus reset in i2c-philips-par
  o I2C: undo documentation change

Mark M. Hoffman:
  o I2C: i2c-piix4.c bugfix
