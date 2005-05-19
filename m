From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: [BK PATCH] I2C fixes for 2.6.10-rc2
Message-Id: <20041119215935.GA15956@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

Hi,

Here are some i2c driver fixes for 2.6.10-rc2.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.6

Individual patches will follow, sent to the sensors and linux-kernel
lists.

thanks,

greg k-h

 Documentation/i2c/writing-clients     |   20 ++++++++++++++++----
 drivers/i2c/busses/Kconfig            |    1 +
 drivers/i2c/busses/i2c-amd756-s4882.c |    7 +++++--
 drivers/i2c/busses/i2c-nforce2.c      |    9 ++++-----
 drivers/i2c/chips/smsc47m1.c          |   29 +++++++++++++++++++++--------
 drivers/i2c/i2c-core.c                |   20 --------------------
 include/linux/pci_ids.h               |    2 ++
 7 files changed, 49 insertions(+), 39 deletions(-)
-----


<thomas:plx.com>:
  o I2C: i2c-nforce2.c add support for nForce3 Pro 150 MCP

Gabriel Paubert:
  o I2C: minor comment fix

Jean Delvare:
  o I2C: Cleanups to the recent smbus functions removal
  o I2C: Fixes to the i2c-amd756-s4882 driver
  o I2C: Do not register useless smsc47m1
