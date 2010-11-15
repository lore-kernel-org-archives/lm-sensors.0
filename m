From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Mon, 15 Nov 2010 17:33:31 +0000
Subject: Re: [lm-sensors] [PATCH] intel medfield: thermal_driver
Message-Id: <20101115173331.13ff5408@lxorguk.ukuu.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101115131616.26319.23030.stgit@localhost.localdomain>
In-Reply-To: <20101115131616.26319.23030.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > +       /* Enable VAUDA line: temporary workaround for MSIC issue */
> 
> If this is a temporary workaround, what is the fix, and when will it be
> implemented ? And what is the issue ?

The fix is firmware/hardware side so it'll get fixed when the
hardware/firmware gets fixed. Fixed being removed in this case.

> > + * Context: can sleep
> 
> Deviating from other "can sleep" comments.

I tidied them up and missed that one.

> 
> > + *
> > + * FIXME: Ultimately the channel allocator will move into the intel_scu_ipc
> > + * code.
> 
> Not sure if it is a good idea to have a FIXME in the code. Either fix it,
> or make it a note.

FIXME is what is used in other bits of the kernel for this.

> > +       if (data & MSIC_ADCTHERM_MASK)
> > +               dev_warn(dev, "ADCTHERM already set");
> > +
> Is that a problem ? Just wondering if the warning has any value.

It shouldn't happen so it is useful to know if it does.

> 
> > +       /* Index of the first channel in which the stop bit is set */
> > +       channel_index = find_free_channel();
> 
> The usage and call sequence for channel_index looks odd. I don't see a well defined
> relationship between channel_index and the device. channel_index can change
> each time mid_initialize_adc() is called, ie each time resume() is called.
> Or if it can not change, it does not make sense to re-calculate it.

There isn't. It's dynamically assigned - ie ADCs and sensors are not
fixed 1:1. I'm not entirely sure its right in all cases so I'll dig
deeper into this.



> Since you don't check the result of initialize_sensor(), you will pass NULL if it fails.
> thermal_zone_device_register() will put NULL in tz->devdata, which you then use 
> in mid_read_temp() without checking.

Agreed


> > +MODULE_AUTHOR("Durgadoss <durgadoss.r@intel.com>");
> 
> It is customary to use the full name here. No problem with me, but I have
> seen reviews where this was suggested.

Not all parts of the world operate a naming scheme that matches Western
Europe.

I'll clean up the small stuff shortly but the other bits I may need to go
back round with the original author to clarify.

Thanks

Alan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
