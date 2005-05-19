From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: [BK PATCH] i2c driver fixes for 2.6.3-rc1
Message-Id: <20040209231301.GA2393@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

Hi,

Here are some i2c driver updates for 2.6.3-rc1.  It's a few small
bugfixes and tree new i2c drivers.  All of the bugfixes and two of the
i2c drivers have been in the last few -mm trees with no problems.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.6

Individual patches will follow, sent to the sensors and linux-kernel
lists.

thanks,

greg k-h

 MAINTAINERS                    |   12 
 drivers/i2c/busses/Kconfig     |   12 
 drivers/i2c/busses/Makefile    |    1 
 drivers/i2c/busses/i2c-hydra.c |  186 +++++++++++
 drivers/i2c/chips/Kconfig      |   22 +
 drivers/i2c/chips/Makefile     |    2 
 drivers/i2c/chips/fscher.c     |  681 +++++++++++++++++++++++++++++++++++++++++
 drivers/i2c/chips/gl518sm.c    |  612 ++++++++++++++++++++++++++++++++++++
 drivers/i2c/chips/lm85.c       |    6 
 drivers/i2c/chips/w83l785ts.c  |   63 ++-
 drivers/i2c/i2c-core.c         |    2 
 include/linux/i2c-id.h         |    1 
 12 files changed, 1571 insertions(+), 29 deletions(-)
-----

<ender:debian.org>:
  o I2C: fix typos

Geert Uytterhoeven:
  o I2C: add Hydra i2c bus driver

Greg Kroah-Hartman:
  o I2C: fix oops when CONFIG_I2C_DEBUG_CORE is enabled and the bttv driver is loaded

Jean Delvare:
  o I2C: add new chip driver: fscher
  o I2C: Update I2C maintainers entry
  o I2C: add new driver, gl518sm
  o I2C: Handle read errors in w83l785ts
  o I2C: Bring w83l785ts in compliance with sysfs naming conventions
