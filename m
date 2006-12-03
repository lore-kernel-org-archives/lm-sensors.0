From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 03 Dec 2006 12:21:20 +0000
Subject: [lm-sensors] [PATCH] driver for SMSC SCH311x
Message-Id: <20061203132120.f76867f3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200607241255.42688.Marcin.Dawidowicz@kontron.pl>
In-Reply-To: <200607241255.42688.Marcin.Dawidowicz@kontron.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Marcin,

On Fri, 24 Nov 2006 19:19:05 +0100, Marcin Dawidowicz wrote:
> Here is my patch for SVN lm-sensors repository to add SMSC SCH311x support for 
> user space from some time ago. I think, there won't be a big problem to apply 
> it to current repository state.

Maybe we can merge the user-space support already, even if I don't have
the time to review the driver itself. In particular the detection would
be nice to have. Here's my review:

> diff -uprN -X dontdiff_my ./lm-sensors_SVN/lib/chips.c ./lm-sensors_SVN_modif/lib/chips.c
> --- ./lm-sensors_SVN/lib/chips.c	2006-07-17 12:31:42.000000000 +0200
> +++ ./lm-sensors_SVN_modif/lib/chips.c	2006-07-21 17:19:45.000000000 +0200
> @@ -5840,6 +5840,127 @@ static sensors_chip_feature abituguru_fe
>  	{ 0 }
>  };
>  
> +static sensors_chip_feature sch311x_features[] > +  {
> +    { SENSORS_SCH311X_IN(0), "2.5V", NOMAP, NOMAP,
> +                        R, NOSYSCTL, VALUE(4), 2, "in0_input", 3 },

Please use standard feature names ("in0", "in1", "in0_max", etc.) It
is way less confusing if the standard wiring isn't used on a given
motherboard (which happens all the time.) Another benefit is that you
won't have to explicitly list the Linux 2.6 file names and magnitudes,
libsensors will guess them for you.

> +    { SENSORS_SCH311X_IN(1), "Vccp", NOMAP, NOMAP,
> +                        R, NOSYSCTL, VALUE(4), 2, "in1_input", 3 },
> +    { SENSORS_SCH311X_IN(2), "VCC", NOMAP, NOMAP,
> +                        R, NOSYSCTL, VALUE(4), 2, "in2_input", 3 },
> +    { SENSORS_SCH311X_IN(3), "5V", NOMAP, NOMAP,
> +                        R, NOSYSCTL, VALUE(4), 2, "in3_input", 3 },
> +    { SENSORS_SCH311X_IN(4), "12V", NOMAP, NOMAP,
> +                        R, NOSYSCTL, VALUE(4), 2, "in4_input", 3 },
> +    { SENSORS_SCH311X_IN(5), "VRT", NOMAP, NOMAP,
> +                        R, NOSYSCTL, VALUE(4), 2, "in5_input", 3 },
> +    { SENSORS_SCH311X_IN(6), "Vbat", NOMAP, NOMAP,
> +                        R, NOSYSCTL, VALUE(4), 2, "in6_input", 3 },
> +    { SENSORS_SCH311X_IN_MIN(0), "2.5V_min", SENSORS_SCH311X_IN(0),
> +                        SENSORS_SCH311X_IN(0), RW,
> +                        NOSYSCTL, VALUE(1), 2, "in0_min", 3 },
> +    { SENSORS_SCH311X_IN_MIN(1), "Vccp_min", SENSORS_SCH311X_IN(1),
> +                        SENSORS_SCH311X_IN(1), RW,
> +                        NOSYSCTL, VALUE(1), 2, "in1_min", 3 },
> +    { SENSORS_SCH311X_IN_MIN(2), "VCC_min", SENSORS_SCH311X_IN(2),
> +                        SENSORS_SCH311X_IN(2), RW,
> +                        NOSYSCTL, VALUE(1), 2, "in2_min", 3 },
> +    { SENSORS_SCH311X_IN_MIN(3), "5V_min", SENSORS_SCH311X_IN(3),
> +                        SENSORS_SCH311X_IN(3), RW,
> +                        NOSYSCTL, VALUE(1), 2, "in3_min", 3 },
> +    { SENSORS_SCH311X_IN_MIN(4), "12V_min", SENSORS_SCH311X_IN(4),
> +                        SENSORS_SCH311X_IN(4), RW,
> +                        NOSYSCTL, VALUE(1), 2, "in4_min", 3 },
> +    { SENSORS_SCH311X_IN_MIN(5), "VRT_min", SENSORS_SCH311X_IN(5),
> +                        SENSORS_SCH311X_IN(5), RW,
> +                        NOSYSCTL, VALUE(1), 2, "in5_min", 3 },
> +    { SENSORS_SCH311X_IN_MIN(6), "Vbat_min", SENSORS_SCH311X_IN(6),
> +                        SENSORS_SCH311X_IN(6), RW,
> +                        NOSYSCTL, VALUE(1), 2, "in6_min", 3 },
> +    { SENSORS_SCH311X_IN_MAX(0), "2.5V_max", SENSORS_SCH311X_IN(0),
> +                        SENSORS_SCH311X_IN(0), RW,
> +                        NOSYSCTL, VALUE(2), 2, "in0_max", 3 },
> +    { SENSORS_SCH311X_IN_MAX(1), "Vccp_max", SENSORS_SCH311X_IN(1),
> +                        SENSORS_SCH311X_IN(1), RW,
> +                        NOSYSCTL, VALUE(2), 2, "in1_max", 3 },
> +    { SENSORS_SCH311X_IN_MAX(2), "VCC_max", SENSORS_SCH311X_IN(2),
> +                        SENSORS_SCH311X_IN(2), RW,
> +                        NOSYSCTL, VALUE(2), 2, "in2_max", 3 },
> +    { SENSORS_SCH311X_IN_MAX(3), "5V_max", SENSORS_SCH311X_IN(3),
> +                        SENSORS_SCH311X_IN(3), RW,
> +                        NOSYSCTL, VALUE(2), 2, "in3_max", 3 },
> +    { SENSORS_SCH311X_IN_MAX(4), "12V_max", SENSORS_SCH311X_IN(4), 
> +                        SENSORS_SCH311X_IN(4), RW,
> +                        NOSYSCTL, VALUE(2), 2, "in4_max", 3 },
> +    { SENSORS_SCH311X_IN_MAX(5), "VRT_max", SENSORS_SCH311X_IN(5),
> +                        SENSORS_SCH311X_IN(5), RW,
> +                        NOSYSCTL, VALUE(2), 2, "in5_max", 3 },
> +    { SENSORS_SCH311X_IN_MAX(6), "Vbat_max", SENSORS_SCH311X_IN(6),
> +                        SENSORS_SCH311X_IN(6), RW,
> +                        NOSYSCTL, VALUE(2), 2, "in6_max", 3 },
> +    { SENSORS_SCH311X_IN_ALARM(0), "2.5V_alarm", SENSORS_SCH311X_IN(0),
> +                        SENSORS_SCH311X_IN(0), RW,
> +                        NOSYSCTL, VALUE(3), 2, "in0_alarm", 3 },

Alarms are not scaled, so the second mapping field shouldn't be set to
SENSORS_SCH311X_IN(0), but to NOMAP. Same for all other alarms, of
course. Also, magnitude is definitely 0 for alarms, and I doubt they
are writable.

> +    { SENSORS_SCH311X_IN_ALARM(1), "Vccp_alarm", SENSORS_SCH311X_IN(1),
> +                        SENSORS_SCH311X_IN(1), RW,
> +                        NOSYSCTL, VALUE(3), 2, "in1_alarm", 3 },
> +    { SENSORS_SCH311X_IN_ALARM(2), "VCC_alarm", SENSORS_SCH311X_IN(2),
> +                        SENSORS_SCH311X_IN(2), RW,
> +                        NOSYSCTL, VALUE(3), 2, "in2_alarm", 3 },
> +    { SENSORS_SCH311X_IN_ALARM(3), "5V_alarm", SENSORS_SCH311X_IN(3),
> +                        SENSORS_SCH311X_IN(3), RW,
> +                        NOSYSCTL, VALUE(3), 2, "in3_alarm", 3 },
> +    { SENSORS_SCH311X_IN_ALARM(4), "12V_alarm", SENSORS_SCH311X_IN(4), 
> +                        SENSORS_SCH311X_IN(4), RW,
> +                        NOSYSCTL, VALUE(3), 2, "in4_alarm", 3 },
> +    { SENSORS_SCH311X_IN_ALARM(5), "VRT_alarm", SENSORS_SCH311X_IN(5),
> +                        SENSORS_SCH311X_IN(5), RW,
> +                        NOSYSCTL, VALUE(3), 2, "in5_alarm", 3 },
> +    { SENSORS_SCH311X_IN_ALARM(6), "Vbat_alarm", SENSORS_SCH311X_IN(6),
> +                        SENSORS_SCH311X_IN(6), RW, 
> +                        NOSYSCTL, VALUE(3), 2, "in6_alarm", 3 },
> +    { SENSORS_SCH311X_TEMP(1), "temp1", NOMAP, NOMAP,
> +                         R, NOSYSCTL, VALUE(5), 2, "temp1_input", 0 },

Magnitude for temperatures in Linux 2.6 is fixed to 3. You don't need
to mention the Linux 2.6 name and magnitude, BTW, libsensors will guess
them.

> +    { SENSORS_SCH311X_TEMP(2), "temp2", NOMAP, NOMAP, 
> +                         R, NOSYSCTL, VALUE(4), 2, "temp2_input", 0 },
> +    { SENSORS_SCH311X_TEMP(3), "temp3", NOMAP, NOMAP,
> +                         R, NOSYSCTL, VALUE(5), 2, "temp3_input", 0 },
> +    { SENSORS_SCH311X_TEMP_MIN(1), "temp1_min", SENSORS_SCH311X_TEMP(1),
> +                         SENSORS_SCH311X_TEMP(1), RW, 
> +                         NOSYSCTL, VALUE(1), 2, "temp1_low", 0 },

Sysfs file name should be "temp1_min", not "temp1_low".

> +    { SENSORS_SCH311X_TEMP_MAX(1), "temp1_max", SENSORS_SCH311X_TEMP(1),
> +                         SENSORS_SCH311X_TEMP(1), RW, 
> +                         NOSYSCTL, VALUE(2), 2, "temp1_high", 0 },

And here "temp1_max" instead of "temp1_high". But again you don't need
to mention them, libsensors will guess them from the symbol name.

> +    { SENSORS_SCH311X_TEMP_ALARM(1), "temp1_alarm", SENSORS_SCH311X_TEMP(1),
> +                         SENSORS_SCH311X_TEMP(1), RW, 
> +                         NOSYSCTL, VALUE(3), 2, "temp1_alarm", 0 },
> +    { SENSORS_SCH311X_TEMP_ERROR(1), "temp1_error", SENSORS_SCH311X_TEMP(1),
> +                         SENSORS_SCH311X_TEMP(1), RW, 
> +                         NOSYSCTL, VALUE(4), 2, "temp1_error", 0 },

This name doesn't exist in our Linux 2.6 sysfs file name standard. If
this "error" refers to an invalid wiring of the thermal sensor (i.e.
input value is invalid) the file should be named temp1_input_fault. I
also doubt the alarm and error files are writable, and the Linux 2.4
magnitude is wrong (should be 0).

> +    { SENSORS_SCH311X_TEMP_MIN(2), "temp2_min", SENSORS_SCH311X_TEMP(2),
> +                         SENSORS_SCH311X_TEMP(2), RW, 
> +                         NOSYSCTL, VALUE(1), 2, "temp2_low", 0 },
> +    { SENSORS_SCH311X_TEMP_MAX(2), "temp2_max", SENSORS_SCH311X_TEMP(2),
> +                         SENSORS_SCH311X_TEMP(2), RW, 
> +                         NOSYSCTL, VALUE(2), 2, "temp2_high", 0 },
> +    { SENSORS_SCH311X_TEMP_ALARM(2), "temp2_alarm", SENSORS_SCH311X_TEMP(2),
> +                         SENSORS_SCH311X_TEMP(2), RW, 
> +                         NOSYSCTL, VALUE(3), 2, "temp2_alarm", 0 },
> +    { SENSORS_SCH311X_TEMP_MIN(3), "temp3_min", SENSORS_SCH311X_TEMP(3),
> +                         SENSORS_SCH311X_TEMP(3), RW, 
> +                         NOSYSCTL, VALUE(1), 2, "temp3_low", 0 },
> +    { SENSORS_SCH311X_TEMP_MAX(3), "temp3_max", SENSORS_SCH311X_TEMP(3),
> +                         SENSORS_SCH311X_TEMP(3), RW, 
> +                         NOSYSCTL, VALUE(2), 2, "temp3_high", 0 },
> +    { SENSORS_SCH311X_TEMP_ALARM(3), "temp3_alarm", SENSORS_SCH311X_TEMP(2),
> +                         SENSORS_SCH311X_TEMP(2), RW, 
> +                         NOSYSCTL, VALUE(3), 2, "temp3_alarm", 0 },

Copy'n'paste error, should be SENSORS_SCH311X_TEMP(3).

> +    { SENSORS_SCH311X_TEMP_ERROR(3), "temp3_error", SENSORS_SCH311X_TEMP(3),
> +                         SENSORS_SCH311X_TEMP(3), RW, 
> +                         NOSYSCTL, VALUE(4), 2, "temp3_error", 0 },
> +    { 0 }
> +  };
> +
>  
>  sensors_chip_features sensors_chip_features_list[] >  {
> @@ -5943,5 +6064,6 @@ sensors_chip_features sensors_chip_featu
>   { SENSORS_SMSC47B397_PREFIX, smsc47b397_features },
>   { SENSORS_F71805F_PREFIX, f71805f_features },
>   { SENSORS_ABITUGURU_PREFIX, abituguru_features },
> + { SENSORS_SCH311X_PREFIX, sch311x_features },
>   { 0 }
>  };
> diff -uprN -X dontdiff_my ./lm-sensors_SVN/lib/chips.h ./lm-sensors_SVN_modif/lib/chips.h
> --- ./lm-sensors_SVN/lib/chips.h	2006-07-17 12:31:42.000000000 +0200
> +++ ./lm-sensors_SVN_modif/lib/chips.h	2006-07-21 17:18:37.000000000 +0200
> @@ -2187,4 +2187,20 @@
>  #define SENSORS_ABITUGURU_FAN_ALARM(n)		(0xA0 + (n)) /* R */
>  #define SENSORS_ABITUGURU_FAN_MIN(n)		(0xB0 + (n)) /* RW */
>  
> +/* SMSC SCH311x chips */
> +#define SENSORS_SCH311X_PREFIX "sch311x"
> +
> +/* for n from 0 to 6 */
> +#define SENSORS_SCH311X_IN(n)		(1  + (n))	/* R */
> +#define SENSORS_SCH311X_IN_MIN(n)	(10 + (n))	/* RW */
> +#define SENSORS_SCH311X_IN_MAX(n)	(20 + (n))	/* RW */
> +#define SENSORS_SCH311X_IN_ALARM(n)	(30 + (n))	/* R */
> +
> +/* for n from 1 to 3 */
> +#define SENSORS_SCH311X_TEMP(n)		(50 + (n))	/* R */
> +#define SENSORS_SCH311X_TEMP_MIN(n)	(60 + (n))	/* RW */
> +#define SENSORS_SCH311X_TEMP_MAX(n)	(70 + (n))	/* RW */
> +#define SENSORS_SCH311X_TEMP_ALARM(n)	(80 + (n))	/* R */
> +#define SENSORS_SCH311X_TEMP_ERROR(n)	(90 + (n))	/* R */
> +
>  #endif /* def LIB_SENSORS_CHIPS_H */
> diff -uprN -X dontdiff_my ./lm-sensors_SVN/prog/detect/sensors-detect ./lm-sensors_SVN_modif/prog/detect/sensors-detect
> --- ./lm-sensors_SVN/prog/detect/sensors-detect	2006-07-17 12:31:42.000000000 +0200
> +++ ./lm-sensors_SVN_modif/prog/detect/sensors-detect	2006-07-17 17:54:13.000000000 +0200
> @@ -1926,6 +1926,24 @@ $chip_kern26_w83791d = {
>          logdev => 0x08,
>        },
>        {
> +        name => "SMSC SCH3112 Super IO",
> +        driver => "sch311x",
> +        devid => 0x7c,
> +        logdev => 0x0a,
> +      },
> +      {
> +        name => "SMSC SCH3114 Super IO",
> +        driver => "sch311x",
> +        devid => 0x7d,
> +        logdev => 0x0a,
> +      },
> +      {
> +        name => "SMSC SCH3116 Super IO",
> +        driver => "sch311x",
> +        devid => 0x7f,
> +        logdev => 0x0a,
> +      },
> +      {
>          name => "SMSC LPC47M584-NC Super IO",
>          # No datasheet
>          devid => 0x76,
> diff -uprN -X dontdiff_my ./lm-sensors_SVN/prog/sensors/chips.c ./lm-sensors_SVN_modif/prog/sensors/chips.c
> --- ./lm-sensors_SVN/prog/sensors/chips.c	2006-07-17 12:31:42.000000000 +0200
> +++ ./lm-sensors_SVN_modif/prog/sensors/chips.c	2006-07-21 17:26:11.000000000 +0200
> @@ -6041,6 +6041,52 @@ void print_abituguru(const sensors_chip_
>        SENSORS_ABITUGURU_FAN_ALARM(i), SENSORS_ABITUGURU_FAN_MIN(i));
>  }
>  
> +void print_sch311x(const sensors_chip_name *name)
> +{
> +  char *label;
> +  double cur, min, max, alarm;
> +  int valid, i;
> +
> +  for (i = 0; i < 7; i++) {
> +    if (!sensors_get_label_and_valid(*name, SENSORS_SCH311X_IN(i),
> +        &label, &valid)
> +     && !sensors_get_feature(*name, SENSORS_SCH311X_IN(i), &cur)
> +     && !sensors_get_feature(*name, SENSORS_SCH311X_IN_MIN(i), &min)
> +     && !sensors_get_feature(*name, SENSORS_SCH311X_IN_MAX(i), &max)) {
> +      if (valid) {
> +        print_label(label, 10);
> +        printf("%+6.2f V  (min = %+6.2f V, max = %+6.2f V)   %s\n",
> +               cur, min, max, sensors_get_feature(*name, 
> +               SENSORS_SCH311X_IN_ALARM(i), &alarm) ? "NOT SUPPORTED" : 

Why don't you simply get the alarm value together with the other
values? The code would be more readable.

> +               alarm ? "ALARM" : "");
> +      }
> +    } else
> +      printf("Can't get in%d data!\n", i);

We usually prefix these messages with "ERROR: ".

> +    free(label);
> +  }
> +
> +  for (i = 1; i <= 3; i++) {
> +    if (!sensors_get_label_and_valid(*name, SENSORS_SCH311X_TEMP(i),
> +        &label, &valid)
> +     && !sensors_get_feature(*name, SENSORS_SCH311X_TEMP(i), &cur)
> +     && !sensors_get_feature(*name, SENSORS_SCH311X_TEMP_MAX(i), &max)
> +     && !sensors_get_feature(*name, SENSORS_SCH311X_TEMP_MIN(i), &min)) {
> +      if (valid) {
> +        print_label(label, 10);
> +        print_temp_info(cur, max, min, HYST, 0, 0);

Is the low temperature limit really an hysteresis value? You named it
everywhere as if it were a min limit. Please clarify. If it's an
hysteresis value, the symbold and file names need to be changed. If
it's a min value, please use MINMAX instead of HYST here.

> +        printf("%6s", sensors_get_feature(*name, 
> +               SENSORS_SCH311X_TEMP_ALARM(i), &alarm) ? "NOT SUPPORTED" : 
> +               alarm ? "ALARM" : "");
> +        printf("%6s", sensors_get_feature(*name, SENSORS_SCH311X_TEMP_ERROR(i),
> +          &alarm) ? "" : (alarm) ? "ERROR" : "" );

Same here, getting the alarm and error/fault values beforehand would
make the code much more readable IMHO. You should also check the fault
condition first, as it doesn't make much sense to display an alarm if
the input has a fault condition to start with.

BTW you're reading the error/fault value even for i=2, while this file
doesn't exist, this needs to be fixed.

> +        printf("\n");
> +      }
> +    } else
> +      printf("Can't get temp%d data!\n", i);
> +    free(label);
> +  }
> +}
> +
>  void print_unknown_chip(const sensors_chip_name *name)
>  {
>    int a,b,valid;
> diff -uprN -X dontdiff_my ./lm-sensors_SVN/prog/sensors/chips.h ./lm-sensors_SVN_modif/prog/sensors/chips.h
> --- ./lm-sensors_SVN/prog/sensors/chips.h	2006-07-17 12:31:42.000000000 +0200
> +++ ./lm-sensors_SVN_modif/prog/sensors/chips.h	2006-07-17 12:50:53.000000000 +0200
> @@ -73,5 +73,6 @@ extern void print_adm1031(const sensors_
>  extern void print_smsc47b397(const sensors_chip_name *name);
>  extern void print_f71805f(const sensors_chip_name *name);
>  extern void print_abituguru(const sensors_chip_name *name);
> +extern void print_sch311x(const sensors_chip_name *name);
>  
>  #endif /* def PROG_SENSORS_CHIPS_H */
> diff -uprN -X dontdiff_my ./lm-sensors_SVN/prog/sensors/main.c ./lm-sensors_SVN_modif/prog/sensors/main.c
> --- ./lm-sensors_SVN/prog/sensors/main.c	2006-07-17 12:31:42.000000000 +0200
> +++ ./lm-sensors_SVN_modif/prog/sensors/main.c	2006-07-17 13:28:04.000000000 +0200
> @@ -416,6 +416,7 @@ struct match matches[] = {
>  	{ "smsc47b397", print_smsc47b397 },
>  	{ "f71805f", print_f71805f },
>   	{ "abituguru", print_abituguru },
> +	{ "sch311x", print_sch311x },
>  	{ NULL, NULL }
>  };
>  
> 

Care to provide an updated patch against the current lm_sensors SVN
tree?

Thanks,
-- 
Jean Delvare

