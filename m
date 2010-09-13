From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 13 Sep 2010 14:49:45 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: lm75: Add __devinit and
Message-Id: <20100913144945.GA593@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1284365862-20438-1-git-send-email-shubhrajyoti@ti.com>
In-Reply-To: <1284365862-20438-1-git-send-email-shubhrajyoti@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Sep 13, 2010 at 08:18:08AM -0400, Michael Lawnick wrote:
> Datta, Shubhrajyoti said the following:
> > 
> > 
> >> -----Original Message-----
> >> From: Michael Lawnick [mailto:ml.lawnick@gmx.de]
> >> Sent: Monday, September 13, 2010 4:42 PM
> >> To: Datta, Shubhrajyoti
> >> Cc: lm-sensors@lm-sensors.org
> >> Subject: Re: [lm-sensors] [PATCH v3] hwmon: lm75: Add __devinit and
> >> __devexit section initializers
> >> 
> >> Datta, Shubhrajyoti said the following:
> >> >
> >> >
> >> >> -----Original Message-----
> >> >> From: Michael Lawnick [mailto:ml.lawnick@gmx.de]
> >> >> Sent: Monday, September 13, 2010 2:52 PM
> >> >> To: Datta, Shubhrajyoti
> >> >> Cc: lm-sensors@lm-sensors.org
> >> >> Subject: Re: [lm-sensors] [PATCH v3] hwmon: lm75: Add __devinit and
> >> >> __devexit section initializers
> >> >>
> >> >> Shubhrajyoti D said the following:
> >> >> ...
> >> >>
> >> >> > -static int
> >> >> > +static int __devinit
> >> >> >  lm75_probe(struct i2c_client *client, const struct i2c_device_id
> >> *id)
> >> >> Are you sure?
> >> >> If I understand correctly, this function will be thrown away after
> >> >> system/module init. But what's about devices that are added later?
> >> >> I would expect them to crash on init...
> >> > As all of these are I2C devices are I2C I thought it makes sense.
> >> > Are you aware of devices that can be plugged/wired runtime?
> >> 
> >> Almost all if behind a multiplexer ;-)
> > I missed this part.
> There even exist multiplexer that check the bus state and allow
> connection only within stop<->start phases.
> > 
> >> There is just some care in synchronization needed.
> >> We are currently working with such a system that dynamically adds buses
> >> and drops them again (triggered by hotplug).
> > Does it mean that all the existing drivers need to adapt.
> 
> I expect them to get adapted step by step when/if this really becomes an
> issue. Maybe someday a general cleanup will necessary (and done). Anyway
> this might be already an issue for hot plugged cards (e.g. a compact PCI
> TV card) that has a local i2c adapter on and common devices on its local
> bus. But either this scenario does not exist in practical life or was
> fixed by a local code fix.
> 
This is an interesting use case. I didn't think about it either.

Looking through other drivers, it seems to be common that __devinit and __devexit 
are used only if the device is known to be static. Some even make a destinction 
based on the interface type (eg lm78).

As such, it may be better not to apply this patch.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
