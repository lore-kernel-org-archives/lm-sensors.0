From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: sysfs support in lm_sensors
Message-Id: <20030403002647.GA5130@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E8B7D42.4030300@penguincomputing.com>
In-Reply-To: <3E8B7D42.4030300@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Apr 02, 2003 at 04:16:02PM -0800, Philip Pokorny wrote:
> 
> Can you still use sysctl() against sysfs values, or is that also 
> deprecated?  Could a sysctl call return the value and magnitude where 
> the proc/sysfs interface did a decimal point conversion of the value?

No, sysctl does not work on sysfs files, sorry.  But open() and read()
works just fine :)

> What are your thoughts on creating *directories* for each sensor and 
> putting the multiple values associated with that sensor in the 
> sub-directory.

That would be a good idea, however the driver core does not provide a
way (or at least an easy way) to support subdirectories at this time.

A number of people have asked for it in the past, so if anyone wants to
code up such a patch, I'm sure it would be welcome.

> I think floating point is the best solution to the fractional values 
> that lm_sensors deals in.  These values aren't integers.  And we can try 
> and standardize on milli-volts and milli-degC, but for many  sensors, 
> that's unnecessary and wastes range, and what about the values that 
> *are* integers.  How do you distinguish between them and these scaled 
> values?  The decimal point solves this and releases the requirement that 
> all values be expressed in milli-somethings.

What values in the document I posted are fractional values?  I've also
agreed to standardize on milli-volts and milli-degC, as other parts of
the kernel also use those values.

And what "scaled values"?  The documentation states what the value and
units are for every type of file in sysfs for the i2c chips drivers.

> Further, if we restrict ourselves to scaling magnitudes that are greater 
> than or equal to 1, I think the conversions in and out of lm_sensors to 
> sysfs could be made simpler.  But much of the code in i2c_*real is 
> dealing with the multiple values that can be found.  With sysfs, we're 
> only allowed one value so these conversion functions would be much simpler.

Again, using integer values removes all of the conversion problems from
the kernel.

thanks,

greg k-h
