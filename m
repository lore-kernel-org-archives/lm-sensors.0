From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 25 Sep 2013 15:23:03 +0000
Subject: Re: [lm-sensors] Problems with SYSTIN in nct6776-isa-0290
Message-Id: <20130925152303.GA27541@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CALmZR2Nd_S3tT9LM7bqwZi0PQgL4pSYPpHX3fCskXuWD587jGQ@mail.gmail.com>
In-Reply-To: <CALmZR2Nd_S3tT9LM7bqwZi0PQgL4pSYPpHX3fCskXuWD587jGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, Sep 25, 2013 at 04:59:04PM +0200, Kent Larsson wrote:
> I use sensors version 3.3.2 with libsensors version 3.3.2. I have some
> sensors controlled by nct6776-isa-0290 which produce ALARM even though th=
ey
> should not. For the most part I can get it to work by setting _min and _m=
ax
> or ignoring the sensor. But I have one sensor I have been unable to "fix".
>=20
>     sensors
>     ...
>     nct6776-isa-0290
>     ...
>     SYSTIN:         +31.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  =
ALARM
> sensor =3D thermistor
>     ...
>=20
> I have this /etc/sensors.d/custom
>     chip "nct6776-isa-0290"
>             ignore fan3
>             ignore fan4
>             ignore fan5
>             ignore intrusion0
>             ignore intrusion1
>             ignore in5
>             ignore SYSTIN
>             label fan1 "Chassis Fan 1"
>             label fan2 "CPU Fan"
>             set fan1_min 500
>             set fan2_min 300
>             set in1_min 0.612
>             set in1_max 1.428
>             set in4_min 0.606
>             set in4_max 1.414
>=20
> I have tried
>=20
>             set SYSTIN_high 80.0
>             set SYSTIN_hyst 75.0
>=20
> But then sudo sensors -s gives me
>=20
>     Error: File /etc/sensors.d/custom, line 17: Unknown feature name
>     Error: File /etc/sensors.d/custom, line 18: Unknown feature name
>     nct6776-isa-0290: No such subfeature known
>=20
> When that didn't work I tried
>=20
>             ignore SYSTIN
>=20
> In that case sudo sensors -s does not complain, but the SYSTIN line still
> shows up.
>=20
> Am I doing something wrong?
>=20
Hi Kent,

you need to use raw attribute names in the configuration file, not symbolic
names.

Use sensors -u to get the raw attribute names. That will most likely be tem=
p1
for SYSTIN. Whatever it is, replace SYSTIN in the config file with it.

Hope this helps,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
