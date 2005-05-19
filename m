From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: [RFC][2.6] Additional i2c adapter flags for i2c client
Message-Id: <20040316201426.1d01f1d3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4056C805.8090004@convergence.de>
	<20040316154454.GA13854@kroah.com>
In-Reply-To: <20040316154454.GA13854@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>, Michael Hunold <hunold@convergence.de>
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

> Yeah, right now it's up to the chip drivers to be honest.  If you want
> to implement a change to do this instead, I'll be glad to apply it.

Does this mean that i2c_client would get an additional ".class" struct
element, of the same nature of the ".class" struct element of
i2c_adapter?

This sounds interesting. That way, the "compatibility" check would move
down to i2c-core and neither the bus drivers nor the chip drivers would
have to care (apart from defining this .class element). Sounds really
nice indeed.

I guess that chip drivers would be allowed to define only one class
while adapters could possibly define more than one?

We also would want to introduce an I2C_ADAP_CLASS_ANY define, which
would be what the eeprom driver would use, for example (since it can be
hosted on any kind of bus). Generic bus drivers such as i2c-parport
would also use I2C_ADAP_CLASS_ANY, since the nature of the hosted chips
is unknown.

Having clients define a class sounds also interesting from a
user-space's point of view. If we would export this information through
sysfs for example, programs such as "sensors" could limit their work to
chips of the correct class (I2C_ADAP_CLASS_SMBUS at the moment, but a
renaming is planned).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
