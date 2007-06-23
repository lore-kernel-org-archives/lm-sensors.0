From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 23 Jun 2007 12:29:36 +0000
Subject: Re: [lm-sensors] Help needed for implementing&testing Fintek F75375
Message-Id: <20070623142936.580e8ce8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <5327.79319.qm@web25109.mail.ukl.yahoo.com>
In-Reply-To: <5327.79319.qm@web25109.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Christian,

On Mon, 18 Jun 2007 18:58:24 +0200 (CEST), Christian Emmerich wrote:
> I've attached a patch for Fintek F75373S support,=20
> kernel module f75375s is required.
>=20
> At the moment it is possible to read out 4 different voltage=20
> values, 2 temperatures and 2 fans/pwm (i've only one fan=20
> connected, so i could only verify that one of two is working
> correct).

OK, my review is below.

> I was not able to adjust fan speed using fancontrol,=20
> i have to do it by hand.

Did pwmconfig work?

> sensors output looks like:
> mythtv@pc:~$ sensors F75373-*
> F75373-i2c-1-2d
> Adapter: SMBus nForce2 adapter at 5100
> VCC:       +1.72 V  (min =3D  +0.00 V, max =3D  +0.00 V) =20
> V1:        +1.34 V  (min =3D  +0.00 V, max =3D  +0.00 V) =20
> V2:        +1.01 V  (min =3D  +0.00 V, max =3D  +0.00 V) =20
> V3:        +0.77 V  (min =3D  +0.00 V, max =3D  +0.00 V) =20
> CPU Temp:    +50=B0C  (high =3D    +0=B0C, hyst =3D    +0=B0C) =20
> Sys Temp:    +47=B0C  (high =3D    +0=B0C, hyst =3D    +0=B0C) =20
> CPU Fan:  1866 RPM  (min =3D    0 RPM)
> CPU PWM:    31      (enable =3D 1)

Did you try setting limits?

> diff -urN lm-sensors_org/etc/sensors.conf.eg lm-sensors/etc/sensors.conf.=
eg
> --- lm-sensors_org/etc/sensors.conf.eg	2007-06-17 15:34:35.000000000 +0200
> +++ lm-sensors/etc/sensors.conf.eg	2007-06-17 16:54:34.000000000 +0200
> @@ -2880,3 +2880,36 @@
>  #   set fan4_min 1000
>  #   set fan5_min 1000
>  #   set fan6_min 1000
> +
> +
> +#
> +# Sample configuration for the Fintek F75373
> +#
> +chip "f75373-*"
> +
> +# Voltages
> +   label in0_input "VCC"
> +   label in1_input "V1"
> +   label in2_input "V2"
> +   label in3_input "V3"
> +
> +   compute in0_input  @/1000,@/1000
> +   compute in1_input  @/1000,@/1000
> +   compute in2_input  @/1000,@/1000
> +   compute in3_input  @/1000,@/1000

That's not correct, you should have "in0", "in1"... etc. here, not
"in0_input", "in1_input" etc? The fan and temperature symbols below are
correct.

Also, these compute lines don't make sense. The second formula is
supposed to be the reserve of the first formula, that's not the case
here.

Lastly, you really shouldn't have to divide the values by 1000. This
suggests that the magnitude wasn't set properly in libsensors (it
should be 3, I suggest it is 0). This issue is most probably related to
the incorrect symbol names.

> +
> +# Fans
> +   label fan1 "CPU Fan"
> +   label fan2 "Sys Fan"
> +
> +   compute fan1  ( 1.5 * 1000000 )/@,  ( 1.5 * 1000000 )/@
> +   compute fan2  ( 1.5 * 1000000 )/@,  ( 1.5 * 1000000 )/@

This means that the driver isn't reporting the values in RPM as it
should. Usually no compute statement is needed for fans.

> +
> +# Temperatures
> +   label temp1 "CPU Temp"
> +   label temp2 "Sys Temp"
> +  =20
> +# PWM
> +   label pwm1   "CPU PWM"
> +   label pwm2   "Sys PWM"
> +
> diff -urN lm-sensors_org/lib/chips.c lm-sensors/lib/chips.c
> --- lm-sensors_org/lib/chips.c	2007-06-17 15:34:32.000000000 +0200
> +++ lm-sensors/lib/chips.c	2007-06-17 15:57:49.000000000 +0200
> @@ -6108,6 +6108,64 @@
>      { { 0 }, 0 }
>    };
> =20
> +
> +
> +#define SENSORS_F75373_IN_FEATURES(nr) \
> +        { { SENSORS_F75373_IN(nr), "in" #nr "_input", \
> +                NOMAP, NOMAP, R }, \
> +                NOSYSCTL, VALUE(3), 3 }, \

OK, the problem is here: This should be"in" #nr, not "in" #nr
"_input". This will fix your magnitude problem.

> +        { { SENSORS_F75373_IN_MIN(nr), "in" #nr "_min", \
> +                SENSORS_F75373_IN(nr), SENSORS_F75373_IN(nr), RW }, \
> +                NOSYSCTL, VALUE(2), 3 }, \

VALUE(1) (although it won't make a difference for a Linux 2.6 only
driver.

> +        { { SENSORS_F75373_IN_MAX(nr), "in" #nr "_max", \
> +                SENSORS_F75373_IN(nr), SENSORS_F75373_IN(nr), RW }, \
> +                NOSYSCTL, VALUE(2), 3 }
> +
> +#define SENSORS_F75373_TEMP_FEATURES(nr) \
> +        { { SENSORS_F75373_TEMP(nr), "temp" #nr "", \
> +                NOMAP, NOMAP, R }, \
> +                NOSYSCTL, VALUE(3), 3 }, \
> +        { { SENSORS_F75373_TEMP_MAX(nr), "temp" #nr "_max", \
> +                SENSORS_F75373_TEMP(nr), SENSORS_F75373_TEMP(nr), RW }, \
> +                NOSYSCTL, VALUE(1), 3 }, \
> +        { { SENSORS_F75373_TEMP_HYST(nr), "temp" #nr "_hyst", \
> +                SENSORS_F75373_TEMP(nr), NOMAP, R }, \
> +                NOSYSCTL, VALUE(1), 0 }

SENSORS_F75373_TEMP(nr) instead of NOMAP, VALUE(2) instead of VALUE(1),
and magnitude 3 instead of 0. Is it really read-only?

(Unless this isn't an hysteresis temperature at all - see below.)

> +
> +#define SENSORS_F75373_FAN_FEATURES(nr) \
> +        { { SENSORS_F75373_FAN(nr), "fan" #nr, \
> +                NOMAP, NOMAP, R }, \
> +                NOSYSCTL, VALUE(2), 0 }, \
> +        { { SENSORS_F75373_FAN_MAX(nr), "fan" #nr "_max", \
> +                SENSORS_F75373_FAN(nr), SENSORS_F75373_FAN(nr), RW }, \
> +                NOSYSCTL, VALUE(1), 0 }, \

Strange, I've never seen a fan speed sensor with a high limit. What
does it correspond to exactly? Why don't you display this value in
"sensors"?

> +        { { SENSORS_F75373_FAN_MIN(nr), "fan" #nr "_min", \
> +                SENSORS_F75373_FAN(nr), NOMAP, R }, \
> +                NOSYSCTL, VALUE(1), 0 }

SENSORS_F75373_FAN(nr) instead of NOMAP.

Is it really read-only?

> +
> +#define SENSORS_F75373_PWM_FEATURES(nr) \
> +        { { SENSORS_F75373_PWM(nr), "pwm" #nr, \
> +                NOMAP, NOMAP, RW }, \
> +                NOSYSCTL, VALUE(1), 0 }, \
> +        { { SENSORS_F75373_PWM_ENABLE(nr), "pwm" #nr "_enable", \
> +                SENSORS_F75373_PWM(nr), SENSORS_F75373_PWM(nr), RW }, \
> +                NOSYSCTL, VALUE(3), 0 }

In fact we don't include PWM stuff in libsensors. They are not sensors,
and are better handled using pwmconfig and fancontrol.

> +
> +static sensors_chip_feature f75373_features[] > +{
> +        SENSORS_F75373_IN_FEATURES(0),
> +        SENSORS_F75373_IN_FEATURES(1),
> +        SENSORS_F75373_IN_FEATURES(2),
> +        SENSORS_F75373_IN_FEATURES(3),
> +        SENSORS_F75373_TEMP_FEATURES(1),
> +        SENSORS_F75373_TEMP_FEATURES(2),
> +        SENSORS_F75373_FAN_FEATURES(1),
> +        SENSORS_F75373_FAN_FEATURES(2),
> +        SENSORS_F75373_PWM_FEATURES(1),
> +        SENSORS_F75373_PWM_FEATURES(2),
> +        { { 0 }, 0 }
> +};
> +
>  sensors_chip_features sensors_chip_features_list[] >  {
>   { SENSORS_LM78_PREFIX, lm78_features },
> @@ -6223,5 +6281,6 @@
>   { SENSORS_CORETEMP_PREFIX, coretemp_features },
>   { SENSORS_DME1737_PREFIX, dme1737_features },
>   { SENSORS_APPLESMC_PREFIX, applesmc_features },
> + { SENSORS_F75373_PREFIX, f75373_features },
>   { 0 }
>  };
> diff -urN lm-sensors_org/lib/chips.h lm-sensors/lib/chips.h
> --- lm-sensors_org/lib/chips.h	2007-06-17 15:34:32.000000000 +0200
> +++ lm-sensors/lib/chips.h	2007-06-17 16:53:25.000000000 +0200
> @@ -2312,4 +2312,28 @@
>  #define SENSORS_APPLESMC_FAN_MAX(n)		(0x61 + (n)) /* R */
>  #define SENSORS_APPLESMC_FAN_SAFE(n)		(0x81 + (n)) /* R */
> =20
> +/* Fintek F75373 registers  */
> +
> +#define SENSORS_F75373_PREFIX "f75373"
> +
> +// voltage n from 0 to 3

No C++-style comments please. Use /* */.

> +#define SENSORS_F75373_IN(nr)           (0x10 + (nr))
> +#define SENSORS_F75373_IN_MAX(nr)       (0x20 + (nr) * 2 )
> +#define SENSORS_F75373_IN_MIN(nr)       (0x21 + (nr) * 2 )

Coding style: no space before closing parenthesis.

> +
> +// temp n from 0 to 1
> +#define SENSORS_F75373_TEMP(nr)         (0x14 + (nr))
> +#define SENSORS_F75373_TEMP_MAX(nr)     (0x28 + (nr) * 2 )
> +#define SENSORS_F75373_TEMP_HYST(nr)    (0x29 + (nr) * 2 )
> +
> +// fan n from 0 to 1
> +#define SENSORS_F75373_FAN(nr)          (0x16 + (nr) * 2 )
> +#define SENSORS_F75373_FAN_MIN(nr)      (0x26 + (nr) * 2 )
> +// FAN Full Speed Count Register Index 70h
> +#define SENSORS_F75373_FAN_MAX(nr)      (0x70 + (nr) * 0x10 )
> +
> +// pwm n from 0 to 1
> +#define SENSORS_F75373_PWM(nr)          (0x76 + (nr) * 0x10 )
> +#define SENSORS_F75373_PWM_ENABLE(nr)   (0x7D + (nr) * 0x10 )
> +

I hope that you realize that these numbers do NOT have to match the
register numbers in the chip? These numbers are completely arbitrary.
So please make them as simple as possible.

>  #endif /* def LIB_SENSORS_CHIPS_H */
> diff -urN lm-sensors_org/prog/sensors/chips.c lm-sensors/prog/sensors/chi=
ps.c
> --- lm-sensors_org/prog/sensors/chips.c	2007-06-17 15:34:33.000000000 +02=
00
> +++ lm-sensors/prog/sensors/chips.c	2007-06-17 16:29:50.000000000 +0200
> @@ -6131,6 +6131,114 @@
>  	}
>  }
> =20
> +static void print_f75373_in(const sensors_chip_name *name, int i)
> +{
> +  char *label;
> +  double cur, min, max;
> +  int valid;
> +
> +  if (!sensors_get_label_and_valid(*name, SENSORS_F75373_IN(i), &label,
> +                                  &valid) &&
> +      !sensors_get_feature(*name, SENSORS_F75373_IN(i), &cur) &&
> +      !sensors_get_feature(*name, SENSORS_F75373_IN_MAX(i), &max) &&
> +      !sensors_get_feature(*name, SENSORS_F75373_IN_MIN(i), &min)) {
> +    if (valid) {
> +      print_label(label, 10);
> +      printf("%+6.2f V  (min =3D %+6.2f V, max =3D %+6.2f V)  \n",
> +             cur, min, max);

If you don't have any alarm flag to display, you can remove the spaces
before the newline.

> +    }
> +  } else {
> +    printf("ERROR: Can't get in%d data!\n", i);
> +  }
> +  free(label);
> +}
> +
> +static void print_f75373_temp(const sensors_chip_name *name, int i)
> +{
> +  char *label;
> +  double cur, max, alarm;
> +  int valid;
> +
> +  if (!sensors_get_label_and_valid(*name, SENSORS_F75373_TEMP(i), &label,
> +                                   &valid) &&
> +      !sensors_get_feature(*name, SENSORS_F75373_TEMP(i), &cur) &&
> +      !sensors_get_feature(*name, SENSORS_F75373_TEMP_MAX(i), &max) &&
> +      !sensors_get_feature(*name, SENSORS_F75373_TEMP_HYST(i), &alarm)
> +      ) {

Coding style: move this at the end of the previous line.

> +    if (valid) {
> +      print_label(label, 10);
> +      print_temp_info(cur, max, 0, HYST , 0, 0);
> +      printf("%s\n", alarm ? "ALARM" : "");
> +    }

This doesn't make sense. What is SENSORS_F75373_TEMP_HYST exactly? Why
do you display it as an alarm?


> +  } else {
> +    printf("ERROR: Can't get temp%d data!\n", i);
> +  }
> +  free(label);
> +}
> +
> +static void print_f75373_fan(const sensors_chip_name *name, int i)
> +{
> +  char *label;
> +  double cur, min;
> +  int valid;
> +
> +  if (!sensors_get_label_and_valid(*name, SENSORS_F75373_FAN(i), &label,
> +                                   &valid) &&
> +      !sensors_get_feature(*name, SENSORS_F75373_FAN(i), &cur) &&
> +      !sensors_get_feature(*name, SENSORS_F75373_FAN_MIN(i), &min)
> +     ){

Coding style: move this at the end of the previous line.

> +    if (valid) {
> +      print_label(label, 10);
> +      printf("%4.0f RPM  (min =3D %4.0f RPM)\n",=20
> +             cur, min);
> +    }
> +  } else {
> +    printf("ERROR: Can't get fan%d data!\n", i);
> +  }
> +  free(label);
> +}
> +
> +static void print_f75373_pwm(const sensors_chip_name *name, int i)
> +{
> +  char *label;
> +  double cur, enable;
> +  int valid;
> +
> +  if (!sensors_get_label_and_valid(*name, SENSORS_F75373_PWM(i), &label,
> +                                   &valid) &&
> +      !sensors_get_feature(*name, SENSORS_F75373_PWM(i), &cur) &&
> +      !sensors_get_feature(*name, SENSORS_F75373_PWM_ENABLE(i), &enable)=
) {
> +    if (valid) {
> +      print_label(label, 10);
> +      printf("%4.0f      (enable =3D %1.0f)\n", cur, enable);
> +    }
> +  } else {
> +    printf("ERROR: Can't get pwm%d data!\n", i);
> +  }
> +  free(label);
> +}
> +
> +void print_f75373(const sensors_chip_name *name)
> +{
> +  int i;
> +
> +  for (i =3D 0; i < 4; i++) {
> +    print_f75373_in(name, i);
> +  }
> +
> +  for (i =3D 1; i < 3; i++) {

I'd suggest writing it i <=3D 2, to make it more visible that there are 2
temperature inputs, not 3. Same below for fans.

> +    print_f75373_temp(name, i);
> +  }
> +
> +  for (i =3D 1; i < 3; i++) {
> +    print_f75373_fan(name, i);
> +  }
> +
> +  for (i =3D 1; i < 3; i++) {
> +    print_f75373_pwm(name, i);
> +  }
> +}
> +
>  void print_unknown_chip(const sensors_chip_name *name)
>  {
>    int a,b,valid;
> diff -urN lm-sensors_org/prog/sensors/chips.h lm-sensors/prog/sensors/chi=
ps.h
> --- lm-sensors_org/prog/sensors/chips.h	2007-06-17 15:34:33.000000000 +02=
00
> +++ lm-sensors/prog/sensors/chips.h	2007-06-16 20:59:34.000000000 +0200
> @@ -78,5 +78,6 @@
>  extern void print_coretemp(const sensors_chip_name *name);
>  extern void print_dme1737(const sensors_chip_name *name);
>  extern void print_applesmc(const sensors_chip_name *name);
> +extern void print_f75373(const sensors_chip_name *name);
> =20
>  #endif /* def PROG_SENSORS_CHIPS_H */
> diff -urN lm-sensors_org/prog/sensors/main.c lm-sensors/prog/sensors/main=
.c
> --- lm-sensors_org/prog/sensors/main.c	2007-06-17 15:34:33.000000000 +0200
> +++ lm-sensors/prog/sensors/main.c	2007-06-17 08:12:48.000000000 +0200
> @@ -424,6 +424,7 @@
>   	{ "coretemp", print_coretemp },
>   	{ "dme1737", print_dme1737 },
>  	{ "applesmc", print_applesmc },
> +	{ "F75373", print_f75373 },

Should be "f75373", no capital. I'm even surprised it worked with the
capital.

>  	{ NULL, NULL }
>  };
> =20

Please update your patch and resend it.

Also, what about the F75375 support? As far as I know the f75375s driver
supports both chips, so it'd be nice to have user-space support for
both. Also, it might be less confusing to use F75375 for all the
libsensors defines, rather than F75373, so that they match the driver
name.

Thanks,
--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
