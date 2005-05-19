From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: [BK PATCH] I2C fixes for 2.6.10-rc1
Message-Id: <20041112232604.GA17203@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

Hi,

Here are a few small i2c bugfixes for 2.6.10-rc1

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.6

Individual patches will follow, sent to the sensors and linux-kernel
lists.

That's it, bug fixes only from me for now till 2.6.10 is out :)

thanks,

greg k-h

 Documentation/i2c/dev-interface |    4 +--
 drivers/i2c/chips/rtc8564.c     |    3 ++
 drivers/i2c/i2c-core.c          |   19 +++++++++++++++++-
 drivers/i2c/i2c-dev.c           |    2 -
 drivers/i2c/i2c-sensor-detect.c |    2 -
 include/linux/i2c.h             |   16 +++------------
 sound/ppc/daca.c                |   24 ++++++++++++-----------
 sound/ppc/pmac.h                |    2 -
 sound/ppc/tumbler.c             |   41 ++++++++++++++++++++++------------------
 9 files changed, 65 insertions(+), 48 deletions(-)
-----

Gabriel Paubert:
  o I2C: Recent I2C "dead code removal" breaks pmac sound

Greg Kroah-Hartman:
  o I2C: fix up rtc8564 which should not have been changed in my previous cleanups
  o I2C: fix up some out of date Documentation

Jean Delvare:
  o I2C: Missing newlines in debug messages
