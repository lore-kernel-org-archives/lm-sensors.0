From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 19 Feb 2014 13:10:46 +0000
Subject: Re: [lm-sensors] W83627DHG-P sensor shows a single voltage monitor for +5V and +12V on in4?
Message-Id: <20140219141046.530ba2a5@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392773023.4498.YahooMailNeo@web160503.mail.bf1.yahoo.com>
In-Reply-To: <1392773023.4498.YahooMailNeo@web160503.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, 19 Feb 2014 03:47:50 -0800 (PST), ianp wrote:
> And
>  here I thought I could finalize my configuration for this board.=20
> Anyhow, keeping in mind that only one of in1, in4, in5, and in6 can be=20
> used for generic inputs, here's what I have done so far for +12V=20
> scaling, using the guide from=20
> http://www.lm-sensors.org/wiki/VoltageLabelsAndScaling.
>=20
> I have removed my custom configuration at this point, so that I'm using t=
he default configuration:
>=20
> ### unscaled sensors output:
>=20
> # sensors -s
> # sensors -u
> w83627dhg-isa-0290
> Adapter: ISA adapter
> in1:
> =A0 in1_input: 0.984
> =A0 in1_min: 0.912
> =A0 in1_max: 1.440
> =A0 in1_alarm: 0.000
> in4:
> =A0 in4_input: 1.656
> =A0 in4_min: 1.632
> =A0 in4_max: 1.800
> =A0 in4_alarm: 0.000
> in5:
> =A0 in5_input: 1.688
> =A0 in5_min: 2.040
> =A0 in5_max: 2.040
> =A0 in5_alarm: 1.000
> in6:
> =A0 in6_input: 1.896
> =A0 in6_min: 1.800
> =A0 in6_max: 1.904
> =A0 in6_alarm: 0.000
>=20
> ### computation:
>=20
> +12V samples: 12.091 (screenshot from the manual), 12.460, 12.513 (these =
are the only two values I have observed in the bios)
>=20
> 12.460 - 12.091 =3D 0.369
> 12.513 - 12.460 =3D 0.053
>=20
> From the above, it seems clear that 1 LSB of the ADC corresponds to 53=20
> mV after scaling. And I know that it corresponds to 8 mV before=20
> scaling. So I conclude that the scaling factor is 53/8. And I=20
> validate this conclusion as:
>=20
> 12.460 / (53/8) =3D 1.880754717
>=20
> which
>  is close enough to in6 (1.896). To test this out, I created a test=20
> configuration file (/etc/sensors.d/test.conf) as follows:
>=20
> compute in6 @*(53/8), @/(53/8)

It turns out that a very frequent pair of scaling resistors is 10 Ohm
and 56 Ohm, which leads to:

compute in6 @*(1+56/10), @/(1+56/10)

This maps your raw reading (1.896) to exactly 12.513 which is one of
the values you saw in the BIOS, and also maps integer register values
to 12.091 and 12.460.

> set in6_min 12 * 0.95
> set in6_max 12 * 1.05
>=20
> ### scaled sensors output:
>=20
> # sensors -s
> # sensors -u
> w83627dhg-isa-0290
> Adapter: ISA adapter
> Vcore:
> =A0 in0_input: 1.104
> =A0 in0_min: 1.072
> =A0 in0_max: 1.184
> =A0 in0_alarm: 0.000
> in1:
> =A0 in1_input: 0.992
> =A0 in1_min: 0.912
> =A0 in1_max: 1.440
> =A0 in1_alarm: 0.000
> in4:
> =A0 in4_input: 1.656
> =A0 in4_min: 1.632
> =A0 in4_max: 1.800
> =A0 in4_alarm: 0.000
> in5:
> =A0 in5_input: 1.688
> =A0 in5_min: 2.040
> =A0 in5_max: 2.040
> =A0 in5_alarm: 1.000
> in6:
> =A0 in6_input: 1.896
> =A0 in6_min: 1.800
> =A0 in6_max: 1.904
> =A0 in6_alarm: 0.000
>=20
> Not only did in6 remained the same, but also the min and max values from =
my test configuration did not take effect.
>=20
> Please advice on how to proceed from here.

You must have changed the wrong file, or the wrong section in the right
file. It should work.

--=20
Jean Delvare
Suse L3 Support
http://jdelvare.nerim.net/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
