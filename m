From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Date: Mon, 13 Sep 2010 11:46:11 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: lm75: Add __devinit and
Message-Id: <0680EC522D0CC943BC586913CF3768C003C210ECEC@dbde02.ent.ti.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1284365862-20438-1-git-send-email-shubhrajyoti@ti.com>
In-Reply-To: <1284365862-20438-1-git-send-email-shubhrajyoti@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



> -----Original Message-----
> From: Michael Lawnick [mailto:ml.lawnick@gmx.de]
> Sent: Monday, September 13, 2010 4:42 PM
> To: Datta, Shubhrajyoti
> Cc: lm-sensors@lm-sensors.org
> Subject: Re: [lm-sensors] [PATCH v3] hwmon: lm75: Add __devinit and
> __devexit section initializers
> 
> Datta, Shubhrajyoti said the following:
> >
> >
> >> -----Original Message-----
> >> From: Michael Lawnick [mailto:ml.lawnick@gmx.de]
> >> Sent: Monday, September 13, 2010 2:52 PM
> >> To: Datta, Shubhrajyoti
> >> Cc: lm-sensors@lm-sensors.org
> >> Subject: Re: [lm-sensors] [PATCH v3] hwmon: lm75: Add __devinit and
> >> __devexit section initializers
> >>
> >> Shubhrajyoti D said the following:
> >> ...
> >>
> >> > -static int
> >> > +static int __devinit
> >> >  lm75_probe(struct i2c_client *client, const struct i2c_device_id
> *id)
> >> Are you sure?
> >> If I understand correctly, this function will be thrown away after
> >> system/module init. But what's about devices that are added later?
> >> I would expect them to crash on init...
> > As all of these are I2C devices are I2C I thought it makes sense.
> > Are you aware of devices that can be plugged/wired runtime?
> 
> Almost all if behind a multiplexer ;-)
I missed this part.

> There is just some care in synchronization needed.
> We are currently working with such a system that dynamically adds buses
> and drops them again (triggered by hotplug).
Does it mean that all the existing drivers need to adapt.

> --
> KR
> Michael


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
