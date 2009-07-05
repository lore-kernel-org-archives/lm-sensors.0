From: =?ISO-8859-15?Q?H=E1morszky_Bal=E1zs?= <balihb@gmail.com>
Date: Sun, 05 Jul 2009 12:01:23 +0000
Subject: Re: [lm-sensors] MINSTART has no effect in fancontrol
Message-Id: <4A509613.60206@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A4FFD5F.6060508@gmail.com>
In-Reply-To: <4A4FFD5F.6060508@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Bal=E1zs,
>=20
> On Sun, 05 Jul 2009 03:09:51 +0200, H=E1morszky Bal=E1zs wrote:
>> In fancontrol MINSTART has no effect (it has, but only for an INTERVAL=20
>> period of time).
>> The line:
>> pwmval=3D"(${tval}-${mint})*(${maxpwm}-${minso})/(${maxt}-${mint})+${min=
so}"
>> should be:
>> pwmval=3D"(${tval}-${mint})*(${maxpwm}-${minsa})/(${maxt}-${mint})+${min=
sa}"
>> if I understand the configuration options of fancontrol right.
>=20
> I guess you don't. The formula above is perfectly correct. With your
> proposed change, MINSTART would be used instead of MINSTOP for the
> speed computations, which is definitely not what we want.
>=20
>> At the current state, pwmval can be lower than MINSTART
>=20
> Of course it can, by design. But it can't be lower than MINPWM. I
> suggest you read the fancontrol documentation:
>   http://www.lm-sensors.org/browser/lm-sensors/trunk/doc/fancontrol.txt
> and in particular the graph. You'll see that MINSTART is _not_ used to
> compute the fan speed. MINSTART is only used for the initial pulse to
> get a fan spinning.
>=20
>> (so on some temperatures, greater than MINTEMP, the fan won't start).
>=20
> It should, if your settings are correct. Maybe you have set either
> MINSTART or MINSTOP too low for your fan.

You're right. My MINSTOP was 0. I've misunderstood the function of it.

> That being said, it could be that the MINSTART pulse of 1 second is a
> tad too short for some fans. If this is your case then you could
> increase the sleep value from 1 to 2 or 3 and see if it helps.
>=20

Thanks for the quick help!

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
