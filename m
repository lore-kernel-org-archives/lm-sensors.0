From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:56 +0000
Subject: [BK PATCH] Yet more i2c driver changes for 2.5.69
Message-Id: <20030519231156.GA27535@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030323080719.GD26145@kroah.com>
In-Reply-To: <20030323080719.GD26145@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

Hi,

Here are yet more minor i2c fixups for 2.5.69.  They add another i2c bus
driver, and fix some bugs in the existing drivers (i287 and i2c-dev.)

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.5

thanks,

greg k-h

 drivers/i2c/busses/Kconfig      |   25 ++
 drivers/i2c/busses/Makefile     |    1 
 drivers/i2c/busses/i2c-piix4.c  |    4 
 drivers/i2c/busses/i2c-sis96x.c |  376 ++++++++++++++++++++++++++++++++++++++++
 drivers/i2c/chips/it87.c        |    1 
 drivers/i2c/i2c-dev.c           |  228 +++++++++++++++++-------
 drivers/pci/quirks.c            |   80 ++++++++
 include/linux/i2c-id.h          |    2 
 include/linux/pci_ids.h         |    3 
 9 files changed, 648 insertions(+), 72 deletions(-)
-----

<mhoffman:lightlink.com>:
  o i2c: Add SiS96x I2C/SMBus driver

<warp:mercury.d2dc.net>:
  o I2C: And yet another it87 patch

Greg Kroah-Hartman:
  o i2c: fix up i2c-dev driver based on previous core changes
  o i2c: piix4 driver: turn common error message to a debug level and rename the sysfs driver name
