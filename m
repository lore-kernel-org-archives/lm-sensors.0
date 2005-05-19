From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: [BK PATCH] i2c driver fixes for 2.6.0-test7
Message-Id: <20031010231024.GB18320@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030802052904.GA9782@kroah.com>
In-Reply-To: <20030802052904.GA9782@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

Hi,

Here are some i2c driver fixes for 2.6.0-test7.  They fix a bug in the
i2c-dev class code, fix oopses in the i2c-sis630 driver, and fix a
potential use-before-initialized error in the i2c chip drivers.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.6

thanks,

greg k-h

 drivers/i2c/busses/Kconfig      |    4 +-
 drivers/i2c/busses/i2c-sis630.c |   67 ++++++++++++++++++++++++++++------------
 drivers/i2c/chips/Kconfig       |   16 ++++-----
 drivers/i2c/chips/adm1021.c     |    6 ++-
 drivers/i2c/chips/it87.c        |    7 ++--
 drivers/i2c/chips/lm75.c        |    5 ++
 drivers/i2c/chips/lm78.c        |    7 ++--
 drivers/i2c/chips/lm85.c        |    6 ++-
 drivers/i2c/chips/via686a.c     |    7 ++--
 drivers/i2c/chips/w83781d.c     |    6 ++-
 drivers/i2c/i2c-dev.c           |   17 ++++++++--
 11 files changed, 99 insertions(+), 49 deletions(-)
-----

<amalysh:web.de>:
  o I2C: i2c-sis630 driver fixes

Greg Kroah-Hartman:
  o I2C: fix i2c-dev class release function bug

Jean Delvare:
  o I2C: correct some errors in i2c/chips/Kconfig
  o I2C: Chip driver initialization fixes
