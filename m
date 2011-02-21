From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 21 Feb 2011 23:04:44 +0000
Subject: Re: [lm-sensors] Using dme1737 to read sensor data when an ACPI
Message-Id: <20110221230444.GA10800@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTikYuVDyhet3uT7u1Vivw908C31wsqfp=wg0qgkd@mail.gmail.com>
In-Reply-To: <AANLkTikYuVDyhet3uT7u1Vivw908C31wsqfp=wg0qgkd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, Feb 21, 2011 at 01:30:31PM -0500, James Mills wrote:
> Does anyone have any information on my question below?  I would just
> like to put my mind at ease if at all possible.  Again, I will only be
> using this module to poll sensors.
>=20
Top-posting is discouraged.

Searching for dme1737, SCH3114 and acpi on the web suggests that there can =
be
interference between dme1737 and acpi, and that it is not a good idea to ha=
ve
both active. There were a number of discussions about this issue on this fo=
rum,=20
all suggesting the same.

Not sure what else can be said.

Guenter

> Thanks!
> ~james
>=20
> On Wed, Feb 16, 2011 at 9:31 AM, James Mills <jameswmills@gmail.com> wrot=
e:
> > All,
> >
> > I am working on a project with a SCH3114. =A0By default, when I modprobe
> > dme1737, it fails with an ACPI conflict. =A0In the short term, I have
> > added "acpi_enforce_resources=3Dlax", and the module now loads and
> > sensors are displayed.
> >
> > However, I am concerned with the dmesg:
> >
> > ACPI: resource dme1737 [io =A00x0a70-0x0a71] conflicts with ACPI region
> > RNTR [??? 0x00000a00-0x00000a7f flags 0x52]
> > ACPI: This conflict may cause random problems and system instability
> >
> > All we want is for the sensor data provided by this module to be
> > polled periodically.
> >
> > Can anyone tell me what the real risk is of using this module in
> > conjunction with "lax" ACPI? =A0Is there a way to put this module in
> > "read-only" mode or some other mode that minimizes the potential for
> > system instability?
> >
> > Any information is appreciated!
> > ~james
> >
>=20
>=20
>=20
> --=20
> you've gotta live light enough to see the humor
> and long enough to see some change
> ~ Ani DiFranco
>=20
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
