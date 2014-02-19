From: ianp <braveheart_leo@yahoo.com>
Date: Wed, 19 Feb 2014 11:47:50 +0000
Subject: Re: [lm-sensors] W83627DHG-P sensor shows a single voltage monitor for +5V and +12V on in4?
Message-Id: <1392810470.21584.YahooMailNeo@web160504.mail.bf1.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392773023.4498.YahooMailNeo@web160503.mail.bf1.yahoo.com>
In-Reply-To: <1392773023.4498.YahooMailNeo@web160503.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> On Wednesday, February 19, 2014 4:53 PM, Jean Delvare <jdelvare@suse.de> =
wrote:

> No, this isn't correct. We stopped with this long ago. Today the file
> installed as /etc/sensors3.conf only contains statements which are
> always correct. The comment at the top of the file says exactly that:
>=20
> # This default configuration file only includes statements which do not
> # differ from one mainboard to the next. Only label, compute and set
> # statements for internal voltage and temperature sensors are included.
>=20
> If you look at the W83627DHG-P datasheet, you'll see that in2, in3, in7
> and in8 monitor the chips's own power sources (AVCC, 3VCC, 3VSB and
> Vbat in this order.) The chip can monitor only 5 external voltages,
> with Vcore always being in0 and in1, in4, in5 and in6 being the generic
> inputs which can be used to monitor any other voltage.
>=20
> So there's no way +5V is in3, sorry. +5V and +12V can only be amongst
> in1, in4, in5 and in6. From there it's really only a matter of finding
> the right mapping and scaling factors. Please follow my guide here to
> get this right:
>=20
> http://www.lm-sensors.org/wiki/VoltageLabelsAndScaling
>=20
> Your chip's native voltage range is 2.04 V i.e. LSB =3D 8 mV.
>=20
> --=20
> Jean Delvare
> Suse L3 Support
> http://jdelvare.nerim.net/wishlist.html
>

And
 here I thought I could finalize my configuration for this board.=20
Anyhow, keeping in mind that only one of in1, in4, in5, and in6 can be=20
used for generic inputs, here's what I have done so far for +12V=20
scaling, using the guide from=20
http://www.lm-sensors.org/wiki/VoltageLabelsAndScaling.

I have removed my custom configuration at this point, so that I'm using the=
 default configuration:

### unscaled sensors output:

# sensors -s
# sensors -u
w83627dhg-isa-0290
Adapter: ISA adapter
in1:
=A0 in1_input: 0.984
=A0 in1_min: 0.912
=A0 in1_max: 1.440
=A0 in1_alarm: 0.000
in4:
=A0 in4_input: 1.656
=A0 in4_min: 1.632
=A0 in4_max: 1.800
=A0 in4_alarm: 0.000
in5:
=A0 in5_input: 1.688
=A0 in5_min: 2.040
=A0 in5_max: 2.040
=A0 in5_alarm: 1.000
in6:
=A0 in6_input: 1.896
=A0 in6_min: 1.800
=A0 in6_max: 1.904
=A0 in6_alarm: 0.000

### computation:

+12V samples: 12.091 (screenshot from the manual), 12.460, 12.513 (these ar=
e the only two values I have observed in the bios)

12.460 - 12.091 =3D 0.369
12.513 - 12.460 =3D 0.053

From the above, it seems clear that 1 LSB of the ADC corresponds to 53=20
mV after scaling. And I know that it corresponds to 8 mV before=20
scaling. So I conclude that the scaling factor is 53/8. And I=20
validate this conclusion as:

12.460 / (53/8) =3D 1.880754717

which
 is close enough to in6 (1.896). To test this out, I created a test=20
configuration file (/etc/sensors.d/test.conf) as follows:

compute in6 @*(53/8), @/(53/8)
set in6_min 12 * 0.95
set in6_max 12 * 1.05

### scaled sensors output:

# sensors -s
# sensors -u
w83627dhg-isa-0290
Adapter: ISA adapter
Vcore:
=A0 in0_input: 1.104
=A0 in0_min: 1.072
=A0 in0_max: 1.184
=A0 in0_alarm: 0.000
in1:
=A0 in1_input: 0.992
=A0 in1_min: 0.912
=A0 in1_max: 1.440
=A0 in1_alarm: 0.000
in4:
=A0 in4_input: 1.656
=A0 in4_min: 1.632
=A0 in4_max: 1.800
=A0 in4_alarm: 0.000
in5:
=A0 in5_input: 1.688
=A0 in5_min: 2.040
=A0 in5_max: 2.040
=A0 in5_alarm: 1.000
in6:
=A0 in6_input: 1.896
=A0 in6_min: 1.800
=A0 in6_max: 1.904
=A0 in6_alarm: 0.000

Not only did in6 remained the same, but also the min and max values from my=
 test configuration did not take effect.

Please advice on how to proceed from here.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
