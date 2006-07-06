From: pavel@suse.cz (Pavel Machek)
Date: Thu, 06 Jul 2006 01:12:22 +0000
Subject: [lm-sensors] Generic interface for accelerometers (AMS, HDAPS,
Message-Id: <20060706011222.GA5303@elf.ucw.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060703124823.GA18821@khazad-dum.debian.net> <20060704075950.GA13073@elf.ucw.cz> <20060704162346.GE9447@khazad-dum.debian.net> <20060704235717.GD11872@elf.ucw.cz> <20060705073455.GA6027@suse.cz> <20060705135816.GA8452@khazad-dum.debian.net>
In-Reply-To: <20060705135816.GA8452@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrique de Moraes Holschuh <hmh@debian.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, hdaps-devel@lists.sourceforge.net, Stelian Pop <stelian@popies.net>, Michael Hanselmann <linux-kernel@hansmi.ch>

Hi!

> > > > I don't know about AMS, but talking to HDAPS when
> > > > you don't need to does waste enough system resources and power to actually
> > > > justify implementing this.
> > 
> > I'd doubt any of the accelerometer implementations would consume much
> > power or CPU.

Actually polling at 100Hz probably _is_ going to be measurable on
modern CPUs -- because it means that CPU has to exit C4. It will not
be too bad, hopefully.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

