From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:01 +0000
Subject: [BK PATCH] i2c driver changes for 2.5.73
Message-Id: <20030623234939.GA11901@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

Hi,

Here are some i2c driver changes for 2.5.73.  They add two new i2c bus
controller drivers.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.5

thanks,

greg k-h

 drivers/i2c/Kconfig              |   20 +
 drivers/i2c/Makefile             |    1 
 drivers/i2c/busses/Kconfig       |   16 +
 drivers/i2c/busses/Makefile      |    1 
 drivers/i2c/busses/i2c-ali1535.c |  555 +++++++++++++++++++++++++++++++++++++++
 drivers/i2c/i2c-prosavage.c      |  362 +++++++++++++++++++++++++
 6 files changed, 955 insertions(+)
-----

<henk:god.dyndns.org>:
  o I2C: add i2c-prosavage driver

Greg Kroah-Hartman:
  o I2C: add i2c-ali1535 bus driver
