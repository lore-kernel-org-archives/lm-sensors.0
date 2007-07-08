From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Sun, 08 Jul 2007 19:37:06 +0000
Subject: Re: [lm-sensors] [PATCH] THMC50 support for 2.6 (3rd revision)
Message-Id: <20070708213706.6d1986fa.krzysztof.h1@wp.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070706215426.52e00d73.krzysztof.h1@wp.pl>
In-Reply-To: <20070706215426.52e00d73.krzysztof.h1@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 8 Jul 2007 17:53:37 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> Hi Krzysztof,
> 
> On Fri, 6 Jul 2007 21:54:26 +0200, Krzysztof Helt wrote:
> > This patch adds support for THMC50 and ADM1022 chips to 2.6 kernels.
> > 
> > The adm1022 has 3 temperature even in 2 temperature mode. It can be changed later if
> > the 3 temperatures should be available only in 3 temperature mode. I don't know how
> > lmsensors library handles the same sensor with two different number of temperatures.
> 
> It's pretty trivial to fix, simply use data->has_temp3 instead of
> data->type to decide whether to create (and delete) the extra files or
> not.
> 

I know and I actually did this then removed. It can always be done later and I want to check if the
lmsensors 2.x library is able to handle the same chip id "adm1022" with two different set of values to read.

It is simpler to ignore the unused value (through the config file) then to add it.

I will leave it as it is and it can be patched later.

> > +The ADM1022 works the same as THMC50 but it is faster (5 Hz instead of
> > +1 Hz for THMC50). It can be also put in a new mode to handle additional
> > +remote temperature sensor. Some pins change their meaning in this mode.
> > +If the sensor is supposed to work in this mode but is not set with
> > +adm1022_temp3 parameter a fan can be forced to full speed.
> 
> You could explain that the driver will read the mode from a chip
> register by default, and adm1022_temp3 is only needed if the BIOS did
> not setup the chip properly.
> 

English is not my native language so it is not so easy for me to make it clear enough.

> BTW, I seem to understand that your BIOS setups your chips properly,
> right? If so, you may want to drop adm1022_temp3. We usually only add
> this kind of workaround parameters when someone really needs them.
> 

My BIOS initialized them correctly.
My comment in the doc was supposed to do this, but the warning that it is needed only if the BIOS is broken
is better.

> > +
> > +static const struct attribute_group adm1022_group = {
> > +	.attrs = adm1022_attributes,
> > +};
> 
> These might be better named temp3_attributes and temp3_group, as not
> all ADM1022 chips will use them.
> 

These stay as I leave adm1022 with 3 temps.

> > +
> > +	err = -ENODEV;
> 
> You should check the initial value of "kind". If it is 0, is means that
> the user passed a force parameter when loading the driver to bypass the
> detection. If it is > 0, it means that a specific chip type was
> requested. Your driver should honor this. See the lm90 driver for an
> example.
> 

I wondered how force parameters work. I know now. I'll add this.

It simply shows how the thmc50 2.4 driver is full of holes.

Regards,
Krzysztof

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
