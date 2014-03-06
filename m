From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 06 Mar 2014 08:41:59 +0000
Subject: Re: [lm-sensors] Sensors configuration for Asus P5PE-VM motherboard
Message-Id: <20140306094159.0a23144e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1393524410.49402.YahooMailNeo@web160503.mail.bf1.yahoo.com>
In-Reply-To: <1393524410.49402.YahooMailNeo@web160503.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Ian,

On Thu, 27 Feb 2014 10:06:50 -0800 (PST), ianp wrote:
> I wish to share this configuration if Jean or somebody else could verify =
what I have done so far and add this to the wiki.
>=20
> Here's the default sensors output (only the unconfigured inputs are shown=
):
>=20
> $ sensors -u
> in1:
> =A0 in1_input: 1.856
> =A0 in1_min: 2.040
> =A0 in1_max: 1.712
> =A0 in1_alarm: 1.000
> in4:
> =A0 in4_input: 1.648
> =A0 in4_min: 1.520
> =A0 in4_max: 1.680
> =A0 in4_alarm: 0.000
> in5:
> =A0 in5_input: 1.632
> =A0 in5_min: 1.488
> =A0 in5_max: 1.648
> =A0 in5_alarm: 0.000
> in6:
> =A0 in6_input: 0.184
> =A0 in6_min: 1.976
> =A0 in6_max: 1.520
> =A0 in6_alarm: 1.000
> in9:
> =A0 in9_input: 0.184
> =A0 in9_min: 1.248
> =A0 in9_max: 0.872
> =A0 in9_alarm: 1.000
>=20
> For the +12V scaling:
>=20
> +12V BIOS samples: 12.196, 12.249, 12.302
>=20
> 12.249 - 12.196 =3D 0.053
> 12.302 - 12.249 =3D 0.053
>=20
> 12.249 / (1+56/10) =3D 1.855909091
>=20
> 1.855909091 is close enough to in1 (1.856)
>=20
>=20
> To verify the scaling factor:
>=20
>=20
> 231 * 0.008 * (1+56/10) =3D 12.1968
> 232 * 0.008 * (1+56/10) =3D 12.2496
> 233 * 0.008 * (1+56/10) =3D 12.3024
>=20
> and it almost matches exactly to each BIOS samples. The compute statement=
 for +12V scaling is:
>=20
> compute=A0 in1=A0 @*(1+56/10), @/(1+56/10)
>=20
>=20
>=20
> For the +5V scaling:
>=20
>=20
> +5V BIOS samples: 5.094, 5.145, 5.171, 5.196
>=20
> 5.145 - 5.094 =3D 0.051
> 5.171 - 5.145 =3D 0.026
> 5.196 - 5.171 =3D 0.025
>=20
> (5.196 - 5.094) / (2 + 1 + 1) =3D 0.0255
>=20
> 5.196 / (255/80) =3D 1.630117647
>=20
> 1.614117647 is close enough to in5 (1.632)

Not sure what 1.614117647 has to do with it.

> But when I tried to verify the scaling factor:
>=20
> 202 * 0.008 * (255/80) =3D 5.151
> 203 * 0.008 * (255/80) =3D 5.1765
> 204 * 0.008 * (255/80) =3D 5.202
>=20
> So I'm not so sure if this is acceptable. If I made a mistake from my abo=
ve calculations please let me know. The compute statement for +5V scaling i=
s:
>=20
>=20
> compute=A0 in5=A0 @*(255/80), @/(255/80)

I have a better one. 5.196/0.008/(255/80) is 203.764, which is not an
integer register value. That's why your validation above doesn't work.
5.196 V in the BIOS has to correspond to a register value of 203 or
204, it can't be in between.

5.196/(204*0.008) would mean a scaling factor 3.183823, which almost
works but assumes that the BIOS rounds values, which is generally not
the case. However 5.196/(203*0.008) leads to a scaling factor of
3.199507, which I will deliberately round to 3.2 :-) because it's nice,
has been seen before, and works quite well:

199 * 0.008 * (1+22/10) =3D 5.094
201 * 0.008 * (1+22/10) =3D 5.145
202 * 0.008 * (1+22/10) =3D 5.171
203 * 0.008 * (1+22/10) =3D 5.196

So I vote for (1+22/10) as the +5V scaling factor.

> And this is the entire configuration:
> (...)

Added to the wiki as:
http://www.lm-sensors.org/wiki/Configurations/Asus/P5PE-VM

Thanks for your contribution :-)

--=20
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
