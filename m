From: gregkh@suse.de (Greg KH)
Date: Wed, 01 Jun 2005 11:43:51 +0000
Subject: [lm-sensors] [GIT PATCH] I2C bugfix for 2.6.12-rc5
Message-Id: <20050601050942.GA26994@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

Here is a single i2c patch for the 2.6.12-rc5 tree that fixes a bug.
This patch has been in the -mm tree for quite some time.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/

The full patch will be sent to the linux-kernel and sensors mailing
list, if anyone wants to see them.

thanks,

greg k-h

 MAINTAINERS                      |    6 +++++
 drivers/i2c/busses/i2c-ali1563.c |   46 ++++++++++++++++++++++++++-------------
 2 files changed, 37 insertions(+), 15 deletions(-)

------------

Rudolf Marek:
  o I2C: ALI1563 SMBus driver fix


