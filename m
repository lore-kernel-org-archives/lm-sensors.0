From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 02 Jun 2005 06:08:04 +0000
Subject: [lm-sensors] Re: [RFC] SPI core
Message-Id: <20050602040655.GE4906@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <1117555756.4715.17.camel@diimka.dev.rtsoft.ru> <20050531233215.GB23881@kroah.com>
In-Reply-To: <20050531233215.GB23881@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: dmitry pervushin <dpervushin@ru.mvista.com>, linux-kernel@vger.kernel.org, lm-sensors <lm-sensors@lm-sensors.org>

Hi Greg, Dmitry:

> On Tue, May 31, 2005 at 08:09:16PM +0400, dmitry pervushin wrote:
> > In order to support the specific board, we have ported the generic SPI
> > core to the 2.6 kernel. This core provides basic API to create/manage
> > SPI devices like the I2C core does. We need to continue providing
> > support of SPI devices and would like to maintain the SPI subtree. It
> > would be nice if SPI core patch were applied to the vanilla kernel.
> > I2C people do not like to mainain this code as well as I2C, so...

* Greg KH <greg@kroah.com> [2005-05-31 16:32:15 -0700]:
> What do you mean by this?  Which i2c people?

(...)

* Greg KH <greg@kroah.com> [2005-05-31 16:32:15 -0700]:
> This code is _very_ close to just a copy of the i2c core code.  Why
> duplicate it and not work with the i2c people instead?

It was discussed briefly on the lm-sensors mailing list [1].  I didn't 
reply at the time, but I do agree that SPI and I2C/SMBus are different
enough to warrant independent subsystems.

[1] http://lists.lm-sensors.org/pipermail/lm-sensors/2005-May/012385.html

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

