From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:56 +0000
Subject: [BK PATCH] More i2c driver changes for 2.5.69
Message-Id: <20030509235504.GD3517@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030322010405.GA18613@kroah.com>
In-Reply-To: <20030322010405.GA18613@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

Hi,

Here are some more minor i2c fixups for 2.5.69.  They are basically a
bunch of fixes for the it87 driver, and a few other minor changes.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.5

thanks,

greg k-h

 drivers/i2c/chips/it87.c |  195 +++++++++++++++++++++++------------------------
 drivers/i2c/i2c-core.c   |   33 ++++++-
 include/linux/i2c.h      |   13 +--
 3 files changed, 133 insertions(+), 108 deletions(-)
-----

<warp:mercury.d2dc.net>:
  o I2C: And another it87 patch
  o I2C: Yet another it87 patch
  o I2C: Another it87 patch

Greg Kroah-Hartman:
  o i2c: register the i2c_adapter_driver so things link up properly in sysfs
  o i2c: add i2c_adapter class support

Mark W. McClelland:
  o I2C: add more classes
