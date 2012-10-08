From: Klaus Dahlke <klaus.dahlke@gmx.de>
Date: Mon, 08 Oct 2012 20:37:18 +0000
Subject: Re: [lm-sensors] Temperature reading too high for it87
Message-Id: <20121008223718.60387922.klaus.dahlke@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20121001225656.0e964dbe.klaus.dahlke@gmx.de>
In-Reply-To: <20121001225656.0e964dbe.klaus.dahlke@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi G=FCnter,
thanks for the comments.

In meanwhile I put some load to the system when compiling a couple of progr=
ams. K10temp and temp3 go up then. I operate my PC as dual boot. On Windows=
 7 the 'speedfan' program reports also ~60=B0C for temp2 whereby the Gigaby=
te utility program reports only temp1 and temp3. temp1 is the 'system tempe=
rature', temp3 the APU temp. An indication for that is that k10temp and tem=
p3 have 70=B0C as high warning. In the BIOS I only set the CPU temperature =
to high=3D70=B0C, the system temperature is on 'auto'. Anyhow, as the syste=
ms works fine in the moment, I don't mind the weird readings.

Best regards,
Klaus=20



On Thu, 4 Oct 2012 19:55:21 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On Mon, Oct 01, 2012 at 10:56:56PM +0200, Klaus Dahlke wrote:
> >=20
> > Dear all,
> > I just put together a new PC with the following components:
> > mainboard: Gigabyte GA-A75M-UD2H, newest BIOS (beta)
> > CPU: AMD A8-3850 APU
> >=20
> > Using lm_sensors, one temperature of the APU via it87 is shown far too =
high. The BIOS/PC Health Status (after reboot) reports basically 34=B0C and=
 34=B0C which were also the usual temparatures at my old PC when just surfi=
ng or doing some office stuff. But for teh new PC lm_sensors shows now for =
the CPU a temperature of 59=B0C which is about the sum of the first tempera=
ture and the temperature in the case/housing (case has an own thermocouple)=
. It is the same behaviour with the kernel module as well as the driver fro=
m your download page.
> >=20
> > I would be happy if you could investigate a bit further to get also a c=
orrect temperature reading.
> >=20
> >=20
> > $ sensors
> > k10temp-pci-00c3
> > Adapter: PCI adapter
> > temp1:         +3.8=B0C  (high =3D +70.0=B0C)
> >=20
> This is reported by the CPU and a relative value. A number of people have=
 reported
> similar low values. I start suspecting that it may have to do with the fa=
ct
> that thermal control is disabled on your board (which we know because the=
re is
> no critical temperature reported), and that the reported temperature is p=
ossibly
> relative to the critical temperature, which in turn may be initialized to=
 a much-too-low
> value (eg 70 degrees C instead of around 100 degrees C). But someone from=
 AMD would have
> to confirm that, and/or someone with an AMD board would have to play with=
 it to
> confirm if that is really the case.
>=20
> > it8720-isa-0228
> > Adapter: ISA adapter
> > in0:          +1.02 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> > in1:          +1.49 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> > in2:          +3.34 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> > +5V:          +3.02 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> > in4:          +3.09 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> > in5:          +2.13 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> > in6:          +2.13 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> > 5VSB:         +2.99 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> > Vbat:      +3.07 V =20
> > fan1:        1115 RPM  (min =3D   10 RPM)
> > fan2:        1147 RPM  (min =3D    0 RPM)
> > fan3:           0 RPM  (min =3D    0 RPM)
> > temp1:        +34.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  se=
nsor =3D thermistor
> > temp2:        +59.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  se=
nsor =3D thermistor
> > temp3:        +13.0=B0C  (low  =3D +127.0=B0C, high =3D +70.0=B0C)  sen=
sor =3D thermistor
>=20
> Those temperature values are as reported to the chip by the hardware. Dep=
ending
> on the board and the actual sensors, the reported value can differ from t=
he real
> temperature. Unfortunately, that is board specific, and compensation would
> depend on information from the board vendor. The chip has registers to
> compensate for that, but there is no guarantee that those registers are
> initialized by the BIOS, and the it87 Linux driver does not support writi=
ng them.
>=20
> On the other side, it may well be possible that _some_ component runs a b=
it
> hotter than others on your board, and that temp2 reports such a temperatu=
re.
> I see that, for example, with the PCH chip on one of my Intel boards. But=
 unless
> you run your computer in a fridge, 13=B0C is really a bit on the low side=
 ;).
>=20
> Only idea I have would be to adjust the raw readings in your sensors.conf=
 file
> to something you think is reasonable.
>=20
> Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
