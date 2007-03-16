From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 16 Mar 2007 21:33:04 +0000
Subject: [lm-sensors] [PATCH] Add MAX6650 support
Message-Id: <1174080784.13341.296.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701171359.46334.hjk@linutronix.de>
In-Reply-To: <200701171359.46334.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 2007-03-16 at 22:19 +0100, Hans-J?rgen Koch wrote:
> Am Freitag, 16. M?rz 2007 22:19 schrieb Thomas Gleixner:
> > On Fri, 2007-03-16 at 22:07 +0100, Hans-J?rgen Koch wrote:
> > > > > /* fan_voltage: 5=5V fan, 12V fan, 0=don't change */
> > > > > static int fan_voltage = 0;
> > > > > /* prescaler: Possible values are 1,2,4,8,16, or 0 for don't change
> > > > > */ static int prescaler = 0;
> > > >
> > > > The trick is to _not_ initialize these variables at all. The compiler
> > > > will put them in a special section and will zero them all at once
> > > > automatically.
> > >
> > > Sounds dangerous. But I trust you :-)
> >
> > It's one of the things which actually work reliable in gcc :)
> >
> > 	tglx
> 
> Fine, I'll remember that. But I think readability is better if you explicitly 
> initialize to zero. Is that optimization really worth it?

The zeroed segment is set with memset() in one go, while all explicit
initializations carry additional code. gcc might be clever enough now to
move a "=0" initialized variable to the zeroed segment, but it is common
style since ever. And it removes _three_ characters per variable :)

	tglx



