From: gregkh@suse.de (Greg KH)
Date: Tue, 09 May 2006 20:07:18 +0000
Subject: [lm-sensors] [GIT PATCH] I2C bugfixes for 2.6.17-rc3
Message-Id: <20060509200718.GA7176@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Here are some i2c bug fixes for a single driver against your current git
tree.  They all have been in the -mm tree for a few weeks.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
or from:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
if it isn't synced up yet.

The full patch series will sent to the sensors mailing list, if anyone
wants to see them.

thanks,

greg k-h


 drivers/i2c/busses/scx200_acb.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

---------------

Jean Delvare:
      scx200_acb: Fix return on init error
      scx200_acb: Fix resource name use after free

Jordan Crouse:
      scx200_acb: Fix for the CS5535 errata


