From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 18 Mar 2011 11:04:24 +0000
Subject: Re: [lm-sensors] Update on DS1721, DS1631, DS1631A, DS1731
Message-Id: <20110318120424.55f35687@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110318042048.GA8315@ericsson.com>
In-Reply-To: <20110318042048.GA8315@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 18 Mar 2011 03:28:51 -0700, Guenter Roeck wrote:
> On Fri, Mar 18, 2011 at 03:57:58AM -0400, Jean Delvare wrote:
> > If memory serves, at least the DS1631 supports better resolution than
> > the ds1621 driver currently offers. So claiming that it is supported
> > isn't completely exact. What the driver supports is really the DS1621
> > and the other chips happen to emulate it.
> > 
> > It should really not be difficult to add proper support for all chips,
> > I just could never find the time to look into it. The chips I have here
> > are: one DS1621, two DS1631+ and two DS1624+.
> > 
> Sure, can do that. What would you suggest ? Pick the best available resolution ?

By default, sure, why not? If anybody needs specific configuration,
they can add platform data.

> Also, if we do that, I would use i2c_device_id to select the part, and not try
> to auto-detect it. Another option would be to play with the configuration register 
> and try detecting chip types this way (ie set bit 3,4 and observe the result). 

You aren't allowed to write to the device in the detect function.

> Not sure if that is a good idea, though. Any thoughts on this ?

As I said before, I would blast detection code completely, and rely on
explicit instantiation for all devices (i.e. trust i2c_device_id).

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
