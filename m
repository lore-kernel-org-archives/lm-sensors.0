From: ianp <braveheart_leo@yahoo.com>
Date: Thu, 20 Feb 2014 17:59:26 +0000
Subject: Re: [lm-sensors] Need help setting up sensors on Gigabye GA-945GCM-S2L (IT8718F)
Message-Id: <1392919166.79553.YahooMailNeo@web160505.mail.bf1.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392865158.7385.YahooMailNeo@web160501.mail.bf1.yahoo.com>
In-Reply-To: <1392865158.7385.YahooMailNeo@web160501.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

> On Thursday, February 20, 2014 9:49 PM, Jean Delvare <jdelvare@suse.de> w=
rote:

>
>>  which is very close to in4 (3.120). At one time it read:
>>=20
>>  in4:
>>  =A0 in4_input: 3.140
>=20
> There's something weird here: 3.140 isn't a integer multiple of 0.016,
> so it is not possible that the IT8718F sensed that voltage value. Are
> you sure this is the exact value reported by "sensors"? Or is it a=20
> copy
> and paste error?
>=20

Sorry about that. I relied upon my memory seeing such value once from "sens=
ors" when it really was 3.104 and not 3.140.

>=20
> I have found a BIOS screenshot on the web (was hard to find):
> http://img155.imageshack.us/img155/5831/dsc00004kz6.jpg
>=20
> Sample value there is 12.175 V.
>=20
> 12.302 - 12.175 =3D 0.127
> 12.365 - 12.175 =3D 0.190
>=20

Early BIOS versions for this board didn't show the actual values for the se=
nsors it monitors but instead it just displayed an "OK." This is true for t=
he board's manual as well. I appreciate that you took your time to search t=
he web when I had thought that I would never find one.

Your search result only reiterated my previous guide suggestions that it is=
 recommended to have at least 3 voltage samples to facilitate an accurate c=
omputation, which I myself should have been keen to follow, but I was feeli=
ng lucky at that time. :-)

> The would suggests that the scaling factor isn't exactly 63/16 (3.9375)
> but closer to 190/48 (3.9583.) However 190/48 doesn't map raw values to
> BIOS values so that can't be it.
>=20
> Your original assumption was that 12.302 in the BIOS was 3.120 in
> "sensors". I think actually 12.365 in the BIOS was 3.120 in=20
> "sensors".
> If you put some load on the CPU, you may be able to collect another in4
> value from "sensors" (presumably 3.104) that would match the 12.302 in
> the BIOS.
>=20
> If I'm right then a scaling factor that would work would be somewhere
> between 12.302/3.104 and 12.365/3.120, i.e. 3.9633. Note that this
> isn't the first time this strange scaling factors shows up for Gigabyte
> boards:
> http://jdelvare.nerim.net/devel/lm-sensors/config/sensors3-Gigabyte-7N400=
-Pro2.conf
> http://jdelvare.nerim.net/devel/lm-sensors/config/sensors3-Gigabyte-890GP=
A-UD3H.conf
> http://www.lm-sensors.org/wiki/Configurations/Gigabyte/EX38-DS4
>=20
> So I would go with:
>=20
> =A0  compute=A0 in4=A0 @*3.9633, @/3.9633
>=20
> It maps the values seen in the BIOS with actual register values:
>=20
> 192 * 0.016 * 3.9633 =3D 12.175
> 194 * 0.016 * 3.9633 =3D 12.302
> 195 * 0.016 * 3.9633 =3D 12.365
>=20

You are correct about 3.104. I realize that it is not always the case that =
the formula one arrives at while following your guide maps raw values to BI=
OS values. In such special cases, one can try to find a correlation between=
 BIOS values and "sensors" values like what you did above.

>
>>  I'm now faced with the problem of determining +5V scaling, which is not=
=20
> even present in the BIOS monitoring section. Even if it were present, how=
 could=20
> I determine which unscaled sensor input to match it up if in3, in5, in6, =
and in7=20
> are all 4.080V?
>=20
> You can't. All evidence indicates that +5V is not monitored on this
> motherboard.
>=20

I'll have to let go of +5V monitoring then.

>=20
>>  Regarding temperatures, temp1 and temp2 don't look right. How can this =

> invalid reading be rectified if=A0 possible?
>=20
> The BIOS shows a single temperature, so I'm afraid temp3 is the CPU
> temperature and temp1 and temp2 aren't connected.
>=20

I was expecting fan1 corresponds to temp1, fan2 to temp2 and so on, but in =
a perfect world that would have been the rule. This board is an oddball but=
 I'm glad that I tried setting up sensors on it. This exercise has shown me=
 that motherboard vendors don't always follow convention when it comes to s=
ensors implementation.

Moreover, there's a reason why some people would say "Linux people know the=
ir hardware inside out" when one works closely with it. I can personally un=
derstand that reason the more I work my way inside Linux and with the under=
lying hardware as well.

I can now recommended to others that when using third-party monitoring soft=
ware, to take the software's monitoring data with a grain of salt, use the =
vendor-supplied monitoring suite instead, or even better, go Free/Open Sour=
ce Software. :-)

I will send in my configuration for this board as soon as I can finalize it.

Thank you for your valuable insights once again Jean.


ianp


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
