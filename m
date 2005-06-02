From: greg@kroah.com (Greg KH)
Date: Thu, 02 Jun 2005 06:42:11 +0000
Subject: [lm-sensors] Re: [RFC] SPI core
Message-Id: <20050602045145.GA7838@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1117555756.4715.17.camel@diimka.dev.rtsoft.ru> <20050531233215.GB23881@kroah.com> <20050602040655.GE4906@jupiter.solarsys.private>
In-Reply-To: <20050602040655.GE4906@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: dmitry pervushin <dpervushin@ru.mvista.com>, linux-kernel@vger.kernel.org, lm-sensors <lm-sensors@lm-sensors.org>

On Thu, Jun 02, 2005 at 12:06:55AM -0400, Mark M. Hoffman wrote:
> * Greg KH <greg@kroah.com> [2005-05-31 16:32:15 -0700]:
> > This code is _very_ close to just a copy of the i2c core code.  Why
> > duplicate it and not work with the i2c people instead?
> 
> It was discussed briefly on the lm-sensors mailing list [1].  I didn't 
> reply at the time, but I do agree that SPI and I2C/SMBus are different
> enough to warrant independent subsystems.

Independant is fine.  But direct copies, including making the same
mistakes (i2c dev interface, i2c driver model mess) isn't :)

thanks,

greg k-h
