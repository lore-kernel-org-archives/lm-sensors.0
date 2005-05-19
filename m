From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: lm sensors sysfs file structure
Message-Id: <20030401202217.GC122@elf.ucw.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030325175603.GG15823@kroah.com> <1048705473.7569.10.camel@nosferatu.lan> <3E82024A.4000809@portrix.net> <20030326202622.GJ24689@kroah.com> <3E82292E.536D9196@paradyne.com> <20030326225234.GA27436@kroah.com> <3E82D678.9000807@portrix.net> <20030327172516.GA32667@kroah.com> <20030330192312.GB6666@zaurus.ucw.cz> <20030331224439.A7000@kroah.com>
In-Reply-To: <20030331224439.A7000@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: Jan Dittmer <j.dittmer@portrix.net>, Mark Studebaker <mds@paradyne.com>, azarah@gentoo.org, KML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>, sensors@Stimpy.netroedge.com

Hi!

> > > > >	       	Floating point values XXX.X or XXX.XX in degrees Celcius.
> > > > 
> > > > If we're restructuring it, I think we should also agree on _one_ common 
> > > > denominator for all values ie. mVolt and milli-Degree Celsius, so that 
> > > > no userspace program ever again has know how to convert them to 
> > > > user-readable values and every user can just cat the values and doesn't 
> > > > have to wonder if it's centi-Volt, milli-Volt, centi-Degree, dezi-Degree 
> > > > or whatever.
> > > 
> > > Um, that's what my proposal stated.  Do you not agree with it?  (You're
> > > quoting the existing document above, not my proposed changes.)
> > 
> > Well, you had cV for PSU voltages and
> > mV for cpu core voltage. I guess mV
> > and mili-deg-C everywhere would be
> > nicer. 
> 
> I was trying to keep consistant with what the old /proc values were
> reported as.  I'll go fix that up.
> 
> As for why no floating point, it's a pain in the but to both output a
> fixed point number from the kernel into floating point, and to parse a
> floating point number from userspace within the kernel, turning it into
> a fixed point number.  With the proposal I wrote up, none of that is
> needed, and all userspace has to do is divide by a factor of 10 to get
> the proper value.

Okay, I did not realize it is input, too. Outputing reals is really
easy; but parsing them. Okay, I guess I'm convinced. You should still
use mili-something, not centi-something...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
