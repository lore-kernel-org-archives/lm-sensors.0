From: hjk@linutronix.de (=?utf-8?q?Hans-J=C3=BCrgen_Koch?=)
Date: Fri, 16 Mar 2007 21:19:43 +0000
Subject: [lm-sensors] [PATCH] Add MAX6650 support
Message-Id: <200703162219.44470.hjk@linutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701171359.46334.hjk@linutronix.de>
In-Reply-To: <200701171359.46334.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Freitag, 16. M?rz 2007 22:19 schrieb Thomas Gleixner:
> On Fri, 2007-03-16 at 22:07 +0100, Hans-J?rgen Koch wrote:
> > > > /* fan_voltage: 5=5V fan, 12V fan, 0=don't change */
> > > > static int fan_voltage = 0;
> > > > /* prescaler: Possible values are 1,2,4,8,16, or 0 for don't change
> > > > */ static int prescaler = 0;
> > >
> > > The trick is to _not_ initialize these variables at all. The compiler
> > > will put them in a special section and will zero them all at once
> > > automatically.
> >
> > Sounds dangerous. But I trust you :-)
>
> It's one of the things which actually work reliable in gcc :)
>
> 	tglx

Fine, I'll remember that. But I think readability is better if you explicitly 
initialize to zero. Is that optimization really worth it?

Hans


