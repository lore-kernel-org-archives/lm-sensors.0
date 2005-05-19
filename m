From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: [BK PATCH] I2C update for 2.6.8-rc1
Message-Id: <20040715000527.GA18923@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

Hi,

Here are some i2c driver fixes and updates for 2.6.8-rc1.  There are a
few new i2c chip drivers, and the biggest chunk is the new w1 (1-wire)
driver subsystem contributed by Evgeniy Polyakov.  The sysfs interface
for w1 isn't finished quite yet (just need to create some more sysfs
files, nothing major), but the main functionality is there, and this
allows more w1 drivers to be contributed easier.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.6

Individual patches will follow, sent to the sensors and linux-kernel
lists.

thanks,

greg k-h

 Documentation/i2c/i2c-pport      |   45 -
 Documentation/i2c/i2c-velleman   |   20 
 Documentation/i2c/i2c-parport    |  156 +++++
 MAINTAINERS                      |   12 
 drivers/Kconfig                  |    2 
 drivers/Makefile                 |    1 
 drivers/i2c/busses/i2c-elektor.c |    6 
 drivers/i2c/busses/i2c-ibm_iic.c |  132 ++++-
 drivers/i2c/busses/scx200_acb.c  |    1 
 drivers/i2c/chips/Kconfig        |   42 +
 drivers/i2c/chips/Makefile       |    3 
 drivers/i2c/chips/adm1025.c      |  570 +++++++++++++++++++++
 drivers/i2c/chips/adm1031.c      | 1021 ++++++++++++++++++++++++++++++++++++++-
 drivers/i2c/chips/lm75.c         |   37 +
 drivers/i2c/chips/lm77.c         |  413 +++++++++++++++
 drivers/i2c/chips/lm78.c         |   88 ---
 drivers/i2c/chips/lm90.c         |   69 +-
 drivers/i2c/i2c-dev.c            |   33 -
 drivers/pci/quirks.c             |   58 +-
 drivers/w1/Kconfig               |   31 +
 drivers/w1/Makefile              |    9 
 drivers/w1/matrox_w1.c           |  246 +++++++++
 drivers/w1/w1.c                  |  623 +++++++++++++++++++++++
 drivers/w1/w1.h                  |  112 ++++
 drivers/w1/w1_family.c           |  133 +++++
 drivers/w1/w1_family.h           |   65 ++
 drivers/w1/w1_int.c              |  207 +++++++
 drivers/w1/w1_int.h              |   36 +
 drivers/w1/w1_io.c               |  138 +++++
 drivers/w1/w1_io.h               |   35 +
 drivers/w1/w1_log.h              |   38 +
 drivers/w1/w1_netlink.c          |   55 ++
 drivers/w1/w1_netlink.h          |   44 +
 drivers/w1/w1_therm.c            |  177 ++++++
 34 files changed, 4411 insertions(+), 247 deletions(-)
-----

<alex:alexdalton.org>:
  o I2C: small ADM1030 fix
  o I2C: ADM1030 and Co sensors chips support

<drewie:freemail.hu>:
  o I2C: Add support for LM77

<orange:fobie.net>:
  o I2C: patch quirks.c - SMBus hidden on hp laptop

Eugene Surovegin:
  o I2C PPC4xx IIC driver: 0-length transactions bit-banging implementation

Greg Kroah-Hartman:
  o 1 Wire: add Dallas 1-wire protocol driver subsystem
  o I2C: sparse cleanups for a few i2c drivers

Jean Delvare:
  o I2C: Refine detection of LM75 chips
  o I2C: adm1025 driver ported to 2.6
  o I2C: remove Documentation for i2c-pport
  o I2C: Documentation for i2c-parport
  o I2C: Add support for LM86, MAX6657 and MAX6658 to lm90
  o I2C: Class of scx200_acb

Luiz Capitulino:
  o I2C: i2c/i2c-dev.c::i2c_dev_init() cleanup

Mark M. Hoffman:
  o I2C: Remove extra inits from lm78 driver
