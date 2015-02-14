From: Pavel Machek <pavel@ucw.cz>
Date: Sat, 14 Feb 2015 10:56:03 +0000
Subject: Re: [lm-sensors] hwmon strangeness, no fan control on w83627dhg
Message-Id: <20150214105603.GA12014@amd>
List-Id: <lm-sensors.vger.kernel.org>
References: <20150108202919.GA25118@amd>
In-Reply-To: <20150108202919.GA25118@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!

> > I don't have much time to spend on this right now but you should start
> > by comparing the datasheets of the W83627DHG and the W83627DHG-P
> > looking for differences.
> 
> I got the datasheets, (-P version is novuton, the other one is
> winbond), and there are pretty similar.
> 
> The hardware monitoring chapter is pretty similar. Section 5 (PECI) is
> completely rewritten. Section 6.3 has some differences, it looks -P
> has new smart fan III+ feature. Section 6.3.4 (smart fan III+) is
> new. There are differences in 7.1.3.1. section, but that is some SMI
> interrupt stuff, not interesting for us.
> 
> Chapter 8/9 (hardware monitor register set) has completely different
> graphics... but seems to describe same hardware. Hmm, it has even the
> same value (5CA3) in the identification register. Sections .70-.84 seems to
> describe new registers for smart fan III+ mode and more. And there are
> more new registers near section .98 and .119.
> 
> But it seems hardware should be backwards-compatible...

Ok, it seems it is. But by default it starts in (non-compatible) smart
fan III+ mode. I can do port(0x15e) &= ~0x20 to kick it back into
compatible mode, and I can then control CPU fan speed in 800..1700 RPM
range as expected; but my goal was to stop the fan to make the machine
quiet... No success with that so far.

Best regards,
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
