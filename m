From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: [BK PATCH] i2c driver changes for 2.5.70
Message-Id: <20030605205515.GA6846@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

Hi,

Here are some i2c driver changes for 2.5.70.  These consist of some
small bug fixes to the i2c core which fixes some oopses, a update to the w83781d.c driver, and a sync with the cvs version of the i2c-id.h file.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.5

thanks,

greg k-h

 drivers/i2c/chips/w83781d.c |  306 +++++++++++++++++++++++++-------------------
 drivers/i2c/i2c-core.c      |    9 -
 include/linux/i2c-id.h      |    7 +
 3 files changed, 185 insertions(+), 137 deletions(-)
-----

<aschultz:warp10.net>:
  o I2C: fix unsafe usage of list_for_each in i2c-core

<mhoffman:lightlink.com>:
  o I2C: more w83781d fixes
  o I2C: fix oops w83781d during rmmod

Greg Kroah-Hartman:
  o I2C: sync i2c-id.h with cvs version
