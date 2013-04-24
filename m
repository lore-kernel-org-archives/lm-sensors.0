From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 24 Apr 2013 22:47:31 +0000
Subject: Re: [lm-sensors] [PATCHv1 1/3] hwmon: Add support for GMT G762/G763 PWM fan controller
Message-Id: <20130424224731.GB7767@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1366753420.git.arno@natisbad.org>
 <63961d39aee9db94767f28fd441312bec2029473.1366753420.git.arno@natisbad.org>
 <20130424053758.GC8710@lunn.ch>
 <87obd4wb4e.fsf@natisbad.org>
 <20130424133856.GA18851@roeck-us.net>
 <87li878ygw.fsf@natisbad.org>
In-Reply-To: <87li878ygw.fsf@natisbad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Arnaud Ebalard <arno@natisbad.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Jean Delvare <khali@linux-fr.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, lm-sensors@lm-sensors.org, devicetree-discuss@lists.ozlabs.org, Rob Landley <rob@landley.net>, linux-doc@vger.kernel.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, Simon Guinot <simon.guinot@sequanux.org>, Olivier Mouchet <olivier.mouchet@gmail.com>

On Wed, Apr 24, 2013 at 10:28:47PM +0200, Arnaud Ebalard wrote:
> Hi,
>=20
> Guenter Roeck <linux@roeck-us.net> writes:
>=20
> >> > You could consider using regmap for holding this cache.
> >> >
> >> > http://elceurope2012.sched.org/event/100619b669ce5767341624253aa0365=
9?iframe=3Dno&w=900&sidebar=3Dyes&bg=3Dno#.UXdspHLQ5jM
> >> >
> >> > http://elinux.org/ELCE_Europe_2012_Presentations
> >>=20
> >> Interesting. As I am not yet familiar w/ regmap I would prefer having
> >> the driver accepted during merge window with current data structure and
> >> then convert it to regmap. But I will take a look (e.g. will study
> >> fca1dd03 for instance). Thanks for the pointers.=20
> >>=20
> > I have not had time for a detailed review, but adding regmap support
> > will not be a requirement.
> >
> > Note that it is too late for 3.10, so the driver will have to wait for
> > 3.11.
>=20
> Well, I think I can live with it; The only bad thing is that it kills my
> excuses not to spend time on regmap ;-)
>=20
Your call.

>=20
> >> >> +/*
> >> >> + * Helpers to import hardware characteristics from .dts file and o=
verload
> >> >> + * default config values.
> >> >> + */
> >> >> +
> >> >> +#ifdef CONFIG_OF
> >> >
> >> > Can the driver be used without device tree? Would it be simpler to
> >> >  just add depends OF in the Kconfig entry?
> >>=20
> >> It can be used if the default params (or those configured by u-boot I
> >> guess) fit your needs. I think it would be fairly easy to extend the
> >> driver later to expose g762_config struct to allow parameters to be set
> >> w/o using OF. If someone wants to do that, I think it is better to not
> >> depend on OF in Kconfig at the moment but I have not strong argument
> >> other that that one. I'll let you decide.
> >>=20
> > Agreed. As long as there are major platforms not supporting device tree,
> > and as long as device tree overlays are not supported, it must not be m=
ade
> > mandatory. Especially for I2C and SPI devices I reserve the right to be=
 able
> > test the hardware on an X86 system and not require a reboot to do so.
>=20
> Understood. Following Simon's post, I think it's useful to implement
> some init function for non DT-enabled platforms.=20
>=20
Sure, as long as Simon commits to test it and - if possible - to provide
the necessary platform code.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
