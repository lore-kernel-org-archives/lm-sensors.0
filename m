From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: [RFC][2.6] Additional i2c adapter flags for i2c client isolation
Message-Id: <1079515049.405817a9a3da0@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <4056C805.8090004@convergence.de> <20040316154454.GA13854@kroah.com> <20040316201426.1d01f1d3.khali@linux-fr.org> <20040316195325.GA22473@kroah.com>
In-Reply-To: <20040316195325.GA22473@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com, Michael Hunold <hunold@convergence.de>

According to Greg KH <greg@kroah.com>:

> > I guess that chip drivers would be allowed to define only one
> > class while adapters could possibly define more than one?
> 
> Not necessarily.  Just make the class a bit field, showing what kind
> of devices each expects to handle.

Of course, this is how I meant it.  The way things are done for now, the
class value is already a bitfield and I'm fine with that.  This makes
full sense for adapters.  What I was wondering is whether it would be
allowed to set more than one class bit for a chip driver.   Not that is
necessarily matters much, I'm just curious.  Have we ever heard of
chips that would belong to more than one class as we defined them?

> > We also would want to introduce an I2C_ADAP_CLASS_ANY define,
> > which would be what the eeprom driver would use, for example
> > (since it can be hosted on any kind of bus). Generic bus drivers
> > such as i2c-parport would also use I2C_ADAP_CLASS_ANY, since the
> > nature of the hosted chips is unknown.
> 
> Sure:
> 	#define I2C_ADAP_CLASS_ANY	0xffffffff
> works for me :)

Exactly what I had in mind ;)

> > Having clients define a class sounds also interesting from a
> > user-space's point of view. If we would export this information
> > through sysfs for example, programs such as "sensors" could
> > limit their work to chips of the correct class
> > (I2C_ADAP_CLASS_SMBUS at the moment, but a renaming is planned).
> 
> That also is a good idea.

How would we export the value though? Numerical, with user-space headers
to be included by user-space applications? Or converted to some
explicit text strings so that no headers are needed?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
