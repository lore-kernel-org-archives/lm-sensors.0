From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Date: Fri, 06 Jul 2007 11:39:47 +0000
Subject: Re: [lm-sensors] [PATCH] THMC50 support for 2.6 (2nd revision)
Message-Id: <468e2a0312caa@wp.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070702195448.2814dfb7.krzysztof.h1@wp.pl>
In-Reply-To: <20070702195448.2814dfb7.krzysztof.h1@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Dnia 6-07-2007 o godz. 12:01 Jean Delvare napisa=B3(a):
> Hi Krzysztof,
>=20
> On Wed, 4 Jul 2007 19:16:18 +0200, Krzysztof Helt wrote:
> > On Wed, 4 Jul 2007 11:36:07 +0200 Jean Delvare wrote:
> > > > +set(temp_max, THMC50_REG_TEMP_OS);
> > > > +set(temp_hyst, THMC50_REG_TEMP_HYST);
> > > > +set(remote_temp_max, THMC50_REG_REMOTE_TEMP_OS);
> > > > +set(remote_temp_hyst, THMC50_REG_REMOTE_TEMP_HYST);
> > > > +set(remote_temp2_max, ADM1022_REG_REMOTE_TEMP2_OS);
> > > > +set(remote_temp2_hyst, ADM1022_REG_REMOTE_TEMP2_HYST);
> > >=20
> > > Side note: all these macro-generated functions should
replaced by nice
> > > dynamic sysfs callbacks.
> >=20
> > Should I rewrite it before posting a driver?
>=20
> No,=20

I changed them after your latest patch which added "dynamic sysfs
callbacks".

> > If I use the MSB bit to detect adm1022 it means that it is
the adm1022 chip in the
> > second mode. The adm1022 in the first mode would be detected
as the thmc50.
>=20
> Oops, sorry. I'm now realizing that the sensors-detect code is
wrong,
> and that confused me. The bit I was thinking of was not bit 7
but bit 4
> of the configuration register (Soft Reset). This bit is essentially
> write-only so it should always read 0. This can be used to
improve the
> detection for both chips.
>=20

Ok.=20

> I just fixed sensors-detect so that it checks bit 4 instead of
bit 7.
> Bit 7 can also be checked for the THMC50 (and the ADM1028) but
not the
> ADM1022, as you found out. I guess that sensors-detect was only
> detecting one of your 2 ADM1022 chips?=20

Yes.=20

> Can you please try the
> sensors-detect version from SVN and confirm that it detects
your two
> ADM1022 chips properly now?
>=20

Yes.

> > Should the data->type store the chip type or its working mode?
>=20
> Other drivers store the chip type in data->type (if needed),
and add
> dedicated fields to the data structure if they need to remember
working
> modes.=20

I'll think of it.

> > It works with sensors3 and after addition to the sensors.conf
it works with the AP550
> > MB (motherboard).
>=20
> Don't you want to submit support for lm-sensor 2.10.x too? We
have no
> clear idea when lm-sensors 3.0.0 will be released.
>=20

If I have the driver in the kernel I'll try.=20

> For sensors.conf, I suggest that you write a dedicated
configuration
> file for your motherboard rather than adding to sensors.conf.eg.
>=20
> > I have problem how to name temperature values. There are 5
temperature values:
> >=20
> > 1 & 2 - inside CPUs (I have to find which one is CPU0)
> > 3 - in the chip which is mounted on the MB next to CPUs
(corner of the MB - the air from
> > CPUs is ducted there)
> > 4 - in the chip which is mounted on the MB next to memory
slot (which is in the half
> > length of the MB)
> > 5 - remote temperature from the second chip. I don't know
where the sensor is located
> > but it is 5 degrees higher then the temperature 4 (maybe
inside RIMM memory or next
> > to graphics card?).
>=20
> Sensor locations are sometimes mentioned on the motherboard
manuals, [...]


I need help how to name the temperature 3 and 4. They are both on
the MB. Do you have any standard for naming temperatures in the
lmsensors lib (like CPU are always "Temp CPUx")?

Thanks for the tip with hair-dryer.

Regards,
Krzysztof=20

----------------------------------------------------
ROLLING STONES - A BIGGER BANG
Warszawa S=B3u=BFewiec 25 lipca 2007 r.=20
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Frollingstone=
s.html&sid=1213



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
