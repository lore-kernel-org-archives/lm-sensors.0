From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: [BK PATCH] i2c driver fix for 2.6.0-test11
Message-Id: <20031204222752.GA2541@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

Hi,

Here is a i2c driver fixes for 2.6.0-test11.  It fixes an problem in the
i2c-nforce2 driver when it is used to talk to the eeprom i2c driver.

Please pull from:  bk://linuxusb.bkbits.net/i2c-2.6

thanks,

greg k-h

 drivers/i2c/busses/i2c-nforce2.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
-----

Jean Delvare:
  o I2C: fix i2c_smbus_write_byte() for i2c-nforce2
