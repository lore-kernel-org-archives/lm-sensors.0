From: rmk+lkml@arm.linux.org.uk (Russell King)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: [PATCH] ds1337 driver works also with ds1339 chip
Message-Id: <20050510134834.A3358@flint.arm.linux.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050504061438.GD1439@orphique> <Ky47NT3d.1115201231.3150830.khali@localhost> <20050510120804.GA2492@orphique>
In-Reply-To: <20050510120804.GA2492@orphique>; from ladis@linux-mips.org on Tue, May 10, 2005 at 02:08:04PM +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Greg KH <greg@kroah.com>, Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@Stimpy.netroedge.com>, James Chapman <jchapman@katalix.com>

On Tue, May 10, 2005 at 02:08:04PM +0200, Ladislav Michl wrote:
> On Wed, May 04, 2005 at 12:07:11PM +0200, Jean Delvare wrote:
> > > Chip is searched by bus number rather than its own proprietary id.
> > 
> > Yes, I think it makes much more sense (especially since the proprietary
> > id was not known by anyone outside of the ds1337 driver).
> > 
> > I think I understand that ds1337_do_command() will be called from some
> > other kernel driver. Why isn't it exported then? I'd expect:
> > EXPORT_SYMBOL(ds1337_do_command);
> 
> RTC is hooked early in boot process. It should be available even sooner
> than rootfs is mounted. Therefore RTC drivers are usualy compiled in
> kernel. Anyway, exporting that function shouldn't hurt :)

You don't have to set the kernel time during time_init(), and this
is especially true with I2C RTCs.  The only thing that time_init()
has to do is to start the kernel tick going.

There is no reason why it can't be initialised during the normal
driver initialisation - which is how we do it on a number of ARM
platforms.

There are some ARM platforms where we can only get the time via
ntpdate, and this is also satisfactory.

So please don't get hung up on the x86 way of doing things.  It's
both conceptually wrong and actually unnecessary.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
