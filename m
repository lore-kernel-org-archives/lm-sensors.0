From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:35 +0000
Subject: [BK PATCH] I2C fixes for 2.6.11-rc3
Message-Id: <20050203173745.GA24076@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

Hi,

Here are a few I2C bugfixes 2.6.11-rc3.  All of these patches have been
in the past few -mm releases.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/2.6.11-rc3/i2c

Patches will be posted to linux-kernel and sensors as a follow-up thread
for those who want to see them.

thanks,

greg k-h

 drivers/i2c/busses/i2c-sis5595.c |   15 +++++++----
 drivers/i2c/busses/i2c-viapro.c  |   33 ++++++++++++++++++--------
 drivers/i2c/chips/ds1621.c       |   12 ++++++---
 drivers/i2c/chips/it87.c         |   10 +++----
 drivers/i2c/chips/pc87360.c      |   49 +++++++++++++++++++++++++++------------
 drivers/i2c/chips/via686a.c      |   25 +++++++++++++------
 drivers/i2c/chips/w83781d.c      |   20 ++-------------
 7 files changed, 100 insertions(+), 64 deletions(-)
-----


Aurelien Jarno:
  o I2C: Fix DS1621 detection

Jean Delvare:
  o I2C: Prevent buffer overflow on SMBus block read in
  o I2C: Do not show disabled pc87360 fans
  o I2C: Fix i2c-sis5595 pci configuration accesses
  o I2C: Reduce it87 i2c address range
  o I2C: Use standard temperature converters for as99127f
  o I2C: Resolve resource conflict between i2c-viapro and via686a
