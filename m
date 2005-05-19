From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: [BK PATCH] I2C update for 2.6.7-rc1
Message-Id: <20040528215908.GA13626@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

Hi,

Here are some i2c driver fixes for 2.6.7-rc1.  There is also a new i2c
chip driver in here.  The majority of these patches have been in the
past few -mm releases.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.6

Individual patches will follow, sent to the sensors and linux-kernel
lists.

thanks,

greg k-h

 drivers/i2c/busses/Kconfig       |    8 
 drivers/i2c/busses/i2c-ibm_iic.c |   48 +++-
 drivers/i2c/busses/i2c-parport.h |   14 +
 drivers/i2c/chips/Kconfig        |   10 +
 drivers/i2c/chips/Makefile       |    1 
 drivers/i2c/chips/eeprom.c       |    5 
 drivers/i2c/chips/max1619.c      |  378 +++++++++++++++++++++++++++++++++++++++
 drivers/i2c/i2c-core.c           |   21 +-
 8 files changed, 457 insertions(+), 28 deletions(-)
-----

<faikuygur:tnn.net>:
  o I2C: use idr_get_new to allocate a bus id in drivers/i2c/i2c-core.c

<fishor:gmx.net>:
  o I2C: add max1619 driver

Eugene Surovegin:
  o I2C PPC4xx IIC driver: 0-length transaction temporary fix
  o I2C PPC4xx IIC driver: fix debug build with gcc3
  o I2C PPC4xx IIC driver: Kconfig cleanup
  o I2C PPC4xx IIC driver: upgrade to new OCP infrastructre

Jean Delvare:
  o I2C: i2c-parport: support the ADM1031 evaluation board
  o I2C: Incomplete AT24RF08 corruption prevention in i2c eeprom
