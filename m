From: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Date: Wed, 05 Jun 2013 11:14:39 +0000
Subject: Re: [lm-sensors] =?utf-8?q?=5BPATCH_1/2=5D_hwmon=3A_mc13783-adc=3A_Re?=
Message-Id: <1370430879.384973987@f91.mail.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <1370422628-1073-1-git-send-email-shc_work@mail.ru>
 <1370423952.906453652@f168.mail.ru>
 <20130605125308.36ba40ab@endymion.delvare>
In-Reply-To: <20130605125308.36ba40ab@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

> > > On Wed,  5 Jun 2013 12:57:07 +0400, Alexander Shiyan wrote:
> > > > This patch renames structures, variables and functions to indicate support
> > > > for various MC13xxx chips.
> > > > 
> > > > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > > > ---
> > > >  drivers/hwmon/mc13783-adc.c | 135 +++++++++++++++++++++-----------------------
> > > >  1 file changed, 63 insertions(+), 72 deletions(-)
> > > 
> > > Nack. This change serves absolutely no purpose, all it's doing it make
> > > everyone's life harder. Just don't do that, thanks.
> > 
> > I do not understand stubbornness here.
> > The driver works for different chips, it should be reflected in the code.
> 
> Let's look at it from another angle. What problem are you trying to
> solve? I see absolutely no problem with the current function and file
> names. Almost all Linux kernel drivers support more chips than their
> name says.
> 
> On the other hand, changing all function names makes backporting fixes
> harder, and changing Kconfig symbol names makes upgrading to the new
> kernel version harder for everyone.
> 
> So the cost of your proposal far outweighs the benefits.

Well, let's leave the kconfig symbol as is. But about the rest, that mc13783_*
symbols in the log (debug) will say a developer who does not know about
mc13892 compatibility with mc13783? I still believe that this should be reflected.
Thanks.

---
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
