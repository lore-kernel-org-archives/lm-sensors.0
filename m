From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: [RFC][2.6] Additional i2c adapter flags for i2c client isolation
Message-Id: <20040316195325.GA22473@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4056C805.8090004@convergence.de> <20040316154454.GA13854@kroah.com> <20040316201426.1d01f1d3.khali@linux-fr.org>
In-Reply-To: <20040316201426.1d01f1d3.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: Michael Hunold <hunold@convergence.de>

On Tue, Mar 16, 2004 at 08:14:26PM +0100, Jean Delvare wrote:
> 
> I guess that chip drivers would be allowed to define only one class
> while adapters could possibly define more than one?

Not necessarily.  Just make the class a bit field, showing what kind of
devices each expects to handle.

> We also would want to introduce an I2C_ADAP_CLASS_ANY define, which
> would be what the eeprom driver would use, for example (since it can be
> hosted on any kind of bus). Generic bus drivers such as i2c-parport
> would also use I2C_ADAP_CLASS_ANY, since the nature of the hosted chips
> is unknown.

Sure:
	#define I2C_ADAP_CLASS_ANY	0xffffffff
works for me :)

> Having clients define a class sounds also interesting from a
> user-space's point of view. If we would export this information through
> sysfs for example, programs such as "sensors" could limit their work to
> chips of the correct class (I2C_ADAP_CLASS_SMBUS at the moment, but a
> renaming is planned).

That also is a good idea.

thanks,

greg k-h
