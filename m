From: gregkh@suse.de (Greg KH)
Date: Wed, 09 Nov 2005 23:03:34 +0000
Subject: [lm-sensors] [GIT PATCH] More I2C and hwmon patches for 2.6.14 -
Message-Id: <20051109220235.GB8729@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050912200441.GA22930@kroah.com>
In-Reply-To: <20050912200441.GA22930@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Here are some small i2c and hwmon patches.  They fix some bugs that were
caused by the previous round of i2c patches, and should go in before
2.6.15-rc1 is out.  Most of these are in the last -mm release.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
or from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
if it isn't synced up yet.

The full patch series was sent already to sensors mailing list, if
anyone wants to see them.

thanks,

greg k-h

 Documentation/i2c/busses/i2c-viapro |    6 ++----
 Documentation/i2c/writing-clients   |    4 ++--
 drivers/hwmon/w83627hf.c            |   16 ++++------------
 drivers/i2c/busses/i2c-viapro.c     |   27 ++++++++++++++-------------
 drivers/i2c/chips/ds1337.c          |    4 ++--
 5 files changed, 24 insertions(+), 33 deletions(-)

James Chapman:
      i2c: ds1337 BCD conversion fix

Jean Delvare:
      i2c: writing-client doc update complement
      i2c-viapro: Some adjustments

Yuan Mu:
      hwmon: Fix two w83627hf bugs

