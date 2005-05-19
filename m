From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: [BK PATCH] I2C fixes for 2.6.11-rc1
Message-Id: <20050117214543.GB28400@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

Hi,

Here are some i2c driver fixes and updates for 2.6.11-rc1.  There is a
new chip and a new bus driver, as well as a bunch of minor fixes.  All
of these patches have been in the past few -mm releases.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.6

Individual patches will follow, sent to the sensors and linux-kernel
lists.

thanks,

greg k-h

 drivers/i2c/busses/Kconfig    |    6 -
 drivers/i2c/busses/i2c-i801.c |    2 
 drivers/i2c/busses/i2c-mpc.c  |  171 +++++++++++++++++++++++++------
 drivers/i2c/chips/adm1026.c   |   11 +-
 drivers/i2c/chips/eeprom.c    |   47 ++++----
 drivers/i2c/chips/it87.c      |  230 +++++++++++++++++++++++++++++++++---------
 drivers/i2c/chips/lm63.c      |    4 
 drivers/i2c/chips/lm85.c      |   76 +++++++++++--
 drivers/i2c/chips/via686a.c   |    9 -
 9 files changed, 427 insertions(+), 129 deletions(-)
-----


<jason.d.gaston:intel.com>:
  o I2C support for Intel ICH7 - 2.6.10 - resubmit

<rafael.espindola:gmail.com>:
  o I2C: add EMC6D100 support in lm85 driver

Greg Kroah-Hartman:
  o I2C: add MODULE_DEVICE_TABLE to via686a.c driver

Jean Delvare:
  o I2C: Improve it87 super-i/o detection
  o I2C: Cleanups to the eeprom driver
  o I2C: Fix bogus bitmask in lm63 debug message

Jonas Munsin:
  o I2C: fix it87 sensor driver stops CPU fan
  o I2C: it87 fan update

Justin Thiessen:
  o I2C: adm1026.c fixes

Kumar Gala:
  o I2C-MPC: Convert to platform_device driver
  o I2C-MPC: use wait_event_interruptible_timeout between transactions
