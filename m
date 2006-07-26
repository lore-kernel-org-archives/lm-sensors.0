From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 26 Jul 2006 20:01:21 +0000
Subject: [lm-sensors] [GIT PATCH] I2C and hwmon fixes for 2.6.18-rc1
Message-Id: <20060726220121.89fda898.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060712232359.GA22679@kroah.com>
	<20060724212146.498d184b.khali@linux-fr.org>
	<20060724193808.GA9244@suse.de>
In-Reply-To: <20060724193808.GA9244@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Greg,

> On Mon, Jul 24, 2006 at 09:21:46PM +0200, Jean Delvare wrote:
> > > Here are some i2c and hwmon fixes for 2.6.18-rc1.  They fix quite a few
> > > bugs and update the documentation.
> > > (...)
> > > The full patch series will sent to the sensors mailing list, if anyone
> > > wants to see them.
> > 
> > Which is quite unfortunate because we now have a new mailing list
> > dedicated to i2c [1], where the i2c patches would fit better. Is it
> > possible to send the i2c patches to the i2c list next time? And the
> > hwmon patches to the sensors list as before.
> 
> I can do that if you want me to split up the hwmon and i2c patches into
> two different set of patches for Linus to pull from.  If you think it's
> worth it, I will.

Yes, please. Else people will never get that i2c and hwmon are
different things (although they intersect.)

Thanks,
-- 
Jean Delvare

