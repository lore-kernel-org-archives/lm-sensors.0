From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 25 Mar 2007 16:38:04 +0000
Subject: [lm-sensors] [PATCH] lm-sensors: add dme1737 support
Message-Id: <20070325183804.78b94006.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0703232147q3a74701ci4bedf256201ee587@mail.gmail.com>
In-Reply-To: <191fb4ca0703232147q3a74701ci4bedf256201ee587@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Fri, 23 Mar 2007 21:47:31 -0700, Juerg Haefliger wrote:
> This patch fixes a bug in sensors-detect that prevents the SMSC
> DME1737 from being discovered. It also adds full support for the chip
> to libsensors and sensors.
> 
> Signed-off-by: Juerg Haefliger <juergh at gmail.com>

> diff -uprN -X dontdiff lm-sensors.orig/etc/sensors.conf.eg lm-sensors/etc/sensors.conf.eg
> --- lm-sensors.orig/etc/sensors.conf.eg	2007-02-06 22:47:12.000000000 -0800
> +++ lm-sensors/etc/sensors.conf.eg	2007-03-21 21:24:28.000000000 -0700
> @@ -2813,3 +2813,74 @@ chip "k8temp-*"
>     label temp2 "Core0 Temp"
>     label temp3 "Core1 Temp"
>     label temp4 "Core1 Temp"
> +
> +
> +#
> +# Sample configuration for the SMSC DME1737 and ASUS A8000
> +#
> +chip "dme1737-*"
> +
> +# Voltage inputs
> +   label in0   "V5stby"
> +   label in1   "Vccp"
> +   label in2   "V3.3"
> +   label in3   "V5"
> +   label in4   "V12"
> +   label in5   "V3.3stby"
> +   label in6   "Vbat"
> +
> +# Temperature inputs
> +   label temp1   "RD1 Temp"
> +   label temp2   "Int Temp"
> +   label temp3   "CPU Temp"
> +
> +# Fan inputs
> +   label fan1   "CPU_Fan"
> +   label fan2   "Fan2"
> +   label fan3   "Fan3"
> +   label fan4   "Fan4"
> +   label fan5   "Fan5"
> +   label fan6   "Fan6"
> +
> +# PWM Outputs
> +   label pwm1   "CPU_PWM"
> +   label pwm2   "Fan2_PWM"
> +   label pwm3   "Fan3_PWM"
> +   label pwm5   "Fan5_PWM"
> +   label pwm6   "Fan6_PWM"
> +
> +# Set VRM version
> +# adjust this if your vid is wrong; see doc/vid
> +#   set vrm  9.1   # Pentium 4

In Linux 2.6 this is selected automatically depending on the CPU model,
so the user shouldn't have to care at all.

> +
> +# Set voltage limits
> +#   set in0_min   5.0 * 0.95
> +#   set in0_max   5.0 * 1.05
> +#   set in1_min  1.4 * 0.95
> +#   set in1_max  1.4 * 1.05

Fix the alignment.

> +#   set in2_min   3.3 * 0.95
> +#   set in2_max   3.3 * 1.05
> +#   set in3_min   5.0 * 0.95
> +#   set in3_max   5.0 * 1.05
> +#   set in4_min  12.0 * 0.95
> +#   set in4_max  12.0 * 1.05
> +#   set in5_min   3.3 * 0.95
> +#   set in5_max   3.3 * 1.05
> +#   set in6_min   3.0 * 0.95
> +#   set in6_max   3.0 * 1.05
> +
> +# Set Temp Limits
> +#   set temp1_min 10
> +#   set temp1_max 75
> +#   set temp2_min 10
> +#   set temp2_max 75
> +#   set temp3_min 10
> +#   set temp3_max 75
> +
> +# Set Fan limits
> +#   set fan1_min 1000
> +#   set fan2_min 1000
> +#   set fan3_min 1000
> +#   set fan4_min 1000
> +#   set fan5_min 1000
> +#   set fan6_min 1000
> diff -uprN -X dontdiff lm-sensors.orig/lib/chips.c lm-sensors/lib/chips.c
> --- lm-sensors.orig/lib/chips.c	2007-02-06 22:47:09.000000000 -0800
> +++ lm-sensors/lib/chips.c	2007-03-23 21:21:32.000000000 -0700
> @@ -5931,6 +5931,94 @@ static sensors_chip_feature coretemp_fea
>      { { 0 }, 0 }
>    };
>  
> +#define SENSORS_DME1737_IN_FEATURES(nr) \
> +	{ { SENSORS_DME1737_IN(nr), "in" #nr, \
> +		NOMAP, NOMAP, R }, \
> +		NOSYSCTL, VALUE(3), 3 }, \
> +	{ { SENSORS_DME1737_IN_MIN(nr), "in" #nr "_min", \
> +		SENSORS_DME1737_IN(nr), SENSORS_DME1737_IN(nr), RW }, \
> +		NOSYSCTL, VALUE(1), 3 }, \
> +	{ { SENSORS_DME1737_IN_MAX(nr), "in" #nr "_max", \
> +		SENSORS_DME1737_IN(nr), SENSORS_DME1737_IN(nr), RW }, \
> +		NOSYSCTL, VALUE(2), 3 }, \
> +	{ { SENSORS_DME1737_IN_ALARM(nr), "in" #nr "_alarm", \
> +		SENSORS_DME1737_IN(nr), NOMAP, R }, \
> +		NOSYSCTL, VALUE(1), 0 }
> +
> +#define SENSORS_DME1737_TEMP_FEATURES(nr) \
> +	{ { SENSORS_DME1737_TEMP(nr), "temp" #nr, \
> +		NOMAP, NOMAP, R }, \
> +		NOSYSCTL, VALUE(3), 3 }, \
> +	{ { SENSORS_DME1737_TEMP_MIN(nr), "temp" #nr "_min", \
> +		SENSORS_DME1737_TEMP(nr), SENSORS_DME1737_TEMP(nr), RW }, \
> +		NOSYSCTL, VALUE(1), 3 }, \

Should be VALUE(2) - although we don't really care for a Linux 2.6-only
driver.

> +	{ { SENSORS_DME1737_TEMP_MAX(nr), "temp" #nr "_max", \
> +		SENSORS_DME1737_TEMP(nr), SENSORS_DME1737_TEMP(nr), RW }, \
> +		NOSYSCTL, VALUE(1), 3 }, \
> +	{ { SENSORS_DME1737_TEMP_ALARM(nr), "temp" #nr "_alarm", \
> +		SENSORS_DME1737_TEMP(nr), NOMAP, R }, \
> +		NOSYSCTL, VALUE(1), 3 }, \
> +	{ { SENSORS_DME1737_TEMP_FAULT(nr), "temp" #nr "_fault", \
> +		SENSORS_DME1737_TEMP(nr), NOMAP, R }, \
> +		NOSYSCTL, VALUE(1), 3 }

Alarm and fault with magnitude 3? I don't think so.

> +
> +#define SENSORS_DME1737_FAN_FEATURES(nr) \
> +	{ { SENSORS_DME1737_FAN(nr), "fan" #nr, \
> +		NOMAP, NOMAP, R }, \
> +		NOSYSCTL, VALUE(2), 0 }, \
> +	{ { SENSORS_DME1737_FAN_MIN(nr), "fan" #nr "_min", \
> +		SENSORS_DME1737_FAN(nr), SENSORS_DME1737_FAN(nr), RW }, \
> +		NOSYSCTL, VALUE(1), 0 }, \
> +	{ { SENSORS_DME1737_FAN_ALARM(nr), "fan" #nr "_alarm", \
> +		SENSORS_DME1737_FAN(nr), NOMAP, R }, \
> +		NOSYSCTL, VALUE(1), 0 }
> +
> +#define SENSORS_DME1737_PWM_FEATURES(nr) \
> +	{ { SENSORS_DME1737_PWM(nr), "pwm" #nr, \
> +		NOMAP, NOMAP, RW }, \
> +		NOSYSCTL, VALUE(1), 0 }, \
> +	{ { SENSORS_DME1737_PWM_ENABLE(nr), "pwm" #nr "_enable", \
> +		SENSORS_DME1737_PWM(nr), SENSORS_DME1737_PWM(nr), RW }, \
> +		NOSYSCTL, VALUE(2), 0 }, \
> +	{ { SENSORS_DME1737_PWM_FREQ(nr), "pwm" #nr "_freq", \
> +		SENSORS_DME1737_PWM(nr), SENSORS_DME1737_PWM(nr), RW }, \
> +		NOSYSCTL, VALUE(3), 0 }
> +
> +#define SENSORS_DME1737_MISC_FEATURES \
> +	{ { SENSORS_DME1737_VID, "vid", \
> +		NOMAP, NOMAP, R }, \
> +		NOSYSCTL, VALUE(1), 3 }, \
> +	{ { SENSORS_DME1737_VRM, "vrm", \
> +		NOMAP, NOMAP, RW }, \
> +		NOSYSCTL, VALUE(1), 1 }

No point in having a macro for these, please include them directly in
the array of features below.

> +
> +static sensors_chip_feature dme1737_features[] > +{
> +	SENSORS_DME1737_IN_FEATURES(0),
> +	SENSORS_DME1737_IN_FEATURES(1),
> +	SENSORS_DME1737_IN_FEATURES(2),
> +	SENSORS_DME1737_IN_FEATURES(3),
> +	SENSORS_DME1737_IN_FEATURES(4),
> +	SENSORS_DME1737_IN_FEATURES(5),
> +	SENSORS_DME1737_IN_FEATURES(6),
> +	SENSORS_DME1737_TEMP_FEATURES(1),
> +	SENSORS_DME1737_TEMP_FEATURES(2),
> +	SENSORS_DME1737_TEMP_FEATURES(3),
> +	SENSORS_DME1737_FAN_FEATURES(1),
> +	SENSORS_DME1737_FAN_FEATURES(2),
> +	SENSORS_DME1737_FAN_FEATURES(3),
> +	SENSORS_DME1737_FAN_FEATURES(4),
> +	SENSORS_DME1737_FAN_FEATURES(5),
> +	SENSORS_DME1737_FAN_FEATURES(6),
> +	SENSORS_DME1737_PWM_FEATURES(1),
> +	SENSORS_DME1737_PWM_FEATURES(2),
> +	SENSORS_DME1737_PWM_FEATURES(3),
> +	SENSORS_DME1737_PWM_FEATURES(5),
> +	SENSORS_DME1737_PWM_FEATURES(6),
> +	SENSORS_DME1737_MISC_FEATURES,
> +	{ { 0 }, 0 }
> +};
> +
>  sensors_chip_features sensors_chip_features_list[] >  {
>   { SENSORS_LM78_PREFIX, lm78_features },
> @@ -6042,5 +6130,6 @@ sensors_chip_features sensors_chip_featu
>   { SENSORS_ABITUGURU_PREFIX, abituguru_features },
>   { SENSORS_K8TEMP_PREFIX, k8temp_features },
>   { SENSORS_CORETEMP_PREFIX, coretemp_features },
> + { SENSORS_DME1737_PREFIX, dme1737_features },
>   { 0 }
>  };
> diff -uprN -X dontdiff lm-sensors.orig/lib/chips.h lm-sensors/lib/chips.h
> --- lm-sensors.orig/lib/chips.h	2007-02-06 22:47:09.000000000 -0800
> +++ lm-sensors/lib/chips.h	2007-03-23 21:27:30.000000000 -0700
> @@ -2258,4 +2258,30 @@
>  #define SENSORS_CORETEMP_TEMP1_CRIT		0x02 /* R */
>  #define SENSORS_CORETEMP_TEMP1_CRIT_ALARM	0x03 /* R */
>  
> +/* DME1737 */
> +
> +#define SENSORS_DME1737_PREFIX "dme1737"
> +

Please state in a comment each time in which range "n" should be.

> +#define SENSORS_DME1737_IN(n)			(0x01 + (n)) /* R */
> +#define SENSORS_DME1737_IN_MIN(n)		(0x11 + (n)) /* RW */
> +#define SENSORS_DME1737_IN_MAX(n)		(0x21 + (n)) /* RW */
> +#define SENSORS_DME1737_IN_ALARM(n)		(0x31 + (n)) /* R */
> +
> +#define SENSORS_DME1737_TEMP(n)			(0x41 + (n)) /* R */
> +#define SENSORS_DME1737_TEMP_MIN(n)		(0x51 + (n)) /* RW */
> +#define SENSORS_DME1737_TEMP_MAX(n)		(0x61 + (n)) /* RW */
> +#define SENSORS_DME1737_TEMP_ALARM(n)		(0x71 + (n)) /* R */
> +#define SENSORS_DME1737_TEMP_FAULT(n)		(0x81 + (n)) /* R */
> +
> +#define SENSORS_DME1737_FAN(n)			(0x91 + (n)) /* R */
> +#define SENSORS_DME1737_FAN_MIN(n)		(0xa1 + (n)) /* RW */
> +#define SENSORS_DME1737_FAN_ALARM(n)		(0xb1 + (n)) /* R */
> +
> +#define SENSORS_DME1737_PWM(n)			(0xc1 + (n)) /* RW */
> +#define SENSORS_DME1737_PWM_ENABLE(n)		(0xd1 + (n)) /* RW */
> +#define SENSORS_DME1737_PWM_FREQ(n)		(0xe1 + (n)) /* RW */
> +
> +#define SENSORS_DME1737_VID			(0xf0) /* R */
> +#define SENSORS_DME1737_VRM			(0xf1) /* RW */
> +
>  #endif /* def LIB_SENSORS_CHIPS_H */
> diff -uprN -X dontdiff lm-sensors.orig/lib/proc.c lm-sensors/lib/proc.c
> --- lm-sensors.orig/lib/proc.c	2007-02-06 22:47:09.000000000 -0800
> +++ lm-sensors/lib/proc.c	2007-03-21 20:22:52.000000000 -0700
> @@ -263,10 +263,14 @@ static const struct match matches[] = {
>  	{ "pwm2", "pwm2", 0, "fan2_pwm" },
>  	{ "pwm3", "pwm3", 0, "fan3_pwm" },
>  	{ "pwm4", "pwm4", 0, "fan4_pwm" },
> +	{ "pwm5", "pwm5", 0, "fan5_pwm" },
> +	{ "pwm6", "pwm6", 0, "fan6_pwm" },
>  	{ "pwm1_enable", "pwm1_enable", 0, "fan1_pwm_enable" },
>  	{ "pwm2_enable", "pwm2_enable", 0, "fan2_pwm_enable" },
>  	{ "pwm3_enable", "pwm3_enable", 0, "fan3_pwm_enable" },
>  	{ "pwm4_enable", "pwm4_enable", 0, "fan4_pwm_enable" },
> +	{ "pwm5_enable", "pwm5_enable", 0, "fan5_pwm_enable" },
> +	{ "pwm6_enable", "pwm6_enable", 0, "fan6_pwm_enable" },
>  	{ NULL, NULL }
>  };
>  

You shouldn't need this, the alternative names were only in use for a
short range of early 2.6 kernels, and your driver will never be
backported to these kernels.

> diff -uprN -X dontdiff lm-sensors.orig/prog/detect/sensors-detect lm-sensors/prog/detect/sensors-detect
> --- lm-sensors.orig/prog/detect/sensors-detect	2007-02-06 22:47:11.000000000 -0800
> +++ lm-sensors/prog/detect/sensors-detect	2007-03-23 21:33:09.000000000 -0700
> @@ -1419,7 +1419,7 @@ use vars qw(@pci_adapters_sis5595 @pci_a
>       },
>       {
>         name => "SMSC DME1737",
> -       driver => "to-be-written",
> +       driver => "dme1737",
>         i2c_addrs => [0x2c..0x2e],
>         i2c_detect => sub { dme1737_detect(@_); },
>       },
> @@ -1805,10 +1805,16 @@ $chip_kern26_w83791d = {
>          devid => 0x76,
>        },
>        {
> -	name => "SMSC DME1737 Super IO",
> -	# Hardware monitoring features are accessed on the SMBus
> -	driver => "not-a-sensor",
> -	devid => 0x78,
> +        name => "SMSC DME1737 Super IO",
> +        # Hardware monitoring features are accessed on the SMBus
> +        driver => "via-smbus-only",
> +        devid => 0x78,
> +      },
> +      {
> +        name => "SMSC DME1737 Super IO",
> +        # Hardware monitoring features are accessed on the SMBus
> +        driver => "via-smbus-only",
> +        devid => 0x77,
>        },
>      ],
>    },

Please document the new special driver name you are introducing, like
"to-be-written" and "not-a-sensor" are, in the big comment before the
array.

And please don't change the indentation. I know the indentation in that
script is bad and inconsistent, but changing it only makes the patch,
and the file history, harder to read.

> @@ -3083,6 +3089,10 @@ sub probe_superio($$$)
>      print "\n    (no hardware monitoring capabilities)\n";
>      return;
>    }
> +  if ($chip->{driver} eq "via-smbus-only") {
> +    print "\n    (hardware monitoring capabilities accessible via SMBus only)\n";
> +    return;
> +  }
>  
>    # Switch to the sensor logical device
>    outb($addrreg, $superio{logdevreg});
> @@ -4815,11 +4825,10 @@ sub smsc47m192_detect
>  sub dme1737_detect
>  {
>    my ($file, $addr) = @_;
> -  return unless i2c_smbus_read_byte_data($file, 0x3E) = 0x55
> +  return unless i2c_smbus_read_byte_data($file, 0x3E) = 0x5C
>             and (i2c_smbus_read_byte_data($file, 0x3F) & 0xF8) = 0x88
> -           and (i2c_smbus_read_byte_data($file, 0x40) & 0xC4) = 0x04
> -           and (i2c_smbus_read_byte_data($file, 0x42) & 0x02) = 0x00
> -           and (i2c_smbus_read_byte_data($file, 0x43) & 0xC0) = 0x00;
> +           and (i2c_smbus_read_byte_data($file, 0x73) & 0x0F) = 0x09
> +           and (i2c_smbus_read_byte_data($file, 0x8A) & 0x7F) = 0x4D;
>    return ($addr = 0x2e ? 6 : 5);
>  }
>  

If you change the registers that are used for detection, please update
the comment before the function accordingly.

> diff -uprN -X dontdiff lm-sensors.orig/prog/sensors/chips.c lm-sensors/prog/sensors/chips.c
> --- lm-sensors.orig/prog/sensors/chips.c	2007-02-06 22:47:10.000000000 -0800
> +++ lm-sensors/prog/sensors/chips.c	2007-03-21 20:49:41.000000000 -0700
> @@ -6336,6 +6336,121 @@ void print_coretemp(const sensors_chip_n
>    free(label);
>  }
>  
> +static void print_dme1737_in(const sensors_chip_name *name, int i)
> +{
> +  char *label;
> +  double cur, min, max, alarm;
> +  int valid;
> +
> +  if (!sensors_get_label_and_valid(*name, SENSORS_DME1737_IN(i), &label,
> +				   &valid) &&
> +      !sensors_get_feature(*name, SENSORS_DME1737_IN(i), &cur) &&
> +      !sensors_get_feature(*name, SENSORS_DME1737_IN_MIN(i), &min) &&
> +      !sensors_get_feature(*name, SENSORS_DME1737_IN_MAX(i), &max) &&
> +      !sensors_get_feature(*name, SENSORS_DME1737_IN_ALARM(i), &alarm)) {
> +    if (valid) {
> +      print_label(label, 10);
> +      printf("%+6.2f V  (min = %+6.2f V, max = %+6.2f V)  %s\n",
> +	     cur, min, max, alarm ? "ALARM" : "");
> +    }
> +  } else {
> +    printf("ERROR: Can't get in%d data!\n", i);
> +  }
> +  free(label);
> +}
> +
> +static void print_dme1737_temp(const sensors_chip_name *name, int i)
> +{
> +  char *label;
> +  double cur, min, max, alarm, fault;
> +  int valid;
> +
> +  if (!sensors_get_label_and_valid(*name, SENSORS_DME1737_TEMP(i), &label,
> +				   &valid) &&
> +      !sensors_get_feature(*name, SENSORS_DME1737_TEMP(i), &cur) &&
> +      !sensors_get_feature(*name, SENSORS_DME1737_TEMP_MIN(i), &min) &&
> +      !sensors_get_feature(*name, SENSORS_DME1737_TEMP_MAX(i), &max) &&
> +      !sensors_get_feature(*name, SENSORS_DME1737_TEMP_ALARM(i), &alarm) &&
> +      !sensors_get_feature(*name, SENSORS_DME1737_TEMP_FAULT(i), &fault)) {
> +    if (valid) {
> +      print_label(label, 10);
> +      print_temp_info(cur, max, min, MINMAX, 0, 0);
> +      printf("%s  %s\n", fault ? "FAULT" : "", alarm ? "ALARM" : "");
> +    }
> +  } else {
> +    printf("ERROR: Can't get temp%d data!\n", i);
> +  }
> +  free(label);
> +}
> +
> +static void print_dme1737_fan(const sensors_chip_name *name, int i)
> +{
> +  char *label;
> +  double cur, min, alarm;
> +  int valid;
> +
> +  if (!sensors_get_label_and_valid(*name, SENSORS_DME1737_FAN(i), &label,
> +				   &valid) &&
> +      !sensors_get_feature(*name, SENSORS_DME1737_FAN(i), &cur) &&
> +      !sensors_get_feature(*name, SENSORS_DME1737_FAN_MIN(i), &min) &&
> +      !sensors_get_feature(*name, SENSORS_DME1737_FAN_ALARM(i), &alarm)) {
> +    if (valid) {
> +      print_label(label, 10);
> +      printf("%4.0f RPM  (min = %4.0f RPM)  %s\n", 
> +	     cur, min, alarm ? "ALARM" : "");
> +    }
> +  } else {
> +    printf("ERROR: Can't get fan%d data!\n", i);
> +  }
> +  free(label);
> +}
> +
> +static void print_dme1737_pwm(const sensors_chip_name *name, int i)
> +{
> +  char *label;
> +  double cur, enable, freq;
> +  int valid;
> +
> +  if (!sensors_get_label_and_valid(*name, SENSORS_DME1737_PWM(i), &label,
> +				   &valid) &&
> +      !sensors_get_feature(*name, SENSORS_DME1737_PWM(i), &cur) &&
> +      !sensors_get_feature(*name, SENSORS_DME1737_PWM_ENABLE(i), &enable) &&
> +      !sensors_get_feature(*name, SENSORS_DME1737_PWM_FREQ(i), &freq)) {
> +    if (valid) {
> +      print_label(label, 10);
> +      printf("%4.0f      (enable = %1.0f, freq = %6.0f Hz)\n", cur, enable, freq);
> +    }
> +  } else {
> +    printf("ERROR: Can't get pwm%d data!\n", i);
> +  }
> +  free(label);
> +}
> +
> +void print_dme1737(const sensors_chip_name *name)
> +{
> +  int i;
> +
> +  for (i = 0; i < 7; i++) {
> +    print_dme1737_in(name, i);
> +  }
> +
> +  for (i = 0; i < 3; i++) {
> +    print_dme1737_temp(name, i+1);
> +  }

Why don't you just do "for (i = 1; i <= 3; i++)"? That would be
clearer, and more efficient.

> +
> +  for (i = 0; i < 6; i++) {
> +    print_dme1737_fan(name, i+1);
> +  }
> +
> +  for (i = 0; i < 6; i++) {
> +    if (i = 3)
> +      continue;
> +    print_dme1737_pwm(name, i+1);
> +  }

Same for fan and pwm.

> +
> +  print_vid_info(name, SENSORS_DME1737_VID, SENSORS_DME1737_VRM);
> +}
> +
>  void print_unknown_chip(const sensors_chip_name *name)
>  {
>    int a,b,valid;
> diff -uprN -X dontdiff lm-sensors.orig/prog/sensors/chips.h lm-sensors/prog/sensors/chips.h
> --- lm-sensors.orig/prog/sensors/chips.h	2007-02-06 22:47:10.000000000 -0800
> +++ lm-sensors/prog/sensors/chips.h	2007-02-10 16:45:01.000000000 -0800
> @@ -78,5 +78,6 @@ extern void print_f71805f(const sensors_
>  extern void print_abituguru(const sensors_chip_name *name);
>  extern void print_k8temp(const sensors_chip_name *name);
>  extern void print_coretemp(const sensors_chip_name *name);
> +extern void print_dme1737(const sensors_chip_name *name);
>  
>  #endif /* def PROG_SENSORS_CHIPS_H */
> diff -uprN -X dontdiff lm-sensors.orig/prog/sensors/main.c lm-sensors/prog/sensors/main.c
> --- lm-sensors.orig/prog/sensors/main.c	2007-02-06 22:47:10.000000000 -0800
> +++ lm-sensors/prog/sensors/main.c	2007-02-10 16:43:11.000000000 -0800
> @@ -422,6 +422,7 @@ struct match matches[] = {
>   	{ "abituguru", print_abituguru },
>   	{ "k8temp", print_k8temp },
>   	{ "coretemp", print_coretemp },
> +	{ "dme1737", print_dme1737 },
>  	{ NULL, NULL }
>  };
>  

Thanks,
-- 
Jean Delvare

