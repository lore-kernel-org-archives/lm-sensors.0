From: greg@kroah.com (Greg KH)
Date: Thu, 09 Jun 2005 09:28:27 +0000
Subject: [lm-sensors] Re: [RFC] SPI core
Message-Id: <20050609071523.GE22729@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1117555756.4715.17.camel@diimka.dev.rtsoft.ru> <20050531233215.GB23881@kroah.com> <20050602040655.GE4906@jupiter.solarsys.private> <20050602045145.GA7838@kroah.com> <1117717356.5794.9.camel@localhost.localdomain>
In-Reply-To: <1117717356.5794.9.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rui Sousa <rui.sousa@laposte.net>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, dmitry pervushin <dpervushin@ru.mvista.com>, linux-kernel@vger.kernel.org, lm-sensors <lm-sensors@lm-sensors.org>

On Thu, Jun 02, 2005 at 03:02:35PM +0200, Rui Sousa wrote:
> Hi Greg,
> 
> On Wed, 2005-06-01 at 21:51 -0700, Greg KH wrote:
> > On Thu, Jun 02, 2005 at 12:06:55AM -0400, Mark M. Hoffman wrote:
> > > * Greg KH <greg@kroah.com> [2005-05-31 16:32:15 -0700]:
> > > > This code is _very_ close to just a copy of the i2c core code.  Why
> > > > duplicate it and not work with the i2c people instead?
> > > 
> > > It was discussed briefly on the lm-sensors mailing list [1].  I didn't 
> > > reply at the time, but I do agree that SPI and I2C/SMBus are different
> > > enough to warrant independent subsystems.
> > 
> > Independant is fine.  But direct copies, including making the same
> > mistakes (i2c dev interface, i2c driver model mess) isn't :)
> 
> I have also worked on a(nother) SPI layer implementation. Like Dmitry, I
> ended up following closely the i2c implementation, so, I'm curious to
> know more details on what you call "i2c driver model mess".

The fact that the i2c drivers are not really true "drivers" in the
driver model.  We bind them by hand to the device and then register the
device with the core.  That isn't a nice thing to do...

Also the sysfs representation of the sensor stuff is tied to the i2c
sysfs code very tightly, which isn't good for other types of sensors.
It should be in the class portion of sysfs, and the recent hwmon patches
are moving it in that direction.

thanks,

greg k-h
