From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 23 Nov 2010 22:05:38 +0000
Subject: Re: [lm-sensors] Further documentation for w83627hf module
Message-Id: <20101123230538.6ec14a59@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTimY3Eu++=eQjR-VG0oOtW_1ko7AkGdcXo=8kBs3@mail.gmail.com>
In-Reply-To: <AANLkTimY3Eu++=eQjR-VG0oOtW_1ko7AkGdcXo=8kBs3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Julian,

On Tue, 23 Nov 2010 21:25:48 +0100, Julian Brunner wrote:
> Hello Jean,
>=20
> On Mon, Nov 22, 2010 at 10:49 PM, Jean Delvare <khali@linux-fr.org> wrote:
> > Are you sure you declared the proper compute formula based on the
> > resistor values they provided? +3.26V looks like an unscaled value.
>=20
> Well, the document doesn't say anything about resistors for that
> particular pin (AVCC, Pin 114), and the "Multiply factor" is supposed
> to be 1.

This isn't possible. The W83627THF has a 4.08 V ADC, so any voltage
above 4 V has to be scaled down using resistors.

> > (...)
> > Google for "W83627THF datasheet". On the datasheet, there's one page
> > with the chip drawn and pin numbers with functions.
>=20
> I've had had a look at this datasheet a few weeks ago already, I've
> also seen the page with the pin layout and description. Still, I can't
> figure out how this tells me on which sysfs file a particular pin's
> value would appear (for example, the description of VIN0 only says "0V
> to 4.096V FSR Analog Inputs"). And how would the authors of the
> datasheet know about this mapping in the first place? I feel like I'm
> getting something completely wrong here, it'd be great if you could
> clarify how I would get the information I need out of this document.

The datasheet tells you the mapping between pins and registers. The
driver's source code tells you the mapping between registers and sysfs
attributes. I admit the information isn't immediately available, you
have to work out your way through the datasheet and the source code,
but the information is definitely there.

I admit that it would be easier if our documentation listed the pin <->
register <-> sysfs attribute mappings, however this would have to be
updated with every new chip we support, because manufacturers try to
make register-compatible devices (to some extent) but most often don't
care about pin compatibility (not for hardware monitoring features at
least.) Also, cases where you need to deal with the pin numbers are
rare, so this seems to be quite an investment for little return.

> > That being said, the information provided by Kontron should be
> > sufficient to write a libsensors configuration file. If you could share
> > the information with us, together with the configuration file you came
> > up with, we should be able to help you fix it.
> >
> > Please also include the raw output of sensors (sensors -c /dev/null),
> > we will use it as a basis to validate the compute statements.
>=20
> I've uploaded the document Kontron sent me at
> http://multiserver.ath.cx/LM%20Sensor%20correction%20tables.pdf
> (unfortunately, the connection is somewhat unstable, if it doesn't
> work, try a few hours later or the next day, I think I can't attach
> pdf files when sending stuff to the mailing list).

I managed to download it :)

Assuming the labels are OK, there are clearly resistor values missing.
+5V and 5VSB definitely can't be measured without scaling resistors.

> The configuration for lm-sensors I'm currently using is this:
>=20
> chip "w83627thf-*"
>=20
>     label in0 "VCore A"
>     label in1 "+12 V"
>     label in2 "+5 V"
>     label in3 "+3 V"

There is no 3V in computers except for Vbat. So this would be  3.3V as
well (but see below.)

>     label in4 "+3.3 V"
>     label in5 "VCore B"

Better labelled "+1.5 V". Modern CPUs don't have a second Vcore. This
line is more likely monitoring the AGP voltage, or chipset voltage, or
memory (DDR3) voltage.

>     label in7 "+5 VSB"
>     label in8 "V Battery"
>=20
>     label temp1 "System Temperature"
>     label temp2 "CPU Temperature"
>     label temp3 "External Temperature"
>=20
>     label fan1 "System Fan"
>     label fan2 "CPU Fan"
>     label fan3 "External Fan"
>=20
>     compute in0 1.000 * @, @ / 1.000

Note that you can simply omit such compute statements. Omitting them
makes libsensors faster.

>     compute in1 3.801 * @, @ / 3.801
>     compute in2 1.000 * @, @ / 1.000
>     compute in3 1.000 * @, @ / 1.000
>     compute in4 1.000 * @, @ / 1.000
>     compute in5 1.000 * @, @ / 1.000
>     compute in7 1.000 * @, @ / 1.000
>     compute in8 1.000 * @, @ / 1.000
>=20
> The output from sensors -c /dev/null is:
>=20
> w83627thf-isa-0a00
> Adapter: ISA adapter
> in0:         +0.97 V  (min =3D  +0.70 V, max =3D  +1.87 V)
> in1:         +3.17 V  (min =3D  +2.77 V, max =3D  +0.27 V)   ALARM
> in2:         +3.26 V  (min =3D  +1.54 V, max =3D  +0.54 V)   ALARM
> in3:         +2.96 V  (min =3D  +3.07 V, max =3D  +0.29 V)   ALARM
> in4:         +1.52 V  (min =3D  +0.10 V, max =3D  +1.18 V)   ALARM
> in7:         +2.96 V  (min =3D  +0.00 V, max =3D  +2.05 V)   ALARM
> in8:         +3.12 V  (min =3D  +1.02 V, max =3D  +0.05 V)   ALARM
> fan1:          0 RPM  (min =3D 15340 RPM, div =3D 2)  ALARM
> fan2:       2789 RPM  (min =3D 84375 RPM, div =3D 2)  ALARM
> fan3:          0 RPM  (min =3D 5075 RPM, div =3D 2)  ALARM
> temp1:       +77.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +4.0=B0C)  ALARM  =
sensor =3D thermistor
> temp2:       +67.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor
> temp3:       +60.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor
>=20
> So 12 V seems to be alright, VCore, too, I'll have to check with the

Yes.

> BIOS values later to confirm. 3 V could be right too, but seeing how
> almost everything else is messed up, I'm not too sure that's not just
> a coincidence, too.

From the above, I am almost certain you have the following:

in0 -> Vcore
in1 -> +12V
in2 -> +3.3V
in3 -> +5V (scaling needed)
in4 -> +1.5V
in7 -> 5VSB (scaling needed)
in8 -> Vbat

See how in5 doesn't exist, contrary to what the Kontron documentation
claims. So their documentation is definitely not correct. I suggest
that you recontact Kontron with that information and ask them for a
corrected document. Feel free to include me in the e-mail discussion.

Could you please check in the BIOS, which voltages are displayed and in
which order? And also the values of +5V and 5VSB.

> The temperatures are kinda off, too, seeing how
> coretemp reports 47 =BAC.

Coretemp doesn't report accurate values, so I wouldn't use it as a
reference.

Do you really have a single fan in the system?

> I'm not really sure what to do at this point, and whether I got
> something backwards or the information from Kontron is incorrect. So
> any pointers on what might be going on here are greatly appreciated.

The information provided by Kontron is inconsistent, so I'm certain it
is incorrect. Hopefully they can provide fixed data.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
