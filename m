From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: [BK PATCH] i2c driver changes for 2.6.0-test1
Message-Id: <20030719155233.GA11754@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

Hi,

Here are some i2c driver fixes for 2.6.0-test1.  They include a number
of minor i2c fixes and add a new i2c bus controller driver.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.5

thanks,

greg k-h

 drivers/i2c/Kconfig              |    4 
 drivers/i2c/busses/Kconfig       |   17 +
 drivers/i2c/busses/Makefile      |    1 
 drivers/i2c/busses/i2c-ali1535.c |   10 
 drivers/i2c/busses/i2c-ali15x3.c |   11 
 drivers/i2c/busses/i2c-amd756.c  |   14 -
 drivers/i2c/busses/i2c-amd8111.c |    3 
 drivers/i2c/busses/i2c-i801.c    |   14 -
 drivers/i2c/busses/i2c-nforce2.c |  468 +++++++++++++++++++++++++++++++++++++--
 drivers/i2c/busses/i2c-piix4.c   |   10 
 drivers/i2c/busses/i2c-sis96x.c  |    9 
 drivers/i2c/busses/i2c-viapro.c  |    9 
 drivers/i2c/chips/via686a.c      |   10 
 drivers/i2c/i2c-keywest.c        |   90 +------
 include/linux/i2c.h              |    7 
 15 files changed, 508 insertions(+), 169 deletions(-)
-----

<j.dittmer@portrix.net>:
  o I2C: convert via686a temp_* to milli degree celsius

<nikkne@hotpop.com>:
  o I2C: fix Kconfig info

<patrick@dreker.de>:
  o I2C: add ncforce2 i2c bus driver

Benjamin Herrenschmidt <benh@kernel.crashing.org>:
  o I2C: timer clean up for i2c-keywest.c

Greg Kroah-Hartman <greg@kroah.com>:
  o I2C: consolidate the i2c delay functions
  o I2C: minor cleanups to the i2c-nforce2 driver
