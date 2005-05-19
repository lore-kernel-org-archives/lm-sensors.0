From: oleg@cs.msu.su (Oleg I. Vdovikin)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: [CONTRIBUTION] DDC/CI tool for lm_sensors package
Message-Id: <000801c48822$be35d0c0$0401a8c0@proxima>
List-Id: <lm-sensors.vger.kernel.org>
References: <1093114999.11260.22.camel@proxima>
In-Reply-To: <1093114999.11260.22.camel@proxima>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


----- Original Message ----- 
From: "Jean Delvare" <khali@linux-fr.org>
To: "Oleg I. Vdovikin" <oleg@cs.msu.su>
Cc: <sensors@Stimpy.netroedge.com>
Sent: Sunday, August 22, 2004 11:20 AM
Subject: Re: [CONTRIBUTION] DDC/CI tool for lm_sensors package


> > I've recently finished writing a tool which is suitable for
> > communication with DDC/CI (DDC2Bi) enabled monitors (Samsung,
> > NEC/Mitsubishi are known to support it) and allows querying monitor
> > capabilities, reading and writing monitor controls, such as contrast,
> > brightness, geometry, etc...
> >
> > I'm believe, that there is some interest on this, at least googling
> > shows that. ;-) The reason for contributing is simple - I've spent
> > some time on this, and do not want to just this into the wastebasket.
> > ;-)
> > (...)
> > Attached please find a patch against lm_sensors-2.8.7. I would like if
> > someone will review this stuff and commit it to the CVS.
>
> The project itself looks interesting and all, but how exactly does this
> belong to lm_sensors?
    Well, just like the other stuff in the prog directory. It's just a
sample program utilizing i2c bus. It's not a complete solution & will never
be, but treat as decoding software. In fact, it's possible to make it a
sensors like kernel module.

> I agree that there are other related drivers and tools in the lm_sensors
> package already, such as the eeprom and ddcmon drivers, and the eeprom
> decoding scripts. But they don't really belong there either. The only
> reason they are part of the lm_sensors package is that they were written
> by the lm_sensors team. It was also convenient to keep all drivers in
> the same place while the interfaces and internal structures were
> stabilizing, and to keep the scripts with the drivers for the same
> reasons. Convenient, but certainly not very clean.
    Exactly. But also they're too small to make them separate package, but
very handy.

> So I'd suggest that you distribute your DDC/CI tool as a separate
> package. I'd rather move non-sensors things out of lm_sensors than
> include new non-sensors things in it. Also, your work is more likely to
> catch potential users eyes as a separata package. I doubt anyone will be
> looking for such a tool in our package.
    I'd rather suggest to make separate package for the lm_sensors, called
i2c-utils or something like this and include existing progs. Or,
alternatively you can make a registry of existing projects, utilizing I2C
bus. In fact, there are number of packages which use i2c, but due to their
size and specific they are never become well known to public, except the
ones which is already included to the lm_sensors package.

Thank you for explanations,
Oleg.
