From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 29 Oct 2012 19:14:52 +0000
Subject: Re: [lm-sensors] [PATCH v2 4/9] hwmon: (it87) Introduce support for tempX_offset sysfs attribute
Message-Id: <20121029191452.GA17107@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1351448401-13985-5-git-send-email-linux@roeck-us.net>
In-Reply-To: <1351448401-13985-5-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Oct 29, 2012 at 06:19:49PM +0100, Jean Delvare wrote:
> On Mon, 29 Oct 2012 08:37:31 -0700, Guenter Roeck wrote:
> > On Mon, Oct 29, 2012 at 11:08:30AM +0100, Jean Delvare wrote:
> > > On Sun, 28 Oct 2012 11:19:56 -0700, Guenter Roeck wrote:
> > > > diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
> > > > index 82f7924..fe2cdd4 100644
> > > > --- a/drivers/hwmon/it87.c
> > > > +++ b/drivers/hwmon/it87.c
> > > > @@ -203,6 +203,8 @@ static const u8 IT87_REG_FAN[]		= { 0x0d, 0x0e, 0x0f, 0x80, 0x82 };
> > > >  static const u8 IT87_REG_FAN_MIN[]	= { 0x10, 0x11, 0x12, 0x84, 0x86 };
> > > >  static const u8 IT87_REG_FANX[]		= { 0x18, 0x19, 0x1a, 0x81, 0x83 };
> > > >  static const u8 IT87_REG_FANX_MIN[]	= { 0x1b, 0x1c, 0x1d, 0x85, 0x87 };
> > > > +static const u8 IT87_REG_TEMP_OFFSET[]	= { 0x56, 0x57, 0x59 };
> > > 
> > > Not all supported chips have these registers. For example, the IT8712F
> > > rev. D doesn't have registers at 0x56 and 0x57, and register 0x59
> > > apparently adjusts the offset for all 3 temperature channels. Also the
> > > value is expressed as a reference voltage, not an offset in degrees C:
> > > 
> > > "Thermal Diode Zero Degree Voltage value (default: 0.664V 156h)."
> > > 
> > > (I don't quite understand how they can make 156h fit in an 8-bit
> > > register, but that a different problem.)
> > > 
> > > So you will have to check all chips and revisions for support and only
> > > create the sysfs attributes if the chip supports per-channel, degree C
> > > offsets. A quick grep suggests that even the latest IT8705F and IT8712F
> > > chip revisons had a voltage value in these registers, so support would
> > > start with the IT8716F.
> > 
> > Actually, I did check all chip revisions for which I have documentation.
> > 
> > I have the following datasheets:
> > 	IT8705F rev. 0.4 (chip revision 3)
> > 	IT8712F rev. 0.7 (chip revision 6)
> > 	IT8712F rev. 0.81 (chip revision 7)
> > 
> > In all those specifications, the registers exist and are called "Thermal Diode
> > Zero Degree Adjust {1|2|3} Register".
> 
> Right, but the contents are different from what later chips have. The
> default value (56h) and description (Zero Degree *Voltage Value*) make
> it quite clear to me.
> 
Yes, I noticed that later.

> > Kind of odd (and a bit scary) that they would remove the registers with later
> > chip revisions. Anyway, I'll have to see if I can find any additional versions
> > of the specifications.
> 
> No, they did not remove these in later chip revisions. They changed the
> register unit/values with the IT8716F.
> 
> > Maybe I should simply drop the attributes for IT8705F and IT8712F ?
> 
> Agreed.
> 
Ok.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
