From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: i2c adapters class
Message-Id: <20040311012356.GD11828@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040224223843.2fb3394a.khali@linux-fr.org>
In-Reply-To: <20040224223843.2fb3394a.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Mar 10, 2004 at 09:55:12PM +0100, Jean Delvare wrote:
> > > BTW, don't you think I2C_ADAP_CLASS_SMBUS is a misnomer? It's about
> > > hardware monitoring, not the SMBus protocol. I'd say
> > > I2C_ADAP_CLASS_HWMON or I2C_ADAP_CLASS_SENSORS would have been more
> > > appropriate (although it may be a bit late for a change...)
> > 
> > Yeah, it doesn't make the most sense.  Care to propose something that
> > does make sense?  Or something to just fix this class stuff up all
> > together?
> 
> Well, all depends on what we want to do. Renaming I2C_ADAP_CLASS_SMBUS
> to anything different means breaking compatibility with older code.
> Maybe people outside of the kernel tree already use this define. At
> least the rivatv project now does (because of me, admittedly). So
> basically, the question is: is the change worth a compatibility change.

I don't care at all about "compatibility changes" as we can fix up all of
the in-kernel usages.  Anyone trying to keep drivers outside of the main
kernel tree deserve the pain that this causes :)

> It's not very difficult to fix for the "user", and supporting both
> defines looks easy, using something as:
> 
> #ifdef I2C_ADAP_CLASS_SMBUS
> #ifndef I2C_ADAP_CLASS_SENSORS
> #define I2C_ADAP_CLASS_SENSORS I2C_ADAP_CLASS_SMBUS
> #endif
> #endif
> 
> at the top of the using code. So the renaming option sounds acceptable.

Ick, no.  Just rename the thing.

> My two proposals for a new name are I2C_ADAP_CLASS_HWMON and
> I2C_ADAP_CLASS_SENSORS. Either is fine with me too, I don't have any
> preference. Or any other with a similar meaning.

But what are these "classes" used for exactly?  That was my main
question.  Does anyone really use them?  Can we just delete them
altogether?

thanks,

greg k-h
