From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: [PATCH 2.6-bk] Update IXP4xx I2C bus driver
Message-Id: <20040429173817.GA17657@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040415180759.GA15522@plexity.net>
In-Reply-To: <20040415180759.GA15522@plexity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Apr 29, 2004 at 10:20:38AM -0700, Deepak Saxena wrote:
> On Apr 21 2004, at 19:04, Jean Delvare was caught saying:
> > > True but the I2C-specific portion I posted here applies to 2.6.5. 
> > > I'm working on getting a full 2.6.5 patch out the door the next 
> > > few days (or 2.6-rc if we have one by then).
> > 
> > Well we have 2.6.6-rc2 already. But the i2c part of you patch should
> > apply equally well against 2.6.5 and 2.6.6-rc, there's no change in the
> > way.
> 
> Greg, Jean,
> 
> Just pinging to see if this patch is headed upstream or still needs
> some changes?

It's still in my todo queue, I have a bunch of i2c changes left to
apply, sorry for the delay (been busy fixing other, real bugs...).  The
patch looked ok, and I'll let you know when I apply it.

thanks,

greg k-h
