From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 08 Feb 2011 20:06:44 +0000
Subject: Re: [lm-sensors] tempX_source sysfs attribute needed ?
Message-Id: <1297195604.24938.60.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110208171026.GE13717@ericsson.com>
In-Reply-To: <20110208171026.GE13717@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, 2011-02-08 at 13:03 -0500, Ian Dobson wrote:
>=20
> --------------------------------------------------
> From: "Guenter Roeck" <guenter.roeck@ericsson.com>
> Sent: Tuesday, February 08, 2011 6:10 PM
> To: <lm-sensors@lm-sensors.org>
> Subject: [lm-sensors] tempX_source sysfs attribute needed ?
>=20
> > Hi all,
> >
> > in the recent months, I have seen two instances where a sysfs attribute
> > identifying the source associated with a temperature sensor would have =

> > been
> > helpful.
> >
> > One is max6639. For this chip, the source of the second temperature=20
> > channel
> > can be configured to be local or remote.
> >
> > The others are W83677HG-B, NCT6775F, and NCT6776F. Those chips have fou=
r=20
> > to six
> > temperature channels with a configurable source.
> >
> > Current approach is to stick with whatever is configured by the BIOS fo=
r=20
> > the Nuvoton
> > chips, and to use the local source for the max6639 driver. For the Nuvo=
ton=20
> > chips,
> > my prototype driver for NCT6775F and NCT6776F reports the temperature=20
> > source
> > in tempX_label.
> >
> > Possible solutions might be:
> > - Stick with the current situation, ie do nothing.
> > - Use module parameters. Doesn't really work well for max6639 since it =

> > affects
> >  all instances of the driver, and if the driver is built into the kerne=
l.
> > - Use platform data. Might work for max6639, but not for the Nuvoton=20
> > chips.
> > - Define a new sysfs attribute to make the temperature source=20
> > configurable,
> >  and to report the current selection.
> >
> > Any thoughts/comments ?
> >
> > Thanks,
> > Guenter
> >
> > _______________________________________________
> > lm-sensors mailing list
> > lm-sensors@lm-sensors.org
> > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>=20
> Hi Guenter,
>=20
> I actually think it's a good idea (tempX_label), I've already seen that=20
> sensors can use this information if you don't have a label defined in=20
> sensors3.conf. It actually makes is alot easier to configure the=20
> sensors3.conf file correctly. I'm not sure if _label is the correct name,=
 it=20
> really describes the source of the signal.
>=20
tempX_label is a textual description, so I think it does make sense for
this driver.=20

> Also with the nuv chips what happens if you change the source for a=20
> temperature input that's used by smartfan? The BIOS should know what's be=
st=20
> and playing with the fan control inputs could cause all sorts of problems=
.=20
> During my hacking in the nct6776f driver I managed to screw up the smartf=
an=20
> control so much that the temperature setpoint for one of the fans was 90=
=C2=B0c=20
> and the fan stopped.
>=20
Yes, that is always a risk.=20

I don't really know if tempX_source adds any real value - that is why I
was asking for feedback. Ultimately the information is very board
specific, so providing tempX_label for the Nuvoton chips and using - if
ever needed - platform data for the max6639 may well be good enough.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
