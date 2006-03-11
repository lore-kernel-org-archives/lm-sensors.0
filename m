From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 11 Mar 2006 09:45:14 +0000
Subject: [lm-sensors] sensors program patch for SMSC47M192
Message-Id: <20060311104514.a805ac82.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.63.0603050021410.4437@Laila>
In-Reply-To: <Pine.LNX.4.63.0603050021410.4437@Laila>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo Hartmut,

Sorry for the late answer, I've been ill (and still am to some extent.)

> Attached is a patch which makes the sensors program print the readings 
> from the preliminary smsc47m192 driver for 2.6 kernels.
> The patch is relative to the lm_sensors-2.10.0 release.
> 
> This is definitely not a candidate for release, since I did not really 
> know what I'm doing. I just kept changing the source until printing the 
> readings from the smsc47m192 driver worked for me.

It's not so bad :)

> I copied the code from some other chips. Since they all use a set of 
> definitions containing _SYSCTL_, I did the same. For other drivers, those 
> definitions are scanned from the kernel drivers for 2.4. Since I don't 
> have a driver for 2.4 kernels, I just included a dummy file which contains 
> only the #defines. I still have the suspicion that I don't need all that 
> at all, but I couldn't yet figure out what the code should look like.
> I haven't even tested whether this breaks the support for 2.4 kernels.

You're right, you don't need the SYSCTL stuff unless you have a Linux
2.4 driver. You can just use NOSYSCTL for each SYSCTL define in
lib/chips.c. See the w83627ehf definitions for an example. So you don't
need to provide that dummy kernel/chips/smsc47m192.c file.

> I'm posting the patch here anyway, since it works for me and I guess it 
> might be helpful for anybody who wants to test the smsc47m192 driver.

Yes, good idea. And this will also let me review it and comment on it,
which cannot hurt. Here we go.

> --- lm_sensors-2.10.0/etc/sensors.conf.eg	2006-02-15 02:46:47.000000000 +0100
> +++ lm_sensors-2.10.0-new/etc/sensors.conf.eg	2006-03-05 00:16:22.000000000 +0100
> (...)
> +chip "smsc47m192-*"
> +
> +    label in0 "+2.5V"
> +    label in1 "VCore"
> +    label in2 "+3.3V"
> +    label in3 "+5V"
> +    label in4 "+12V"
> +    label in5 "VCC"
> +    label in6 "+1.5V"
> +    label in7 "+1.8V"
> +    
> +    label temp1 "Chip Temp"
> +    label temp2 "CPU Temp"
> +    label temp3 "Sys Temp"

Good. Maybe you could add a comment explaining that voltage inputs are
scaled internally, which is why no "compute" lines are needed for
in0-in7.

Also you could add statements to set the voltage limits with
"sensors -s":

   set in0_min  2.5 * 0.95
   set in0_max  2.5 * 1.05
   set in1_min  vid * 0.95
   set in1_max  vid * 1.05
   set in2_min  3.3 * 0.95
   set in2_max  3.3 * 1.05

etc.

Last you could add such statements to set the temperature limits too,
but commented out, because the BIOS might have set them properly
already.

> --- lm_sensors-2.10.0/lib/chips.c	2006-02-15 02:46:48.000000000 +0100
> +++ lm_sensors-2.10.0-new/lib/chips.c	2006-03-04 23:58:57.000000000 +0100
> (...)
> +    { SENSORS_SMSC47M192_IN0_ALARM, "in0_alarm", SENSORS_SMSC47M192_IN0, NOMAP,
> +                            R, SMSC47M192_SYSCTL_IN0, VALUE(2), 0 },

Alarms (and faults) would use VALUE(1) if they are individual files.
This field doesn't affect Linux 2.6 though.

> +    { SENSORS_SMSC47M192_TEMP1, "temp1", NOMAP, NOMAP,
> +                         R, SMSC47M192_SYSCTL_TEMP1, VALUE(3), 3 },

Last value (magnitude for sysctl) would be 0 for temperatures, as the
chip returns integer values (LSB = 1 degree C). This value doesn't
affect your Linux 2.6 driver, for which a magnitude of 3 will be
assumed regardless of this value.

> +    { SENSORS_SMSC47M192_TEMP1_MIN, "temp1_min", SENSORS_SMSC47M192_TEMP1,
> +                              SENSORS_SMSC47M192_TEMP1, RW, 
> +                              SMSC47M192_SYSCTL_TEMP1, VALUE(1), 3 },
> (...)
> +    { SENSORS_SMSC47M192_TEMP1_MAX, "temp1_max", SENSORS_SMSC47M192_TEMP1,
> +                              SENSORS_SMSC47M192_TEMP1, RW, 
> +                              SMSC47M192_SYSCTL_TEMP1, VALUE(2), 3 },

For temperatures, the Linux 2.4 standard is VALUE(1) for the high limit
and VALUE(2) for the low limit. This still doesn't affect your Linux 2.6
driver, but let's get it right in case we merge a Linux 2.4 driver for
that chip someday.

> +    { SENSORS_SMSC47M192_TEMP1_FAULT, "temp1_fault", SENSORS_SMSC47M192_TEMP1,
> +                              NOMAP, R, 
> +                              SMSC47M192_SYSCTL_TEMP1, VALUE(2), 0 },

There is no such feature for temp1 as far as I understood, so you
shouldn't list it.

> --- lm_sensors-2.10.0/lib/chips.h	2006-02-15 02:46:48.000000000 +0100
> +++ lm_sensors-2.10.0-new/lib/chips.h	2006-03-05 00:02:29.000000000 +0100
> (...)
> +#define SENSORS_SMSC47M192_IN0		1	/* R */
> +#define SENSORS_SMSC47M192_IN1		2	/* R */
> +#define SENSORS_SMSC47M192_IN2		3	/* R */
> +#define SENSORS_SMSC47M192_IN3		4	/* R */
> +#define SENSORS_SMSC47M192_IN4		5	/* R */
> +#define SENSORS_SMSC47M192_IN5		6	/* R */
> +#define SENSORS_SMSC47M192_IN6		7	/* R */
> +#define SENSORS_SMSC47M192_IN7		8	/* R */

Given the usage you then make of these values in prog/sensors/chips.c
(SENSORS_SMSC47M192_IN0+i), I'd suggest that you define a parametrized
macro here directly. See what I did for the F71805F values for an
example. This will help shorten this definition step significantly.

> +#define SENSORS_SMSC47M192_IN6_MAX	27	/* RW */
> +#define SENSORS_SMSC47M192_IN7_MAX	28	/* RW */
> +#define SENSORS_SMSC47M192_IN0_ALARM	29	/* R */
> +#define SENSORS_SMSC47M192_IN1_ALARM	30	/* R */

You should leave some room between sets. A future chip, mostly
compatible with the ones this driver supports, could have a few
additional voltage inputs. Given that these values are totally
arbitrary, we better don't prevent ourselves from extending the driver
in the future.

Same holds for temperatures, obviously.

> --- lm_sensors-2.10.0/prog/sensors/chips.c	2006-02-15 02:46:49.000000000 +0100
> +++ lm_sensors-2.10.0-new/prog/sensors/chips.c	2006-03-05 00:20:44.000000000 +0100
> (...)
> +	if (!sensors_get_feature(*name,SENSORS_SMSC47M192_TEMP1_FAULT+i,&cur))
> +	  if (cur>0.5)
> +	    printf("FAULT");

You want to skip this for i = 0.

> +	if (!sensors_get_feature(*name,SENSORS_SMSC47M192_TEMP1_ALARM+i,&cur))
> +	  if (cur>0.5)
> +	    printf(" ALARM");

In fact, an alarm is no more relevant when a diode fault occured, as
the reading is no more valid. So I'd suggest that you don't display
ALARM if you already displayed FAULT. Something like this would do, I
think:

	if (i > 0
	 && !sensors_get_feature(*name, SENSORS_SMSC47M192_TEMP1_FAULT+i, &cur)
	 && cur > 0.5)
	  printf("FAULT");
	else
	if (!sensors_get_feature(*name, SENSORS_SMSC47M192_TEMP1_ALARM+i, &cur)
	 && cur > 0.5)
	  printf("ALARM");

That's only a suggestion though.

A comment on coding style too. You could notice that the coding style
in the user-space part of lm_sensors is plain broken, so I'll not tell
you to stick to it. However, when adding new code there, we try to
follow the usual spacing rules (spaces after comma...) and lines no
longer than 80 columns.

Could your patch also update prog/detect/sensors-detect to map the
relevant chip entry to your new driver?

Thanks,
-- 
Jean Delvare

