From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 14 Sep 2009 10:10:24 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] k8temp add support for family 10h and
Message-Id: <20090914121024.23cb7754@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <48E3F7B6.4000901@assembler.cz>
In-Reply-To: <48E3F7B6.4000901@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Rob,

On Sun, 06 Sep 2009 17:27:08 -0700, Rob Robason wrote:
> I'm running my Fedora 11 system on an AMD Athlon 64 X2 7750 processor
> and Gigabyte GA-MA78GM-US2H motherboard.=20
> Running sensors-detect(8) finds the embedded "AMD K10 thermal sensors"
> and reports "(driver "to be written"). In the summary it reports:
>=20
>         Driver `to-be-written':
>           * Chip `AMD K10 thermal sensors' (confidence: 9)
>        =20
>         Note: there is no driver for AMD K10 thermal sensors yet.
>         Check http://www.lm-sensors.org/wiki/Devices for updates.
>=20
> Checking the site, I found the subject topic and wondered if the 10h
> family is synonymous with K10, and if the subject patch applies to my
> system?

Yes, "K10" and "family 10h" are synonyms.

But anyway, the family 10h sensors are known to be unreliable so they
will never be supported. I'll update sensors-detect in a minute so that
it stops giving false hopes to users.

> The sensors(1) app appears to pick up temperature readings from my
> system, but I'm not able to figure out the mapping of the values I'm
> getting (sample below):
>=20
>         $ sensors
>         it8718-isa-0228
>         Adapter: ISA adapter
>         in0:         +1.04 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
>         in1:         +1.95 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
>         in2:         +3.30 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
>         in3:         +2.96 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
>         in4:         +3.06 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
>         in5:         +4.08 V  (min =3D  +0.00 V, max =3D  +4.08 V)   ALARM
>         in6:         +4.08 V  (min =3D  +0.00 V, max =3D  +4.08 V)   ALARM
>         in7:         +2.03 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
>         Vbat:        +3.30 V
>         fan1:       2537 RPM  (min =3D   10 RPM)
>         fan2:          0 RPM  (min =3D    0 RPM)
>         fan3:          0 RPM  (min =3D    0 RPM)
>         fan4:          0 RPM  (min =3D    0 RPM)
>         temp1:       +44.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C=
)  sensor =3D thermistor
>         temp2:       +37.0=B0C  (low  =3D +127.0=B0C, high =3D +60.0=B0C)=
  sensor =3D thermal diode
>         temp3:       +46.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C=
)  sensor =3D thermistor
>         cpu0_vid:   +1.550 V

You should be able to figure out fan mappings by comparing with what
the BIOS says.

For temperatures, temp2 would be the CPU temperature, while temp1 and
temp3 would be mainboard temperatures. Again, comparing with what the
BIOS says should help. The fact that the CPU temperature is lower than
the system temperature is somewhat suspicious, although not impossible.

For voltages it's a little more difficult. Checking what the BIOS
reports would definitely help. For reference, the recommended wiring
for the IT8718F is:

in0 -> Vcore1
in1 -> Vcore2
in2 -> +3.3V
in3 -> +5V (scaling factor 1.68)
in4 -> +12V (scaling factor 4)
in5 -> -12V
in6 -> -5V
in7 -> +5V Stand-By (scaling factor 1.68)

But in practice most boards no longer monitor negative voltage lines
any longer, and as a matter of fact your board doesn't. So you can
start with:

   ignore in5
   ignore in6

And CPUs tend to have a single Vcore these days so in1 is more likely
Vdimm. So a first approximation would be:

   label in0 "Vcore"
   label in1 "Vdimm"
   label in2 "+3.3V"
   label in3 "+5V"
   label in4 "+12V"

   compute in3 @ * 1.68, @ / 1.68
   compute in4 @ * 4, @ / 4

Not sure about 5VSB.

If you come up with a good complete configuration, please post it so
that we can add it to the wiki.

> Can you help me understand whether I need to wait for a K10 driver, can
> use the subject patch, or need nothing? If waiting for the K10 driver is
> the answer, can you give me any sense of when that might be available?
> If I can use the patch, can you guide me on how to apply it to my
> system?

Don't wait for a patch or new driver, there won't be any. Best thing you
can do is tweak your IT8718F configuration to match your mainboard.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
