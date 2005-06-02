From: rui.sousa@laposte.net (Rui Sousa)
Date: Thu, 02 Jun 2005 15:04:05 +0000
Subject: [lm-sensors] Re: [RFC] SPI core
Message-Id: <1117717356.5794.9.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <1117555756.4715.17.camel@diimka.dev.rtsoft.ru>
	 <20050531233215.GB23881@kroah.com>
	 <20050602040655.GE4906@jupiter.solarsys.private>
	 <20050602045145.GA7838@kroah.com>
In-Reply-To: <20050602045145.GA7838@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, dmitry pervushin <dpervushin@ru.mvista.com>, linux-kernel@vger.kernel.org, lm-sensors <lm-sensors@lm-sensors.org>

Hi Greg,

On Wed, 2005-06-01 at 21:51 -0700, Greg KH wrote:
> On Thu, Jun 02, 2005 at 12:06:55AM -0400, Mark M. Hoffman wrote:
> > * Greg KH <greg@kroah.com> [2005-05-31 16:32:15 -0700]:
> > > This code is _very_ close to just a copy of the i2c core code.  Why
> > > duplicate it and not work with the i2c people instead?
> > 
> > It was discussed briefly on the lm-sensors mailing list [1].  I didn't 
> > reply at the time, but I do agree that SPI and I2C/SMBus are different
> > enough to warrant independent subsystems.
> 
> Independant is fine.  But direct copies, including making the same
> mistakes (i2c dev interface, i2c driver model mess) isn't :)

I have also worked on a(nother) SPI layer implementation. Like Dmitry, I
ended up following closely the i2c implementation, so, I'm curious to
know more details on what you call "i2c driver model mess".

> thanks,
> 
> greg k-h

Thanks,

Rui


