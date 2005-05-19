From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: [RFC][2.6] Additional i2c adapter flags for i2c client isolation
Message-Id: <20040316154454.GA13854@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4056C805.8090004@convergence.de>
In-Reply-To: <4056C805.8090004@convergence.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Hunold <hunold@convergence.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sensors@stimpy.netroedge.com

On Tue, Mar 16, 2004 at 10:25:25AM +0100, Michael Hunold wrote:
> Here, all client drivers are unconditionally told to try and attach to
> the adapter. There is no way that an i2c adapter can keep an i2c driver
> away from the bus.

Yes, but the different i2c chip drivers all check for the class setting
to be correct before they really do anything, right?

> Currently, adapters can already specify a class, for DVB
> I2C_ADAP_CLASS_TV_DIGITAL matches perfectly.

Yes, and that is what you should check for.  It's a bug if any of the
non-DVB i2c drivers probe devices with the .class set to
I2C_ADAP_CLASS_TV_DIGITAL.  Fix that and you should be fine, right?

> What I'd like to have is that client can specify some sort of "class",
> too, and that i2c adapters can tell the core that only clients where the
> class is matching are allowed to probe their existence.

Yeah, right now it's up to the chip drivers to be honest.  If you want
to implement a change to do this instead, I'll be glad to apply it.

thanks,

greg k-h
