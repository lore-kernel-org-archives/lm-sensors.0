From: gregkh@suse.de (Greg KH)
Date: Mon, 06 Feb 2006 20:18:27 +0000
Subject: [lm-sensors] [GIT PATCH] I2C and hwmon patches for 2.6.16-rc2
Message-Id: <20060206201827.GA29197@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051028210607.GA18845@kroah.com>
In-Reply-To: <20051028210607.GA18845@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Here are some i2c and hwmon patches.  They add a new hwmon driver and
fix a number of different bugs.  All of these have been in tha last few
-mm releases.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
or from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
if it isn't synced up yet.

The full patch series will sent to the sensors mailing list, if anyone
wants to see them.

thanks,

greg k-h

 Documentation/feature-removal-schedule.txt |    9 
 Documentation/hwmon/f71805f                |  105 +++
 Documentation/hwmon/it87                   |    2 
 Documentation/hwmon/sysfs-interface        |   18 
 Documentation/i2c/busses/i2c-sis69x        |   73 --
 Documentation/i2c/busses/i2c-sis96x        |   73 ++
 MAINTAINERS                                |    6 
 drivers/hwmon/Kconfig                      |   10 
 drivers/hwmon/Makefile                     |    1 
 drivers/hwmon/f71805f.c                    |  908 +++++++++++++++++++++++++++++
 drivers/hwmon/it87.c                       |    8 
 drivers/hwmon/lm77.c                       |    8 
 drivers/hwmon/w83792d.c                    |   31 
 drivers/i2c/algos/i2c-algo-sibyte.c        |    2 
 drivers/i2c/busses/Kconfig                 |    1 
 drivers/i2c/busses/i2c-i801.c              |    2 
 drivers/i2c/busses/i2c-parport-light.c     |    9 
 drivers/i2c/busses/i2c-parport.c           |    7 
 drivers/i2c/busses/i2c-pxa.c               |    2 
 drivers/i2c/i2c-core.c                     |   15 
 include/linux/i2c.h                        |    3 
 21 files changed, 1182 insertions(+), 111 deletions(-)

Eric Sesterhenn:
      i2c: Use module_param in i2c-algo-sibyte

Jason Gaston:
      i2c-i801: I2C patch for Intel ICH8

Jean Delvare:
      I2C: Resurrect i2c_smbus_write_i2c_block_data.
      hwmon: Fix negative temperature readings in lm77 driver
      hwmon: Inline w83792d register access functions
      hwmon: Add f71805f documentation
      hwmon: Fix reboot on it87 driver load
      hwmon: New f71805f driver

Rudolf Marek:
      i2c: Rename i2c-sis96x documentation file

Tobias Klauser:
      i2c: Use ARRAY_SIZE macro


