From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: fix compares of jiffies
Message-Id: <3DE53C00.46F35099@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.OSF.4.50.0211241432520.15523-100000@kosh.hut.fi>
In-Reply-To: <Pine.OSF.4.50.0211241432520.15523-100000@kosh.hut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

that's fine. I was thinking of the sensors/kernels/chips drivers.
But maybe they're OK anyway because they check for the timer wrap
anyway.
BTW I found time_before() in kernels at least back to 2.1.131 so it's OK
for
us to use.

Ky?sti M?lkki wrote:
> 
> On Wed, 27 Nov 2002, Mark D. Studebaker wrote:
> 
> > good idea,
> > let's fix this after the 2.7.0 release
> 
> > >         DEB3(printk(" Write 0x%02x to 0x%x\n",(unsigned short)val, ctl&0xff));
> > > -       DEB3({while (jiffies < j) schedule();})
> > > +       DEB3({while (time_before(jiffies, j)) schedule();})
> > >         outw(val,ctl);
> 
> Well only i2c-algo-bit was affected, and time_before() already was used
> in i2c-algo-XXX so it was applied already among other things.
> 
> I will hold further commits to i2c-algo-bit after release.
> 
> --
>   Ky?sti M?lkki
>   kmalkki@cc.hut.fi
