From: Pavel Machek <pavel@ucw.cz>
Date: Sat, 14 Feb 2015 15:12:20 +0000
Subject: Re: [lm-sensors] hwmon strangeness, no fan control on w83627dhg
Message-Id: <20150214151220.GA24611@amd>
List-Id: <lm-sensors.vger.kernel.org>
References: <20150108202919.GA25118@amd>
In-Reply-To: <20150108202919.GA25118@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!

> >>But it seems hardware should be backwards-compatible...
> >
> >Ok, it seems it is. But by default it starts in (non-compatible) smart
> >fan III+ mode. I can do port(0x15e) &= ~0x20 to kick it back into
> >compatible mode, and I can then control CPU fan speed in 800..1700 RPM
> >range as expected; but my goal was to stop the fan to make the machine
> >quiet... No success with that so far.
> 
> Not all CPU fans can be stopped. Maybe that is the case here ?

All the CPU fans can be stopped, with enough force :-).

Trouble is, I'd like to stop this one with software, and that might
not be possible. (I wonder how they do it? Clearly fan _is_ connected
to the PWM output somehow. Do they have second, hard-coded PWM
generator and logical OR on board...?)
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
