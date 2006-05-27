From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 27 May 2006 21:43:48 +0000
Subject: [lm-sensors] PATCH: libsensors and sensors prog support for
Message-Id: <20060527234348.3eb60d9b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4470B176.5000703@hhs.nl>
In-Reply-To: <4470B176.5000703@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

> And the nescesarry userspace support.
> (...)
> I did this patch against 2.10.0 not CVS, sorry no time to redo it right
> now. I hope this is atleast good enough for a review and if the merging
> then gives troubles I rebase against CVS.

Here comes the review:

> --- lm_sensors-2.10.0/etc/sensors.conf.eg.uguru	2006-02-15 02:46:47.000000000 +0100
> +++ lm_sensors-2.10.0/etc/sensors.conf.eg	2006-05-19 10:07:36.000000000 +0200
> @@ -2527,3 +2527,190 @@
>     #set temp2_hyst  48
>     #set temp3_max   50
>     #set temp3_hyst  48
> +
> +
> +# Abit Uguru sensor part configuration.
> +# The Abit Uguru is relativly straight forward to configure.
> +# label statements:
> +# The voltage (in) temp and fan sensors are usualy in the same order as listed
> +# in the BIOS, but not always!
> +# compute statements:
> +# The temp and fan sensors don't need any compute statements. Most voltage
> +# inputs are directly connected to the IC and thus don't need an compute line
> +# because the 0-3494 mV voltage given by the kernel driver is correct. The sen-
> +# sors for higher voltages however are connect through a divider and measure
> +# ranges of: 0-4361mV, 0-6248mV or 0-14510mV. Thus the measured voltages must
> +# be multiplied by resp. 1.248, 1.788 or 4.153. 3.3 volt sources use the 1.248
> +# mutiplier, 5 volt the 1.788 and 12 volt the 4.153.
> +# set statements:
> +# The Abit BIOS sets reasonable treshholds and allows changing them, thus
> +# set statements may be ommited. The abituguru kernel driver does support
> +# them if you want to add them.
> +
> +# This part is common for all Abit uGuru motherboads currently known:
> +chip "abituguru-*"
> +
> +   label in0 "CPU Core Voltage"
> +   label in1 "DDR Voltage"
> +   label in2 "DDR VTT Voltage"
> +   label temp1 "CPU Temperature"
> +   label temp2 "SYS Temperature"
> +   label fan1 "CPU FAN Speed"
> +   label fan3 "SYS FAN Speed"
> +   ignore temp5
> +   ignore temp6
> +   ignore temp7
> +
> +# For Kv8Pro and AV8, this is enabled by default as this driver is
> +# developed and tested on a Kv8Pro, comment this if you don't have
> +# a Kv8Pro or AV8.
> +   label in3 "NB Voltage"
> +   label in4 "SB Voltage"
> +   label in5 "HyperTransport Voltage"
> +   label in6 "AGP VDDQ Voltage"
> +   label in7 "ATX +5V"
> +   compute in7 @*1.788 , @/1.788
> +   label in8 "ATX +3.3V"
> +   compute in8 @*1.248 , @/1.248
> +   label in9 "Standby Voltage (+5V)"
> +   compute in9 @*1.788 , @/1.788
> +   label in10 "3VDual Voltage"
> +   compute in10 @*1.248 , @/1.248
> +   label temp3 "PWM Temperature"
> +   ignore temp4
> +   label fan2 "NB FAN Speed"
> +   label fan4 "AUX1 FAN Speed"
> +   label fan5 "AUX2 FAN Speed"
> +   ignore fan6
> +
> +# For Aa7-Max and Ag7 uncomment this if you have one of these boards.
> +#   label in3 "ATX +12V"
> +#   compute in3 @*4.153 , @/4.153
> +#   label in4 "FSB VTT Voltage"
> +#   label in5 "NB Voltage"
> +#   label in6 "NB 2.5V Voltage"
> +#   label in7 "ATX +5V Voltage"
> +#   compute in7 @*1.788 , @/1.788
> +#   label in8 "ATX +3.3V Voltage"
> +#   compute in8 @*1.248 , @/1.248
> +#   label in9 "5VDual Voltage"
> +#   compute in9 @*1.788 , @/1.788
> +#   ignore in10
> +#   label temp3 "PWM1 Temperature"
> +#   label temp4 "PWM2 Temperature"
> +#   label fan2 "NB FAN Speed"
> +#   label fan4 "AUX1 FAN Speed"
> +#   label fan5 "AUX2 FAN Speed"
> +#   ignore fan6

Please only include one config example in the default configuration
file. We just can't include one configuration section for each
motherboard. You can make the other configuration files available (or
maybe post them to this list if you have nowhere to store them
publicly.)

> +
> +
> +# For AN8-SLI uncomment this if you have one of these boards.
> +#   label in3 "nForce4 Standby Voltage"
> +#   label in4 "CPU VDDA 2.5V Voltage"
> +#   label in5 "HyperTransport Voltage"
> +#   label in6 "nForce4 Voltage"
> +#   label in7 "ATX +5V"
> +#   compute in7 @*1.788 , @/1.788
> +#   label in8 "ATX +3.3V"
> +#   compute in8 @*1.248 , @/1.248
> +#   label in9 "ATX 5VSB Voltage"
> +#   compute in9 @*1.788 , @/1.788
> +#   label in10 "ATX +12V"
> +#   compute in10 @*4.153 , @/4.153
> +#   label temp3 "PWM Temperature"
> +#   ignore temp4
> +#   label fan2 "NF4 FAN Speed"
> +#   label fan4 "OTES1 FAN Speed"
> +#   label fan5 "OTES2 FAN Speed"
> +#   label fan6 "AUX FAN Speed"
> +
> +# For AX8 uncomment this if you have one of these boards.
> +#   label in3 "NB Voltage"
> +#   label in4 "SB Voltage"
> +#   label in5 "HyperTransport Voltage"
> +#   label in6 "ATX +5V"
> +#   compute in6 @*1.788 , @/1.788
> +#   label in7 "ATX +3.3V"
> +#   compute in7 @*1.248 , @/1.248
> +#   label in8 "Standby Voltage (+5V)"
> +#   compute in8 @*1.788 , @/1.788
> +#   label in9 "ATX +12V"
> +#   compute in9 @*4.153 , @/4.153
> +#   ignore in10
> +#   label temp3 "PWM Temperature"
> +#   ignore temp4
> +#   label fan2 "NB FAN Speed"
> +#   label fan4 "AUX FAN Speed"
> +#   ignore fan5
> +#   ignore fan6
> +
> +# For AA8XE Fatal1ty motherboard comment the label and ignore statements
> +# in the "common for all Abit uGuru motherboads" section above as that
> +# section is common to all motherboards except this very special motherboard.
> +# and uncomment this.      Author: Roger Lucas <roger at planbit.co.uk>
> +#   label in0 "DDR VTT Voltage"
> +#   label in1 "CPU Core Voltage"
> +#   label in2 "Unknown Voltage"
> +#   label in3 "DDR Voltage"
> +#   label in4 "NB Voltage"
> +#   label in5 "Unknown Voltage"
> +#   label in6 "FSB VTT Voltage"
> +#   label in7 "NB 2.5V Voltage"
> +#   label temp1 "CPU Temperature"
> +#   label temp2 "SYS Temperature"
> +#   label temp3 "PWM#1 Temperature"
> +#   label temp4 "PWM#2 Temperature"
> +#   label temp5 "PWM#3 Temperature"
> +#   label temp6 "PWM#4 Temperature"
> +#   label fan1 "CPU FAN Speed"
> +#   label fan2 "NB FAN Speed"
> +#   label fan3 "SYS FAN Speed"
> +#   label fan4 "OTES1 FAN Speed"
> +#   label fan5 "OTES2 FAN Speed"
> +#   ignore in8
> +#   ignore in9
> +#   ignore in10
> +#   ignore in11
> +#   ignore temp7
> +#   ignore fan6
> +
> +# The AA8XE Fatal1ty motherboard also contains a w83627hf which is used to
> +# measure the ATX power supply rails. Below is the correct config for this
> +# don't forget to uncomment the w83782d / w83627hf section above!
> +
> +# chip "w83782d-*" "w83627hf-*"
> +
> +#    ignore in0
> +#    ignore in1
> +#    label in2 "ATX +3.3V"
> +#    label in3 "ATX +5V"
> +#    label in4 "ATX +12V"
> +#    ignore in5
> +#    ignore in6
> +#    label in7 "Standby Voltage (+5V)"
> +#    ignore in8
> +
> +#    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
> +#    compute in4 ((28/10)+1)*@  ,  @/((28/10)+1)
> +#    compute in7 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
> +
> +#    set in2_min 3.3 * 0.95
> +#    set in2_max 3.3 * 1.05
> +#    set in3_min 5.0 * 0.95
> +#    set in3_max 5.0 * 1.05
> +#    set in4_min 12 * 0.90
> +#    set in4_max 12 * 1.10
> +#    set in7_min 5 * 0.95
> +#    set in7_max 5 * 1.05
> +
> +#    ignore fan1
> +#    ignore fan2
> +#    ignore fan3
> +
> +#    ignore temp1
> +#    ignore temp2
> +#    ignore temp3
> +
> +#    ignore vid
> +#    ignore alarms
> +#    ignore beep_enable
> --- lm_sensors-2.10.0/prog/sensors/chips.h.uguru	2006-02-15 02:46:49.000000000 +0100
> +++ lm_sensors-2.10.0/prog/sensors/chips.h	2006-05-19 10:07:36.000000000 +0200
> @@ -71,5 +71,6 @@
>  extern void print_adm1031(const sensors_chip_name *name);
>  extern void print_smsc47b397(const sensors_chip_name *name);
>  extern void print_f71805f(const sensors_chip_name *name);
> +extern void print_abituguru(const sensors_chip_name *name);
>  
>  #endif /* def PROG_SENSORS_CHIPS_H */
> --- lm_sensors-2.10.0/prog/sensors/chips.c.uguru	2006-02-15 02:46:49.000000000 +0100
> +++ lm_sensors-2.10.0/prog/sensors/chips.c	2006-05-19 11:23:39.000000000 +0200
> @@ -5851,6 +5851,119 @@
>    }
>  }
>  
> +/* print_abituguru_in()
> + *   where in, in_min, in_min_alarm, in_max and in_max_alarm are sensors
> + *   feature IDs
> + */
> +static void print_abituguru_in(const sensors_chip_name *name, int in,
> +  int in_min, int in_min_alarm, int in_max, int in_max_alarm)
> +{
> +  char *label = NULL;

Initialization isn't needed. Or you can make the free() call
unconditional, and keep the initialization, at your option. Same for
other functions.

> +  int valid;
> +
> +  if (!sensors_get_label_and_valid(*name,in,&label,&valid))
> +  {
> +    if (valid) {
> +      double cur, min, max, alarm_low, alarm_high;
> +      if (!sensors_get_feature(*name,in,&cur) &&
> +          !sensors_get_feature(*name,in_min,&min) &&
> +          !sensors_get_feature(*name,in_max,&max) &&
> +          !sensors_get_feature(*name,in_min_alarm, &alarm_low) &&
> +          !sensors_get_feature(*name,in_max_alarm, &alarm_high)) {
> +        print_label(label,23);
> +        printf("%+6.2f V (min %+6.2f V, max %+6.2f V)",
> +           cur, min, max);
> +        if (alarm_low || alarm_high) {
> +          printf(" ALARM (");
> +          if (alarm_low)
> +            printf("LOW");
> +          if (alarm_high)
> +            printf("%sHIGH",(alarm_low)?",":"");
> +          printf(")");
> +        }
> +        printf("\n");
> +      } else
> +        printf("ERROR: Can't get IN data! (0x%04x)\n", in);
> +    }
> +    free(label);
> +  }
> +}
> +
> +/* print_abituguru_temp()
> + * where temp, temp_alarm, temp_max, and temp_crit are sensors feature IDs
> + */
> +static void print_abituguru_temp(const sensors_chip_name *name, int temp,
> +	int temp_alarm, int temp_max, int temp_crit)
> +{
> +  char *label = NULL;
> +  int valid;
> +
> +  if (!sensors_get_label_and_valid(*name,temp,&label,&valid)) {
> +    if (valid) {
> +      double cur, alarm, max, crit;
> +      if (!sensors_get_feature(*name,temp,&cur) &&
> +          !sensors_get_feature(*name,temp_alarm,&alarm) &&
> +          !sensors_get_feature(*name,temp_max,&max) &&
> +          !sensors_get_feature(*name,temp_crit,&crit)) {
> +        if (fahrenheit) {
> +          cur  = deg_ctof(cur);
> +          max  = deg_ctof(max);
> +          crit = deg_ctof(crit);
> +        }
> +        print_label(label,23);
> +	printf("%+6.0f%s (max  %+5.0f%s, crit %+5.0f%s) %s\n",
> +	    cur, degstr, max, degstr, crit, degstr, alarm ? " ALARM" : "");

Please use print_temp_info instead, it'll take care of optional
conversion to degrees Fahrenheit for you.

> +      } else
> +        printf("ERROR: Can't get TEMP data! (0x%04x)\n", temp);
> +    }
> +    free(label);
> +  }
> +}
> +
> +/* print_abituguru_fan()
> + *   where fan, fan_alarm and fan_min are sensors feature IDs
> + */
> +static void print_abituguru_fan(const sensors_chip_name *name, int fan,
> +	int fan_alarm, int fan_min)
> +{
> +  char *label = NULL;
> +  double cur, alarm, min;
> +  int valid;
> +
> +  if (!sensors_get_label_and_valid(*name,fan,&label,&valid)) {
> +    if (valid) {
> +      if (!sensors_get_feature(*name,fan,&cur) &&
> +          !sensors_get_feature(*name,fan_alarm,&alarm) &&
> +          !sensors_get_feature(*name,fan_min,&min)) {
> +        print_label(label,23);
> +        printf("%4.0f RPM (min %4.0f RPM)               %s\n",
> +          cur, min, alarm ? "ALARM" : "");
> +      } else
> +        printf("ERROR: Can't get FAN data! (0x%04x)\n", fan);
> +    }
> +    free(label);
> +  }
> +}
> +
> +void print_abituguru(const sensors_chip_name *name)
> +{
> +  int i;
> +
> +  for (i=0;i<11;i++)
> +    print_abituguru_in(name, SENSORS_ABITUGURU_IN0 + i,
> +      SENSORS_ABITUGURU_IN0_MIN + i, SENSORS_ABITUGURU_IN0_MIN_ALARM + i,
> +      SENSORS_ABITUGURU_IN0_MAX + i, SENSORS_ABITUGURU_IN0_MAX_ALARM + i);
> +
> +  for (i=0;i<7;i++)
> +    print_abituguru_temp(name, SENSORS_ABITUGURU_TEMP1 + i,
> +      SENSORS_ABITUGURU_TEMP1_ALARM + i, SENSORS_ABITUGURU_TEMP1_MAX + i,
> +      SENSORS_ABITUGURU_TEMP1_CRIT + i);
> +
> +  for (i=0;i<6;i++)
> +    print_abituguru_fan(name, SENSORS_ABITUGURU_FAN1 + i,
> +      SENSORS_ABITUGURU_FAN1_ALARM + i, SENSORS_ABITUGURU_FAN1_MIN + i);
> +}
> +
>  void print_unknown_chip(const sensors_chip_name *name)
>  {
>    int a,b,valid;
> --- lm_sensors-2.10.0/prog/sensors/main.c.uguru	2006-02-15 02:46:49.000000000 +0100
> +++ lm_sensors-2.10.0/prog/sensors/main.c	2006-05-19 10:07:36.000000000 +0200
> @@ -414,6 +414,7 @@
>  	{ "lm93", print_lm93 },
>  	{ "smsc47b397", print_smsc47b397 },
>  	{ "f71805f", print_f71805f },
> + 	{ "abituguru", print_abituguru },
>  	{ NULL, NULL }
>  };
>  
> --- lm_sensors-2.10.0/lib/chips.h.uguru	2006-02-15 02:46:48.000000000 +0100
> +++ lm_sensors-2.10.0/lib/chips.h	2006-05-19 10:49:42.000000000 +0200
> @@ -2105,4 +2105,109 @@
>  #define SENSORS_F71805F_ALARMS_FAN	201
>  #define SENSORS_F71805F_ALARMS_TEMP	202
>  
> +/* Abit uGuru chip */
> +#define SENSORS_ABITUGURU_PREFIX "abituguru"
> +
> +#define SENSORS_ABITUGURU_IN0			0x01 /* R */
> +#define SENSORS_ABITUGURU_IN1			0x02 /* R */
> +#define SENSORS_ABITUGURU_IN2			0x03 /* R */
> +#define SENSORS_ABITUGURU_IN3			0x04 /* R */
> +#define SENSORS_ABITUGURU_IN4			0x05 /* R */
> +#define SENSORS_ABITUGURU_IN5			0x06 /* R */
> +#define SENSORS_ABITUGURU_IN6			0x07 /* R */
> +#define SENSORS_ABITUGURU_IN7			0x08 /* R */
> +#define SENSORS_ABITUGURU_IN8			0x09 /* R */
> +#define SENSORS_ABITUGURU_IN9			0x0A /* R */
> +#define SENSORS_ABITUGURU_IN10			0x0B /* R */
> +#define SENSORS_ABITUGURU_IN0_MIN		0x11 /* RW */
> +#define SENSORS_ABITUGURU_IN1_MIN		0x12 /* RW */
> +#define SENSORS_ABITUGURU_IN2_MIN		0x13 /* RW */
> +#define SENSORS_ABITUGURU_IN3_MIN		0x14 /* RW */
> +#define SENSORS_ABITUGURU_IN4_MIN		0x15 /* RW */
> +#define SENSORS_ABITUGURU_IN5_MIN		0x16 /* RW */
> +#define SENSORS_ABITUGURU_IN6_MIN		0x17 /* RW */
> +#define SENSORS_ABITUGURU_IN7_MIN		0x18 /* RW */
> +#define SENSORS_ABITUGURU_IN8_MIN		0x19 /* RW */
> +#define SENSORS_ABITUGURU_IN9_MIN		0x1A /* RW */
> +#define SENSORS_ABITUGURU_IN10_MIN		0x1B /* RW */
> +#define SENSORS_ABITUGURU_IN0_MIN_ALARM		0x21 /* R */
> +#define SENSORS_ABITUGURU_IN1_MIN_ALARM		0x22 /* R */
> +#define SENSORS_ABITUGURU_IN2_MIN_ALARM		0x23 /* R */
> +#define SENSORS_ABITUGURU_IN3_MIN_ALARM		0x24 /* R */
> +#define SENSORS_ABITUGURU_IN4_MIN_ALARM		0x25 /* R */
> +#define SENSORS_ABITUGURU_IN5_MIN_ALARM		0x26 /* R */
> +#define SENSORS_ABITUGURU_IN6_MIN_ALARM		0x27 /* R */
> +#define SENSORS_ABITUGURU_IN7_MIN_ALARM		0x28 /* R */
> +#define SENSORS_ABITUGURU_IN8_MIN_ALARM		0x29 /* R */
> +#define SENSORS_ABITUGURU_IN9_MIN_ALARM		0x2A /* R */
> +#define SENSORS_ABITUGURU_IN10_MIN_ALARM	0x2B /* R */
> +#define SENSORS_ABITUGURU_IN0_MAX		0x31 /* RW */
> +#define SENSORS_ABITUGURU_IN1_MAX		0x32 /* RW */
> +#define SENSORS_ABITUGURU_IN2_MAX		0x33 /* RW */
> +#define SENSORS_ABITUGURU_IN3_MAX		0x34 /* RW */
> +#define SENSORS_ABITUGURU_IN4_MAX		0x35 /* RW */
> +#define SENSORS_ABITUGURU_IN5_MAX		0x36 /* RW */
> +#define SENSORS_ABITUGURU_IN6_MAX		0x37 /* RW */
> +#define SENSORS_ABITUGURU_IN7_MAX		0x38 /* RW */
> +#define SENSORS_ABITUGURU_IN8_MAX		0x39 /* RW */
> +#define SENSORS_ABITUGURU_IN9_MAX		0x3A /* RW */
> +#define SENSORS_ABITUGURU_IN10_MAX		0x3B /* RW */
> +#define SENSORS_ABITUGURU_IN0_MAX_ALARM		0x41 /* R */
> +#define SENSORS_ABITUGURU_IN1_MAX_ALARM		0x42 /* R */
> +#define SENSORS_ABITUGURU_IN2_MAX_ALARM		0x43 /* R */
> +#define SENSORS_ABITUGURU_IN3_MAX_ALARM		0x44 /* R */
> +#define SENSORS_ABITUGURU_IN4_MAX_ALARM		0x45 /* R */
> +#define SENSORS_ABITUGURU_IN5_MAX_ALARM		0x46 /* R */
> +#define SENSORS_ABITUGURU_IN6_MAX_ALARM		0x47 /* R */
> +#define SENSORS_ABITUGURU_IN7_MAX_ALARM		0x48 /* R */
> +#define SENSORS_ABITUGURU_IN8_MAX_ALARM		0x49 /* R */
> +#define SENSORS_ABITUGURU_IN9_MAX_ALARM		0x4A /* R */
> +#define SENSORS_ABITUGURU_IN10_MAX_ALARM	0x4B /* R */
> +#define SENSORS_ABITUGURU_TEMP1			0x51 /* R */
> +#define SENSORS_ABITUGURU_TEMP2			0x52 /* R */
> +#define SENSORS_ABITUGURU_TEMP3			0x53 /* R */
> +#define SENSORS_ABITUGURU_TEMP4			0x54 /* R */
> +#define SENSORS_ABITUGURU_TEMP5			0x56 /* R */
> +#define SENSORS_ABITUGURU_TEMP6			0x56 /* R */
> +#define SENSORS_ABITUGURU_TEMP7			0x57 /* R */
> +#define SENSORS_ABITUGURU_TEMP1_ALARM		0x61 /* R */
> +#define SENSORS_ABITUGURU_TEMP2_ALARM		0x62 /* R */
> +#define SENSORS_ABITUGURU_TEMP3_ALARM		0x63 /* R */
> +#define SENSORS_ABITUGURU_TEMP4_ALARM		0x64 /* R */
> +#define SENSORS_ABITUGURU_TEMP5_ALARM		0x65 /* R */
> +#define SENSORS_ABITUGURU_TEMP6_ALARM		0x66 /* R */
> +#define SENSORS_ABITUGURU_TEMP7_ALARM		0x67 /* R */
> +#define SENSORS_ABITUGURU_TEMP1_MAX		0x71 /* RW */
> +#define SENSORS_ABITUGURU_TEMP2_MAX		0x72 /* RW */
> +#define SENSORS_ABITUGURU_TEMP3_MAX		0x73 /* RW */
> +#define SENSORS_ABITUGURU_TEMP4_MAX		0x74 /* RW */
> +#define SENSORS_ABITUGURU_TEMP5_MAX		0x75 /* RW */
> +#define SENSORS_ABITUGURU_TEMP6_MAX		0x76 /* RW */
> +#define SENSORS_ABITUGURU_TEMP7_MAX		0x77 /* RW */
> +#define SENSORS_ABITUGURU_TEMP1_CRIT		0x81 /* RW */
> +#define SENSORS_ABITUGURU_TEMP2_CRIT		0x82 /* RW */
> +#define SENSORS_ABITUGURU_TEMP3_CRIT		0x83 /* RW */
> +#define SENSORS_ABITUGURU_TEMP4_CRIT		0x84 /* RW */
> +#define SENSORS_ABITUGURU_TEMP5_CRIT		0x85 /* RW */
> +#define SENSORS_ABITUGURU_TEMP6_CRIT		0x86 /* RW */
> +#define SENSORS_ABITUGURU_TEMP7_CRIT		0x87 /* RW */
> +#define SENSORS_ABITUGURU_FAN1			0x91 /* R */
> +#define SENSORS_ABITUGURU_FAN2			0x92 /* R */
> +#define SENSORS_ABITUGURU_FAN3			0x93 /* R */
> +#define SENSORS_ABITUGURU_FAN4			0x94 /* R */
> +#define SENSORS_ABITUGURU_FAN5			0x95 /* R */
> +#define SENSORS_ABITUGURU_FAN6			0x96 /* R */
> +#define SENSORS_ABITUGURU_FAN1_ALARM		0xA1 /* R */
> +#define SENSORS_ABITUGURU_FAN2_ALARM		0xA2 /* R */
> +#define SENSORS_ABITUGURU_FAN3_ALARM		0xA3 /* R */
> +#define SENSORS_ABITUGURU_FAN4_ALARM		0xA4 /* R */
> +#define SENSORS_ABITUGURU_FAN5_ALARM		0xA5 /* R */
> +#define SENSORS_ABITUGURU_FAN6_ALARM		0xA6 /* R */
> +#define SENSORS_ABITUGURU_FAN1_MIN		0xB1 /* RW */
> +#define SENSORS_ABITUGURU_FAN2_MIN		0xB2 /* RW */
> +#define SENSORS_ABITUGURU_FAN3_MIN		0xB3 /* RW */
> +#define SENSORS_ABITUGURU_FAN4_MIN		0xB4 /* RW */
> +#define SENSORS_ABITUGURU_FAN5_MIN		0xB5 /* RW */
> +#define SENSORS_ABITUGURU_FAN6_MIN		0xB6 /* RW */

Please use macros instead. You already use the fact that the numbers
are sequential, so better make it clearer so that a future change
doesn't break it. See the Fintek F71805F section for example.

> +
>  #endif /* def LIB_SENSORS_CHIPS_H */
> --- lm_sensors-2.10.0/lib/chips.c.uguru	2006-02-15 02:46:48.000000000 +0100
> +++ lm_sensors-2.10.0/lib/chips.c	2006-05-19 11:02:07.000000000 +0200
> @@ -5556,6 +5556,75 @@
>  	{ 0 }
>  };
>  
> +#define SENSORS_ABITUGURU_IN(nr) \
> +	{ SENSORS_ABITUGURU_IN##nr, "in" #nr, NOMAP, NOMAP, R, 0, \
> +		VALUE(3), 3 }, \
> +	{ SENSORS_ABITUGURU_IN##nr##_MIN, "in" #nr "_min", \
> +		SENSORS_ABITUGURU_IN##nr, SENSORS_ABITUGURU_IN##nr, RW, 0, \
> +		VALUE(1), 3 }, \
> +	{ SENSORS_ABITUGURU_IN##nr##_MIN_ALARM, "in" #nr "_min_alarm", \
> +		SENSORS_ABITUGURU_IN##nr, NOMAP, R, 0, \
> +		VALUE(4), 0 }, \
> +	{ SENSORS_ABITUGURU_IN##nr##_MAX, "in" #nr "_max", \
> +		SENSORS_ABITUGURU_IN##nr, SENSORS_ABITUGURU_IN##nr, RW, 0, \
> +		VALUE(2), 3 }, \
> +	{ SENSORS_ABITUGURU_IN##nr##_MAX_ALARM, "in" #nr "_max_alarm", \
> +		SENSORS_ABITUGURU_IN##nr, NOMAP, R, 0, \
> +		VALUE(5), 0 }

Please use NOSYSCTL instead of hardcoded 0 for .sysctl field.

If a 2.4 driver was ever written, the alarms would be in a separate
procfs file, so please use VALUE(1) and VALUE(2) instead of VALUE(4)
and VALUE(5), respectively.

Both comments apply to the other arrays below too, of course.

> +
> +#define SENSORS_ABITUGURU_TEMP(nr) \
> +	{ SENSORS_ABITUGURU_TEMP##nr, "temp" #nr, NOMAP, NOMAP, R, 0, \
> +		VALUE(3), 3 }, \
> +	{ SENSORS_ABITUGURU_TEMP##nr##_ALARM, "temp" #nr "_alarm", \
> +		SENSORS_ABITUGURU_TEMP##nr, NOMAP, R, 0, \
> +		VALUE(4), 0 }, \
> +	{ SENSORS_ABITUGURU_TEMP##nr##_MAX, "temp" #nr "_max", \
> +		SENSORS_ABITUGURU_TEMP##nr, SENSORS_ABITUGURU_TEMP##nr, RW, 0, \
> +		VALUE(1), 3 }, \
> +	{ SENSORS_ABITUGURU_TEMP##nr##_CRIT, "temp" #nr "_crit", \
> +		SENSORS_ABITUGURU_TEMP##nr, SENSORS_ABITUGURU_TEMP##nr, RW, 0, \
> +		VALUE(2), 3 }
> +
> +#define SENSORS_ABITUGURU_FAN(nr) \
> +	{ SENSORS_ABITUGURU_FAN##nr, "fan" #nr, NOMAP, NOMAP, R, 0, \
> +		VALUE(2), 0 }, \
> +	{ SENSORS_ABITUGURU_FAN##nr##_ALARM, "fan" #nr "_alarm", \
> +		SENSORS_ABITUGURU_FAN##nr, NOMAP, R, 0, \
> +		VALUE(3), 0 }, \
> +	{ SENSORS_ABITUGURU_FAN##nr##_MIN, "fan" #nr "_min", \
> +		SENSORS_ABITUGURU_FAN##nr, SENSORS_ABITUGURU_FAN##nr, RW, 0, \
> +		VALUE(1), 0 }
> +
> +static sensors_chip_feature abituguru_features[] > +{
> +	SENSORS_ABITUGURU_IN(0),
> +	SENSORS_ABITUGURU_IN(1),
> +	SENSORS_ABITUGURU_IN(2),
> +	SENSORS_ABITUGURU_IN(3),
> +	SENSORS_ABITUGURU_IN(4),
> +	SENSORS_ABITUGURU_IN(5),
> +	SENSORS_ABITUGURU_IN(6),
> +	SENSORS_ABITUGURU_IN(7),
> +	SENSORS_ABITUGURU_IN(8),
> +	SENSORS_ABITUGURU_IN(9),
> +	SENSORS_ABITUGURU_IN(10),
> +	SENSORS_ABITUGURU_TEMP(1),
> +	SENSORS_ABITUGURU_TEMP(2),
> +	SENSORS_ABITUGURU_TEMP(3),
> +	SENSORS_ABITUGURU_TEMP(4),
> +	SENSORS_ABITUGURU_TEMP(5),
> +	SENSORS_ABITUGURU_TEMP(6),
> +	SENSORS_ABITUGURU_TEMP(7),
> +	SENSORS_ABITUGURU_FAN(1),
> +	SENSORS_ABITUGURU_FAN(2),
> +	SENSORS_ABITUGURU_FAN(3),
> +	SENSORS_ABITUGURU_FAN(4),
> +	SENSORS_ABITUGURU_FAN(5),
> +	SENSORS_ABITUGURU_FAN(6),
> +	{ 0 }
> +};
> +
> +
>  sensors_chip_features sensors_chip_features_list[] >  {
>   { SENSORS_LM78_PREFIX, lm78_features },
> @@ -5656,5 +5725,6 @@
>   { SENSORS_LM93_PREFIX, lm93_features },
>   { SENSORS_SMSC47B397_PREFIX, smsc47b397_features },
>   { SENSORS_F71805F_PREFIX, f71805f_features },
> + { SENSORS_ABITUGURU_PREFIX, abituguru_features },
>   { 0 }
>  };
> 

Thanks,
-- 
Jean Delvare

