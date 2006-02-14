From: gregkh@suse.de (Greg KH)
Date: Tue, 14 Feb 2006 06:47:18 +0000
Subject: [lm-sensors] [GIT PATCH] I2C and hwmon patches for 2.6.16-rc3
Message-Id: <20060214064718.GA20228@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051028210607.GA18845@kroah.com>
In-Reply-To: <20051028210607.GA18845@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Here are some i2c and hwmon patches for 2.6.16-rc3.  They all fix bugs
that are currently present in the tree.  All but one of these patches
have been in the last few -mm releases.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
or from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
if it isn't synced up yet.

The full patch series will sent to the sensors mailing list, if anyone
wants to see them.

thanks,

greg k-h

 Documentation/hwmon/w83627hf |    4 ++++
 drivers/hwmon/it87.c         |    3 ++-
 drivers/hwmon/vt8231.c       |    8 ++++----
 drivers/hwmon/w83781d.c      |   43 +++++++++++++++++++++++++------------------
 drivers/i2c/busses/i2c-isa.c |   12 ------------
 5 files changed, 35 insertions(+), 35 deletions(-)


Jean Delvare:
      vt8231: Fix sysfs temperature interface
      w83781d: Use real-time status registers
      w83627hf: Document the reset module parameter
      it87: Fix oops on removal
      i2c: Drop outdated probe/remove code in i2c-isa


