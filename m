From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Date: Wed, 04 Jul 2007 07:25:05 +0000
Subject: Re: [lm-sensors] THMC50 and ADM1022 support for 2.6 kernel(improved)
Message-Id: <468b4b512db1e@wp.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070701205003.71ae723b@hyperion.delvare>
In-Reply-To: <20070701205003.71ae723b@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Dnia 3-07-2007 o godz. 23:17 Jean Delvare napisa=B3(a):
> Hi Krzysztof,
>=20
> On Sun, 1 Jul 2007 23:37:33 +0200, Krzysztof Helt wrote:

> > The analog output has range from 0 to 255. The 0 value is the
least value possible but
> > it is not 0 voltage on output pin. It simply must be adjusted
to the range 1-255
> > to conform with sysfs. I choose this way as the simplest.
Another possibility is
> > to scale this value when set and displayed from 1-255 (sysfs)
to 0-255 (chip) range.
> >
> > The sysfs 0 value for pwm1 is translated to setting a special
bit which cuts off the
> > fan power completely (this works on my motherboard and it is
given in reference
> > design, but I cannot guarantee it is connected this way on
all boards).=20
>=20
> I see. Scaling from 1-255 to 0-255 would be counterproductive,
but is
> it really what you want to do? You say that a register value
doesn't
> stop the fan, suggesting that the analog output isn't 0V? Do
you know
> how much it is? For example, if the full analog output is 2.5 V
and a
> register value of 0 means an output of 1.0 V, then you want to
map the
> register values 0 to 255 to sysfs values 102 to 255. 0 would
stop the
> fan, and values from 1 to 101 would behave the same as 102 (i.e.
> minimum non-stop speed). See what I mean?
>=20

I see, but my explanation was not quite clear/true.

According to docs, the THMC50 produces range between 0 and 2.5V.
The residual voltage (0 value !=3D 0 V) comes from the external
power amplifier. There are 6 example designs of external power
amplifier given in the THMC50's datasheet. Most of the are
powered by 0 - 12V so they are usually unable to produce the full
0-12V swing (as amplifiers and transistors cannot give output up
to power voltage limits). One design (the cheapest) is said to
not give full voltage swing by design.  That's why they have the
fan off bit - to be able to stop the fan.

One of designs is powered from +/-12V and this one certainly can
produce true 0V output - in such case the 0 value would stop fan
and the fan off pin may be left unconnected. As you can see, my
driver writes 0 value into the fan speed register along with
setting of the fan off bit  - to cover both cases.

The residual voltage is simple imperfection of analog parts
outside the chip and the value of this voltage is as random as
the choice of analog elements mounted on  motherboards (will vary
with production batch change and type of elements e.g. change of
supplier).

Summary: one knows that 0 value produces 0V at the chip pin and
at the same time one knows it is not 0V at the fan pins in most
of reference designs (hence the separate fan off bit).=20

Regards,
Krzysztof

----------------------------------------------------
Legenda Hip-Hopu w pelnym 9 osobowym skladzie, na jedynym koncercie=20
w Polsce WU-TANG CLAN.=20
19 lipca 2007 r, godz. 20.00 - Warszawa, klub Stodo=B3a.=20
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fwutangclan.h=
tml&sid=1210



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
