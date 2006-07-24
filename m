From: gregkh@suse.de (Greg KH)
Date: Mon, 24 Jul 2006 19:38:08 +0000
Subject: [lm-sensors] [GIT PATCH] I2C and hwmon fixes for 2.6.18-rc1
Message-Id: <20060724193808.GA9244@suse.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060712232359.GA22679@kroah.com> <20060724212146.498d184b.khali@linux-fr.org>
In-Reply-To: <20060724212146.498d184b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Mon, Jul 24, 2006 at 09:21:46PM +0200, Jean Delvare wrote:
> > Here are some i2c and hwmon fixes for 2.6.18-rc1.  They fix quite a few
> > bugs and update the documentation.
> > 
> > They all have been in the -mm tree for a while.
> > 
> > Please pull from:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
> > or from:
> > 	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/i2c-2.6.git/
> > if it isn't synced up yet.
> > 
> > The full patch series will sent to the sensors mailing list, if anyone
> > wants to see them.
> 
> Which is quite unfortunate because we now have a new mailing list
> dedicated to i2c [1], where the i2c patches would fit better. Is it
> possible to send the i2c patches to the i2c list next time? And the
> hwmon patches to the sensors list as before.

I can do that if you want me to split up the hwmon and i2c patches into
two different set of patches for Linus to pull from.  If you think it's
worth it, I will.

thanks,

greg k-h

