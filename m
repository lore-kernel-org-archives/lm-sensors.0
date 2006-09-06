From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 06 Sep 2006 14:01:01 +0000
Subject: [lm-sensors] w83627ehf: Missing fan input and minor problems w/
Message-Id: <20060906160101.5dd03e45.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1157458671.18988.34.camel@mhcln03>
In-Reply-To: <1157458671.18988.34.camel@mhcln03>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Guten Tag Matthias,

> Am Dienstag, den 05.09.2006, 18:20 +0200 schrieb Jean Delvare:
> > > Can you provide a listing of the sysfs files exported by the driver on
> > > your system?
> 
> The listing is attached.

OK, it actually lacks the fan5 files, so that's a kernel issue and not
a user-space issue.

> >  The w83627ehf pins for fans 4 and 5 can be programmed as
> > > general purpose I/O, and the driver detects whether you have 3, 4, or
> > > 5 fan pins configured. (The setting is read, but not changed.) So...do
> > > you have pwm4 and pwm5 in your sysfs?
> > 
> > Matthias, can you please provide a dump of your chip (isadump 0x295
> > 0x296) at init time, before loading the w83627ehf driver?
> 
> The dump is attached. It was taken before loading any modules
> (init=/bin/sh).

It indeed shows fan5 as disabled.

> > I'd try forcing the driver to use all 5 fan inputs. Just run "isaset
> > 0x295 0x296 0x47 0x05 0x05" before loading the w83627ehf driver, and
> > see what happens. It's supposed to be the default, but...
> 
> I tried it, no success :\ I still only get 4 fans.

Odd. Did "isaset" complain about failed readback?

The easiest way to make sure is:

isadump -y 0x295 0x296
isaset -y 0x295 0x296 0x47 0xf5
isadump -y 0x295 0x296

The value of register 0x47 should change in the second dump.

-- 
Jean Delvare

