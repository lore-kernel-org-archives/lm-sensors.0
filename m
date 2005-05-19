From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: [PATCH] I2C driver updates for 2.6.0-test11
Message-Id: <20031204223923.GA2600@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

Hi,

Here's a patch and a bk tree that contains all of the i2c fixes and
updates that aren't going to be sent for inclusion in the main kernel
tree until 2.6.0 comes out.

Everything in one patch against 2.6.0-test11 can be found at:
	kernel.org/pub/linux/kernel/people/gregkh/i2c/2.6/2.6.0-test11/i2c-devel-2.6.0-test11.patch

and a bk tree (if you want to pull the individual patches) can be found
at:
	bk://linuxusb.bkbits.net/i2c-devel-2.6

Here's a diffstat of the patch:

 Documentation/i2c/porting-clients |  121 +++++++++++
 Documentation/i2c/sysfs-interface |   33 ++-
 Documentation/i2c/writing-clients |   57 -----
 drivers/i2c/algos/i2c-algo-bit.c  |   96 ++++----
 drivers/i2c/busses/Kconfig        |    4 
 drivers/i2c/busses/i2c-piix4.c    |    9 
 drivers/i2c/busses/i2c-savage4.c  |   12 -
 drivers/i2c/busses/i2c-viapro.c   |    8 
 drivers/i2c/chips/Kconfig         |   11 +
 drivers/i2c/chips/Makefile        |    1 
 drivers/i2c/chips/it87.c          |   11 -
 drivers/i2c/chips/lm75.c          |    4 
 drivers/i2c/chips/lm78.c          |    4 
 drivers/i2c/chips/lm83.c          |  413 ++++++++++++++++++++++++++++++++++++++
 drivers/i2c/chips/via686a.c       |   46 ++--
 drivers/i2c/chips/w83781d.c       |   24 +-
 include/linux/i2c-id.h            |    1 
 17 files changed, 694 insertions(+), 161 deletions(-)


And the bitkeeper shortlog output is:

Jean Delvare:
  o I2C: it87 and via686a alarms
  o I2C: add KT600 support to i2c-viapro driver
  o I2C: add Serverworks CSB6 support to i2c-piix4
  o I2C: fix author of i2c-savage4.c driver
  o I2C: make I2C chipset drivers use temp_hyst[1-3]
  o I2C: sysfs interface documentation
  o I2C: Fix i2c-algo-bit for adapers that cannot read SCL back
  o I2C: i2c documentation (2 of 2)
  o I2C: i2c documentation (1 of 2)
  o I2C: Add lm83 chip driver



If anyone has sent me any i2c patches and you don't see them here,
please let me know as I think I've finally caught up with them all.

thanks,

greg k-h
