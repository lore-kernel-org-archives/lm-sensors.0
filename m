From: gregkh@suse.de (Greg KH)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Message-Id: <20050419043938.GA23724@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: Git Mailing List <git@vger.kernel.org>, linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

Alright, let's try some small i2c and w1 patches...

Could you merge with:
	kernel.org/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/

It contains 4 small patches, 2 i2c and 2 w1 bugfixes, diffstat is
below, I'll figure out how to send the individual patches later.

thanks,

greg k-h

 drivers/i2c/chips/it87.c    |    2 +-
 drivers/i2c/chips/via686a.c |    7 ++-----
 drivers/w1/w1.c             |    9 +++++----
 drivers/w1/w1_smem.c        |    4 ++--
 4 files changed, 10 insertions(+), 12 deletions(-)
     
