From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:54 +0000
Subject: [BK PATCH] i2c driver changes for 2.5.68
Message-Id: <20030424235836.GA29888@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

Hi,

Here are some i2c driver changes for 2.5.68.  These include a lot of
cleanup patches, removing dead or duplicated code.  With these patches,
we are almost able to remove i2c-sensor.h and i2c-sensor.c, but not
quite there.  Also a new i2c chip driver has been added.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.5

thanks,

greg k-h

 drivers/i2c/busses/i2c-viapro.c  |  321 +++++-------
 drivers/i2c/chips/Kconfig        |   14 
 drivers/i2c/chips/Makefile       |    1 
 drivers/i2c/chips/adm1021.c      |  130 -----
 drivers/i2c/chips/it87.c         |  976 +++++++++++++++++++++++++++++++++++++--
 drivers/i2c/chips/lm75.c         |    8 
 drivers/i2c/chips/via686a.c      |    8 
 drivers/i2c/chips/w83781d.c      |   10 
 drivers/i2c/i2c-core.c           |    8 
 drivers/i2c/i2c-sensor.c         |   46 -
 drivers/media/video/msp3400.c    |    6 
 drivers/media/video/saa5249.c    |    2 
 drivers/media/video/saa7111.c    |    2 
 drivers/media/video/tda7432.c    |    3 
 drivers/media/video/tda9840.c    |    2 
 drivers/media/video/tda9875.c    |    3 
 drivers/media/video/tda9887.c    |    3 
 drivers/media/video/tea6415c.c   |    2 
 drivers/media/video/tea6420.c    |    2 
 drivers/media/video/tuner-3036.c |    3 
 drivers/media/video/tuner.c      |    3 
 drivers/media/video/tvaudio.c    |    3 
 include/linux/i2c-sensor.h       |  152 +-----
 include/linux/i2c.h              |   25 
 24 files changed, 1216 insertions(+), 517 deletions(-)
-----

<florin@iucha.net>:
  o i2c: added it87 driver

Christoph Hellwig <hch@lst.de>:
  o i2c: bring i2c-viapro uptodate with the style guide
  o i2c: remove dead init code from i2c-sensors.c
  o i2c: remove dead code from adm1021
  o i2c: remove dead junk from i2c-sensors.h

Greg Kroah-Hartman <greg@kroah.com>:
  o i2c: remove a lot of dupliated macros from i2c-sensor.h and use the current values in i2c.h
  o i2c: removed unneeded typedef from i2c-sensor.h
  o i2c: fix up the media drivers due to removing flags paramater of callback function
  o i2c: removed unused flags paramater in found_proc callback
  o i2c: fix up it87.c check_region mess
