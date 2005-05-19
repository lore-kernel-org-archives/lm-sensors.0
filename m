From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: [BK PATCH] i2c driver fixes for 2.6.0-test2
Message-Id: <20030802052904.GA9782@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

Hi,

Here are some i2c driver fixes for 2.6.0-test2.  They include a number
of minor i2c fixes and add a new i2c bus controller driver.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.5

thanks,

greg k-h

 drivers/i2c/Kconfig              |    8 
 drivers/i2c/busses/Kconfig       |   17 +
 drivers/i2c/busses/Makefile      |    1 
 drivers/i2c/busses/i2c-ali1535.c |   20 -
 drivers/i2c/busses/i2c-ali15x3.c |   15 -
 drivers/i2c/busses/i2c-amd756.c  |   28 --
 drivers/i2c/busses/i2c-amd8111.c |    6 
 drivers/i2c/busses/i2c-i801.c    |   28 --
 drivers/i2c/busses/i2c-nforce2.c |  470 +++++++++++++++++++++++++++++++++++++--
 drivers/i2c/busses/i2c-piix4.c   |   20 -
 drivers/i2c/busses/i2c-sis96x.c  |   18 -
 drivers/i2c/busses/i2c-viapro.c  |   18 -
 drivers/i2c/chips/via686a.c      |   20 -
 drivers/i2c/i2c-keywest.c        |   90 +------
 include/linux/i2c.h              |    7 
 15 files changed, 529 insertions(+), 237 deletions(-)
-----

<nikkne:hotpop.com>:
  o I2C: fix Kconfig info

<patrick:dreker.de>:
  o I2C: add ncforce2 i2c bus driver

Benjamin Herrenschmidt:
  o I2C: timer clean up for i2c-keywest.c

Daniele Bellucci:
  o I2C: fixed a little memory leak in i2c-ali15x3.c

Greg Kroah-Hartman:
  o I2C: remove devinitdata marking from i2c-nforce2.c as it's wrong
  o I2C: consolidate the i2c delay functions
  o I2C: minor cleanups to the i2c-nforce2 driver

Jan Dittmer:
  o I2C: convert via686a temp_* to milli degree celsius
