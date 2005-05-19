From: pavel@suse.cz (Pavel Machek)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: add eeprom i2c driver
Message-Id: <20030328204913.GF5147@zaurus.ucw.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E806AC6.30503@portrix.net> <20030325172024.GC15823@kroah.com> <3E8175FF.7060705@portrix.net> <20030326212923.GB26886@kroah.com>
In-Reply-To: <20030326212923.GB26886@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: Jan Dittmer <j.dittmer@portrix.net>, linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

Hi!

> > >can see, it takes about 100 lines of code off of this driver, which is
> > >nice.
> > >
> > I thought about doing something like this for adding sysfs support.
> > Should the voltages and other data appear as integer or as floats in 
> > sysfs tree? (ie. 1.20V or 120cV)
> 
> floats are a pain!

Why? Real world measurements *are*
floating point, and we are going to be
limited with centivolts at some point.
Floating point seems right...

				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...
