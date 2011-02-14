From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 14 Feb 2011 18:19:32 +0000
Subject: Re: [lm-sensors] hwmon API update
Message-Id: <20110214181932.GA26442@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D57CC24.1040306@free.fr>
In-Reply-To: <4D57CC24.1040306@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Feb 14, 2011 at 11:23:38AM -0500, Matthew Garrett wrote:
[ ... ]
> 
> > > The cost gets even larger if one has to consider that some may want or
> > > have to to backport drivers to earlier kernel versions. This patchset
> > > would result in significant efforts to do such backports.
> > 
> > This will never be a good reason to reject a change, sorry. Just look
> > at the many changes the i2c subsystem went through in the past 2 years.
> > They make it difficult to backport i2c device drivers to older kernels,
> > but they still happened, because they were needed. When backporting a
> > driver, you have to deal with the history of the kernel at large,
> > that's life.
> 
> (agree)
> 
.. unless there is no benefit for the driver in such an API change.
I am all for API changes if there are benefits for the affected drivers, 
and don't care about backwards compatibility. The i2c subsystem changes
all resulted in much cleaner and less code, which benefits everyone.

What we have here, though, is a lot of added complexity for each driver with
no benefit at all for the affected drivers. From a driver perspective, added
complexity and loss of backward complexity is all we get. In that context
I consider lack of backward complexity to be a valid argument. Sure, there
may be other arguments to make which outweigh the concerns, but that doesn't
mean the argument can not be made.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
