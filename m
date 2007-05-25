From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 25 May 2007 20:10:20 +0000
Subject: Re: [lm-sensors] dynamic chip support in libsensors + generic chip
Message-Id: <465742AC.7080004@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <461A59D4.2050409@hhs.nl>
In-Reply-To: <461A59D4.2050409@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Fri, 25 May 2007 15:47:50 +0200, Jean Delvare wrote:
>> Here is the patch I have come up with, which fixes both problems and
>> makes the generic code work for my ADM1032. Can you please review it and
>> confirm that it doesn't break anything on your side? Thanks.
>=20
> I spoke a bit too fast. There was actually a third problem, alarms
> weren't reported. This is because the ADM1032 has per-limit alarm flags
> and the generic code only supported per-channel alarms for temperatures.
>=20
> So here is a more complete patch which fixes all three problems.
>=20

First of all many thanks for looking add this and trying it, that is just w=
hat=20
this code needs, much testing. Or some testing on many different kinds of=20
hardware to be even more clear.

I've reviewed your patch here are some notes:


> Index: prog/sensors/chips_generic.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- prog/sensors/chips_generic.c	(r=E9vision 4=
405)
> +++ prog/sensors/chips_generic.c	(copie de travail)

you add a SENSORS_FEATURE_TEMP_MIN_HYST sensor type, but do not check / do =

anything with it in print_generic_chip_temp()

> @@ -208,24 +197,27 @@
>    if (TEMP_FEATURE(SENSORS_FEATURE_TEMP_FAULT) &&
>        TEMP_FEATURE_VAL(SENSORS_FEATURE_TEMP_FAULT) > 0.5) {
>      printf(" FAULT");
> -  } else if (TEMP_FEATURE(SENSORS_FEATURE_TEMP_ALARM) &&=20
> -      TEMP_FEATURE_VAL(SENSORS_FEATURE_TEMP_ALARM) > 0.5) {
> +  } else
> +  if ((TEMP_FEATURE(SENSORS_FEATURE_TEMP_ALARM) &&=20
> +       TEMP_FEATURE_VAL(SENSORS_FEATURE_TEMP_ALARM) > 0.5)
> +   || (type =3D MINMAX &&
> +       TEMP_FEATURE(SENSORS_FEATURE_TEMP_MIN_ALARM) &&=20
> +       TEMP_FEATURE_VAL(SENSORS_FEATURE_TEMP_MIN_ALARM) > 0.5)
> +   || (type =3D MINMAX &&
> +       TEMP_FEATURE(SENSORS_FEATURE_TEMP_MAX_ALARM) &&=20
> +       TEMP_FEATURE_VAL(SENSORS_FEATURE_TEMP_MAX_ALARM) > 0.5)) {
>      printf(" ALARM");
>    }
>    printf("\n");
>   =20

-Is the type =3D MINMAX check for printing the alarms necessary, doesn't th=
is=20
has the risk of not showing an alarm for some chip with a funky combination=
 of=20
temp sysfs entries?

-Shouldn't the code somehow show the difference between a min and a max (an=
d a=20
generic) alarm? See how print_generic_chip_in() does this

---

I also tested lm_sensors 3.0.0 with your patch and it still works fine on m=
y=20
abit uguru motherboard

Some generic notes not directly related to your patch:

This piece of code in print_generic_chip_temp() can be done much simpler:

   if (type =3D LIM) {
   } else {
     print_temp_info_real(val, max, min, 0.0, type, 1, 1);
   }

Since lim always is 0.0 (this initalized to this) in the non LIM case, this=
 can=20
be written as just:
   print_temp_info_real(val, max, min, lim, type, 1, 1);

Will you change this or shall I?

More in general print_generic_chip_temp(), needs a good review by someone w=
ho=20
is well aware of all possible tempX sysfs entry combo's (iow not by me).


Also print_generic_chip_in(), has some dangerous and unneeded assumptions, =
for=20
example:
-it assumes that if there is a inX_max that there will also always be a inX=
_min
-it assumes that if there is no inX_max there will also be no alarms

Shall I fix these or will you?

Somewhat less "unneeded" assumption
-it doesn't check for inX_max_alarm without an inX_min_alarm and visa versa=
, I
  admit this would be a driver bug, as then the driver should have just a
  inX_alarm, but still we might want to concider this.


Well thats about it. About all the "Shall I fix these or will you?", that i=
s=20
not me being lazing, but rather me trying to avoid commit conflicts. Its fi=
ne=20
if you want me to take care of them, but then I guess I should wait until y=
our=20
patch is in svn.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
