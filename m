From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: [BK PATCH] More i2c driver changes for 2.5.70
Message-Id: <20030611203544.GA26458@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030322010405.GA18613@kroah.com>
In-Reply-To: <20030322010405.GA18613@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

Hi,

Here are some more i2c driver changes for 2.5.70.  These consist of a new i2c
client driver, a new i2c bus driver, some coding style fixes for the new bus
driver, and a bunch of sparse warning removels.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.5

thanks,

greg k-h

-----

 drivers/i2c/Kconfig        |    4 
 drivers/i2c/Makefile       |    1 
 drivers/i2c/chips/Kconfig  |   19 
 drivers/i2c/chips/Makefile |    1 
 drivers/i2c/chips/lm85.c   | 1223 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/i2c/i2c-core.c     |   36 -
 drivers/i2c/i2c-dev.c      |   10 
 drivers/i2c/i2c-iop3xx.c   |  868 +++++++++++++++++++++++++------
 drivers/i2c/i2c-iop3xx.h   |  238 ++++++--
 include/linux/i2c-dev.h    |    6 
 include/linux/i2c.h        |    4 
 11 files changed, 2150 insertions(+), 260 deletions(-)
-----

<margitsw:t-online.de>:
  o I2C: add LM85 driver

<peterm:remware.demon.co.uk>:
  o I2C: add New bus driver: XSCALE iop3xx

Greg Kroah-Hartman:
  o I2C: fix up sparse warnings in the i2c-dev driver
  o I2C: fix up sparse warnings in drivers/i2c/i2c-core.c
  o I2C: fix some errors found by sparse in include/linux/i2c.h
  o I2C: coding style updates for i2c-iop3xx driver
