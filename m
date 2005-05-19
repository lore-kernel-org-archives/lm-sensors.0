From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:00 +0000
Subject: [BK PATCH] i2c driver changes for 2.5.72
Message-Id: <20030618182423.GB7699@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

Hi,

Here are some i2c driver changes for 2.5.72.  These consist of some
more bug fixes, and the addition of a lm78 i2c driver.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.5

thanks,

greg k-h

 drivers/i2c/busses/i2c-ali15x3.c |   18 
 drivers/i2c/busses/i2c-i801.c    |   10 
 drivers/i2c/chips/Kconfig        |   14 
 drivers/i2c/chips/Makefile       |    1 
 drivers/i2c/chips/adm1021.c      |   18 
 drivers/i2c/chips/lm78.c         |  895 +++++++++++++++++++++++++++++++++++++++
 drivers/i2c/chips/lm85.c         |   41 +
 drivers/i2c/chips/w83781d.c      |   86 ++-
 8 files changed, 1019 insertions(+), 64 deletions(-)
-----

<margitsw:t-online.de>:
  o I2C: Sensors patch for adm1021
  o I2C: lm85 fixups

<mhoffman:lightlink.com>:
  o I2C: w83781d bugfix
  o i2c: Add lm78 sensor chip support

Greg Kroah-Hartman:
  o I2C: fix resource leak in i2c-ali15x3.c
  o I2C: add lm78 chip to Makefile

Martin Schlemmer:
  o I2C: fix for previous W83627THF sensor chip patch
  o I2C: ICH5 SMBus and W83627THF additions
