From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: [BK PATCH] I2C fixes for 2.6.10-rc2
Message-Id: <20041201001245.GA27535@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041119215935.GA15956@kroah.com>
In-Reply-To: <20041119215935.GA15956@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

Hi,

Here are some i2c driver fixes and the addition of a new chip driver for
2.6.10-rc2 (it is self-contained) for 2.6.10-rc2

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.6

Individual patches will follow, sent to the sensors and linux-kernel
lists.

thanks,

greg k-h

 drivers/i2c/busses/i2c-elektor.c     |   28 
 drivers/i2c/busses/i2c-ite.c         |   31 
 drivers/i2c/busses/i2c-nforce2.c     |    9 
 drivers/i2c/chips/Kconfig            |    9 
 drivers/i2c/chips/Makefile           |    1 
 drivers/i2c/chips/adm1026.c          | 1781 ++++++++++++++++++++++++++++++++++-
 drivers/i2c/chips/w83l785ts.c        |    9 
 drivers/macintosh/therm_adt746x.c    |   11 
 drivers/macintosh/therm_pm72.c       |    3 
 drivers/macintosh/therm_windtunnel.c |    8 
 drivers/w1/Kconfig                   |    2 
 drivers/w1/dscore.c                  |   40 
 drivers/w1/dscore.h                  |   34 
 drivers/w1/w1_int.c                  |   11 
 drivers/w1/w1_netlink.c              |    3 
 include/linux/pci_ids.h              |    1 
 16 files changed, 1902 insertions(+), 79 deletions(-)
-----

<jthiessen:penguincomputing.com>:
  o I2C: add adm1026 chip driver

Aristeu Sergio Rozanski Filho:
  o i2c-ite: get rid of cli()/sti()
  o [2/2] i2c-elektor: adding missing casts
  o i2c-elektor: get rid of cli/sti

Evgeniy Polyakov:
  o W1: check nls in return path
  o drivers/w1/dscore: fix the inline mess
  o w1: make W1_DS9490_BRIDGE available
  o w1: do not stop and oops if netlink socket was not allocated

Greg Kroah-Hartman:
  o I2C: make fixup_fan_min static in adm1026 driver

Jean Delvare:
  o I2C: macintoch/therm_* drivers cleanups
  o I2C: Add support for the nForce2 Ultra 400 to i2c-nforce2
  o I2C: More verbose w83l785ts driver
