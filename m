From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 01 Nov 2012 13:40:51 +0000
Subject: Re: [lm-sensors] [PATCH 9/9] hwmon: (it87) Report thermal sensor type as Intel PECI if appropriate
Message-Id: <20121101134051.GA11091@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1351448401-13985-10-git-send-email-linux@roeck-us.net>
In-Reply-To: <1351448401-13985-10-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Nov 01, 2012 at 01:56:07PM +0100, Jean Delvare wrote:
> On Mon, 29 Oct 2012 10:28:30 -0700, Guenter Roeck wrote:
> > On Mon, Oct 29, 2012 at 05:55:20PM +0100, Jean Delvare wrote:
> > > On Sun, 28 Oct 2012 11:20:01 -0700, Guenter Roeck wrote:
> > > > diff --git a/Documentation/hwmon/it87 b/Documentation/hwmon/it87
> > > > index 92ce617..3d938aea 100644
> > > > --- a/Documentation/hwmon/it87
> > > > +++ b/Documentation/hwmon/it87
> > > > @@ -217,4 +217,5 @@ Temperature offset attributes
> > > >  The driver supports temp[1-3]_offset sysfs attributes to adjust the reported
> > > >  temperature for thermal diodes or diode connected thermal transistors.
> > > >  If a temperature sensor is configured for thermistors, the attribute values
> > > > -are ignored.
> > > > +are ignored. If the thermal sensor type is Intel PECI, the temperature offset
> > > > +must be programmed to the critical CPU temperature.
> > > 
> > > I don't quite get this part.. Who should do that, and how?
> >
> > The BIOS, presumably. It does it on my board, but wrongly. It sets it
> > to 97 degrees C, while the CPU's Tcrit is 105 degrees C. I fixed the
> > offset to 105, and now the reported temperature matches the CPU temperature
> > (and moves with it). This is how I found out about PECI support in the
> > first place.
> 
> In which register is the PECI temperature offset value stored? I am
> looking at the IT8720F datasheet and I can't find it.
> 
On IT8728F it is in the diode zero degree adjust registers.
I found this from experiments; it is not mentioned in the datasheet.
I would guess it is the same on the other chips, though I can not test
it on those.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
