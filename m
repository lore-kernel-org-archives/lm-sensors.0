From: ianp <braveheart_leo@yahoo.com>
Date: Fri, 07 Mar 2014 14:10:16 +0000
Subject: Re: [lm-sensors] Sensors configuration for Asus P5PE-VM motherboard
Message-Id: <1394201416.77539.YahooMailNeo@web160506.mail.bf1.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1393524410.49402.YahooMailNeo@web160503.mail.bf1.yahoo.com>
In-Reply-To: <1393524410.49402.YahooMailNeo@web160503.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,



> On Thursday, March 6, 2014 4:41 PM, Jean Delvare <jdelvare@suse.de> wrote:
>>=20
>>  5.196 / (255/80) =3D 1.630117647
>>=20
>>  1.614117647 is close enough to in5 (1.632)
>=20
> Not sure what 1.614117647 has to do with it.
>=20

That's a copy-paste error. :)

>>  But when I tried to verify the scaling factor:
>>=20
>>  202 * 0.008 * (255/80) =3D 5.151
>>  203 * 0.008 * (255/80) =3D 5.1765
>>  204 * 0.008 * (255/80) =3D 5.202
>>=20
>>  So I'm not so sure if this is acceptable. If I made a mistake from my=20
> above calculations please let me know. The compute statement for +5V scal=
ing is:
>>=20
>>=20
>>  compute=A0 in5=A0 @*(255/80), @/(255/80)
>=20
> I have a better one. 5.196/0.008/(255/80) is 203.764, which is not an
> integer register value. That's why your validation above doesn't work.
> 5.196 V in the BIOS has to correspond to a register value of 203 or
> 204, it can't be in between.
>=20
> 5.196/(204*0.008) would mean a scaling factor 3.183823, which almost
> works but assumes that the BIOS rounds values, which is generally not
> the case. However 5.196/(203*0.008) leads to a scaling factor of
> 3.199507, which I will deliberately round to 3.2 :-) because it's nice,
> has been seen before, and works quite well:
>=20
> 199 * 0.008 * (1+22/10) =3D 5.094
> 201 * 0.008 * (1+22/10) =3D 5.145
> 202 * 0.008 * (1+22/10) =3D 5.171
> 203 * 0.008 * (1+22/10) =3D 5.196
>=20
> So I vote for (1+22/10) as the +5V scaling factor.
>=20

Ha! This scaling computation has been a tricky one, and it really helps whe=
n one is accustomed to what I can only imagine are multitudes of possible s=
caling factors. ;)

Which brings me to this idea for the voltage scaling guide: would it be pos=
sible to list some common scaling factors for +5V and +12V as a look-up tab=
le, if the list isn't going to be long? I bet it would help others who will=
 be faced with the same conundrum as I did when deciding which scaling fact=
or should be used, if the computation didn't yield a desirable value that c=
orresponds to the BIOS samples taken when verified.

>=20
>>  And this is the entire configuration:
>>  (...)
>=20
> Added to the wiki as:
> http://www.lm-sensors.org/wiki/Configurations/Asus/P5PE-VM
>=20
> Thanks for your contribution :-)
>=20
> --=20
> Jean Delvare
> SUSE L3 Support
>

Thank you as well for new inputs.

ianp


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
