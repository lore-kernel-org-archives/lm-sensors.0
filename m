From: =?utf-8?Q?G=C3=B6ran_Uddeborg?= <goeran@uddeborg.se>
Date: Wed, 19 Sep 2012 21:56:57 +0000
Subject: Re: [lm-sensors] Configuration for Foxconn A7GM-S 2.0
Message-Id: <20570.16297.466581.899113@freddi.uddeborg>
List-Id: <lm-sensors.vger.kernel.org>
References: <20556.55176.173597.530756@freddi.uddeborg>
In-Reply-To: <20556.55176.173597.530756@freddi.uddeborg>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Jean Delvare:
> I'm happy to see that my article in the wiki starts being helpful :)

:-)

> What were the values of in3, in6 and in7?

When I had identified the sensors that were reported in the BIOS, I
ignored the other ones.  They all gave SOME value.  I assumed they
were not connected and just showed a random value.  But I show the raw
output of "sensors" at the end of this mail.

> One of these could be +5V,
> it's usually monitored (even though the lack of mention in your BIOS
> suggests that might not be the case here.) One could be 5VSB. Both
> would need scaling so are more likely to appear in the 2.5 - 3.3 V
> range unscaled.

in3 is labeled +5V by the driver, and reports 2.93V, so that seems to
match what you say.  How would I go about figuring out the scaling
factor?

in6 at 1.12V and in7 at 4.08 are both outside that range.

> in8 is normally Vbat on the IT8716F, it shouldn't need scaling. Didn't
> it report a correct value for you?

It reports 3.20V, which I guess makes sense.  These batteries are
nominally rated 3V unless I'm mistaken.  And this board is fairly new,
so a little bit above that sounds reasonable to me.

> You can just make this:
>=20
>      compute in4  @ * 4, @ / 4
>=20
> This is more efficient.

Ok.  I kept the ratios as a kind of documentation, but maybe that's
overkill.

> Then for the wiki version of your configuration file, we won't ignore
> any input. Better print 0 RPM than omit a running fan.

Yes, that makes sense.  I'll try to remember to check next time I have
the box open for some reason which one is the chassis fan.

> >      # Min and max for Athlon II X2 245e
> >      set in0_min  0.875
> >      set in0_max  1.4
>=20
> Did you check if the BIOS had set proper limits on its own?

No.  Would that be the limits given before I did "sensors -s"?

> This all looks very good, I've added your configuration file to the
> wiki:

Happy to be able to help!

Raw output of sensors without any local configuration follows.  (I
haven't tried to undo the "sensors -s" though.  I'm not sure if I can
do that without rebooting the machine, which I don't want to do right
now.)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
acpitz-virtual-0
Adapter: Virtual device
temp1:        +40.0=B0C  (crit =3D +60.0=B0C)

k10temp-pci-00c3
Adapter: PCI adapter
temp1:        +30.0=B0C  (high =3D +70.0=B0C)

it8716-isa-0e80
Adapter: ISA adapter
in0:          +1.31 V  (min =3D  +0.88 V, max =3D  +1.41 V)
in1:          +1.87 V  (min =3D  +1.70 V, max =3D  +1.90 V)
in2:          +3.34 V  (min =3D  +3.14 V, max =3D  +3.47 V)
+5V:          +2.93 V  (min =3D  +0.00 V, max =3D  +4.08 V)
in4:          +3.02 V  (min =3D  +2.85 V, max =3D  +3.15 V)
in5:          +1.10 V  (min =3D  +1.04 V, max =3D  +1.15 V)
in6:          +1.12 V  (min =3D  +0.00 V, max =3D  +4.08 V)
in7:          +4.08 V  (min =3D  +1.01 V, max =3D  +4.08 V)  ALARM
Vbat:         +3.20 V =20
fan1:        2288 RPM  (min =3D   11 RPM)
fan2:           0 RPM  (min =3D    0 RPM)
fan3:           0 RPM  (min =3D    0 RPM)
temp1:        +34.0=B0C  (low  =3D +127.0=B0C, high =3D +50.0=B0C)  sensor =
=3D thermal diode
temp2:        +34.0=B0C  (low  =3D +127.0=B0C, high =3D +112.0=B0C)  sensor=
 =3D thermistor
temp3:        +73.0=B0C  (low  =3D +127.0=B0C, high =3D +112.0=B0C)  sensor=
 =3D thermal diode
cpu0_vid:    +0.375 V
intrusion0:  OK

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
