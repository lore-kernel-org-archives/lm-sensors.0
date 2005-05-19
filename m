From: wik@blueyonder.co.uk (Rik Ryall)
Date: Thu, 19 May 2005 06:25:36 +0000
Subject: Asus P4C800-E Deluxe/Winbond W83627THF issue
Message-Id: <200502052326.37434.wik@blueyonder.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502022021.06992.wik@blueyonder.co.uk>
In-Reply-To: <200502022021.06992.wik@blueyonder.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

[snip]
> > make: *** No rule to make target
> > `/lib/modules/2.6.8-24.11-smp/build/include/linux/modversions.h',
> > needed by  `kernel/chips/xeontemp.d'.  Stop.
> > poochzilla:/usr/src/packages/SOURCES/lm_sensors-2.9.0 #
> >
> > The file that it appears to be complaining about does exist, here:
> > /usr/src/linux-2.6.8-24.11/include/config/modversions.h
> >
> > What am I doing wrong?
>
> Wow, that's odd. "make" tries to compute dependencies for kernel
> drivers, while it isn't supposed to do so when the target is "user". I
> have no idea why it does this. Can't reproduce it here. Nobody reported
> a problem with this so far.

[snip]

> Whatever the problme is, it's not related to the filesystem
> organisation. Somehow, "make" doesn't behave the way we expect it to.
> What version of make is it?

GNU Make 3.80
>
> > How do I fix it?
>
> No idea :(
>
> > P.S. If you'd rather I not bother you with this noob stuff over email,
> > I'd  gladly take it to an appropriate public forum if such a thing
> > exists.
>
> We have an IRC channel if you want. freenode::#linux-sensors.

I'll try and drop by, tomorrow.  Meanwhile, thanks for the assistance thus 
far; with your help I've got something useable which is 100% more than I had.

My glass is half-full. :-)

Rik.
