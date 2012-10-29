From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 29 Oct 2012 17:18:33 +0000
Subject: Re: [lm-sensors] [PATCH v2 4/9] hwmon: (it87) Introduce support for tempX_offset sysfs attribute
Message-Id: <20121029171833.GA20291@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1351448401-13985-5-git-send-email-linux@roeck-us.net>
In-Reply-To: <1351448401-13985-5-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again,

[ ... ]

> > > +static const u8 IT87_REG_TEMP_OFFSET[]	= { 0x56, 0x57, 0x59 };
> > 
> > Not all supported chips have these registers. For example, the IT8712F
> > rev. D doesn't have registers at 0x56 and 0x57, and register 0x59
> > apparently adjusts the offset for all 3 temperature channels. Also the
> > value is expressed as a reference voltage, not an offset in degrees C:
> > 
> > "Thermal Diode Zero Degree Voltage value (default: 0.664V 156h)."
> > 
> > (I don't quite understand how they can make 156h fit in an 8-bit
> > register, but that a different problem.)
> > 
> > So you will have to check all chips and revisions for support and only
> > create the sysfs attributes if the chip supports per-channel, degree C
> > offsets. A quick grep suggests that even the latest IT8705F and IT8712F
> > chip revisons had a voltage value in these registers, so support would
> > start with the IT8716F.
> > 
> Actually, I did check all chip revisions for which I have documentation.
> 
> I have the following datasheets:
> 	IT8705F rev. 0.4 (chip revision 3)
> 	IT8712F rev. 0.7 (chip revision 6)
> 	IT8712F rev. 0.81 (chip revision 7)
> 
> In all those specifications, the registers exist and are called "Thermal Diode
> Zero Degree Adjust {1|2|3} Register".
> 
> Kind of odd (and a bit scary) that they would remove the registers with later
> chip revisions. Anyway, I'll have to see if I can find any additional versions
> of the specifications.
> 
Ok, they didn't remove it, they added it. Got the sequence wrong here.
That makes more sense.

> Maybe I should simply drop the attributes for IT8705F and IT8712F ?
> 
I did some more reading and found an older version of the IT8712F spec.
Oddly enough, even with IT8716F the register values are named as "Zero Degree
Adjust Register", but are described as "Zero Degree Voltage Value", even
though the default value is 0. Wonder if the description is wrong in the IT8712
specification, but that is hard to say w/o hardware to actually test it.

To be on the safe side, I'll make the attributes available starting with
IT8716F.

For IT8721F and IT8728F, the register is used to specify Tcrit if the selected
input is PECI (that is not documented, or I did not find it in the spec),
and at least on my board the BIOS-selected value is wrong. So we actually
have a very good reason to make the attributes available and writable.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
