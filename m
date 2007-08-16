From: =?iso-8859-1?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Date: Thu, 16 Aug 2007 13:57:00 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/lm93: Documentation fixes
Message-Id: <200708161557.00366.hjk@linutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070816144849.2b2c2471@hyperion.delvare>
In-Reply-To: <20070816144849.2b2c2471@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Donnerstag 16 August 2007 14:48 schrieb Jean Delvare:
> Hi Hans,
> 
> Here are proposed changes and fixes to the lm93 documentation.

Looks alright to me. Thanks for your help!

> 
> * Drop documentation of generic module parameters.
> * Drop redundant section "Driver Description".
> * Drop sample configuration section, it belongs to sensors.conf.eg.
> * Random spelling and punctuation fixes.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>

Acked-by: Hans J. Koch <hjk@linutronix.de>

> ---
>  Documentation/hwmon/lm93 |  126 ++--------------------------------------------
>  1 file changed, 8 insertions(+), 118 deletions(-)
> 
> --- linux-2.6.23-rc3.orig/Documentation/hwmon/lm93	2007-07-23 16:44:32.000000000 +0200
> +++ linux-2.6.23-rc3/Documentation/hwmon/lm93	2007-08-16 14:43:00.000000000 +0200
> @@ -7,7 +7,7 @@ Supported chips:
>      Addresses scanned: I2C 0x2c-0x2e
>      Datasheet: http://www.national.com/ds.cgi/LM/LM93.pdf
>  
> -Author:
> +Authors:
>  	Mark M. Hoffman <mhoffman@lightlink.com>
>  	Ported to 2.6 by Eric J. Bowersox <ericb@aspsys.com>
>  	Adapted to 2.6.20 by Carsten Emde <ce@osadl.org>
> @@ -16,7 +16,6 @@ Author:
>  Module Parameters
>  -----------------
>  
> -(specific to LM93)
>  * init: integer
>    Set to non-zero to force some initializations (default is 0).
>  * disable_block: integer
> @@ -37,30 +36,13 @@ Module Parameters
>    I.e. this parameter controls the VID pin input thresholds; if your VID
>    inputs are not working, try changing this.  The default value is "0".
>  
> -(common among sensor drivers)
> -* force: short array (min = 1, max = 48)
> -  List of adapter,address pairs to assume to be present.  Autodetection
> -  of the target device will still be attempted.  Use one of the more
> -  specific force directives below if this doesn't detect the device.
> -* force_lm93: short array (min = 1, max = 48)
> -  List of adapter,address pairs which are unquestionably assumed to contain
> -  a 'lm93' chip
> -* ignore: short array (min = 1, max = 48)
> -  List of adapter,address pairs not to scan
> -* ignore_range: short array (min = 1, max = 48)
> -  List of adapter,start-addr,end-addr triples not to scan
> -* probe: short array (min = 1, max = 48)
> -  List of adapter,address pairs to scan additionally
> -* probe_range: short array (min = 1, max = 48)
> -  List of adapter,start-addr,end-addr triples to scan additionally
> -
>  
>  Hardware Description
>  --------------------
>  
>  (from the datasheet)
>  
> -The LM93, hardware monitor, has a two wire digital interface compatible with
> +The LM93 hardware monitor has a two wire digital interface compatible with
>  SMBus 2.0. Using an 8-bit ADC, the LM93 measures the temperature of two remote
>  diode connected transistors as well as its own die and 16 power supply
>  voltages. To set fan speed, the LM93 has two PWM outputs that are each
> @@ -69,18 +51,12 @@ table based. The LM93 includes a digital
>  temperature readings for better control of fan speed. The LM93 has four
>  tachometer inputs to measure fan speed. Limit and status registers for all
>  measured values are included. The LM93 builds upon the functionality of
> -previous motherboard management ASICs and uses some of the LM85 s features
> +previous motherboard management ASICs and uses some of the LM85's features
>  (i.e. smart tachometer mode). It also adds measurement and control support
>  for dynamic Vccp monitoring and PROCHOT. It is designed to monitor a dual
>  processor Xeon class motherboard with a minimum of external components.
>  
>  
> -Driver Description
> -------------------
> -
> -This driver implements support for the National Semiconductor LM93.
> -
> -
>  User Interface
>  --------------
>  
> @@ -101,7 +77,7 @@ These intervals can be found in the sysf
>  prochot2_interval.  The values in these files specify the intervals for
>  #P1_PROCHOT and #P2_PROCHOT, respectively.  Selecting a value not in this
>  list will cause the driver to use the next largest interval.  The available
> -intervals are:
> +intervals are (in seconds):
>  
>  #PROCHOT intervals: 0.73, 1.46, 2.9, 5.8, 11.7, 23.3, 46.6, 93.2, 186, 372
>  
> @@ -111,12 +87,12 @@ assert #P2_PROCHOT, and vice-versa.  Thi
>  non-zero integer to the sysfs file prochot_short.
>  
>  The LM93 can also override the #PROCHOT pins by driving a PWM signal onto
> -one or both of them.  When overridden, the signal has a period of 3.56 mS,
> +one or both of them.  When overridden, the signal has a period of 3.56 ms,
>  a minimum pulse width of 5 clocks (at 22.5kHz => 6.25% duty cycle), and
>  a maximum pulse width of 80 clocks (at 22.5kHz => 99.88% duty cycle).
>  
>  The sysfs files prochot1_override and prochot2_override contain boolean
> -intgers which enable or disable the override function for #P1_PROCHOT and
> +integers which enable or disable the override function for #P1_PROCHOT and
>  #P2_PROCHOT, respectively.  The sysfs file prochot_override_duty_cycle
>  contains a value controlling the duty cycle for the PWM signal used when
>  the override function is enabled.  This value ranges from 0 to 15, with 0
> @@ -166,7 +142,7 @@ frequency values are constrained by the 
>  not available will cause the driver to use the next largest value.  Also note
>  that this parameter has implications for the Smart Tach Mode (see above).
>  
> -PWM Output Frequencies: 12, 36, 48, 60, 72, 84, 96, 22500 (h/w default)
> +PWM Output Frequencies (in Hz): 12, 36, 48, 60, 72, 84, 96, 22500 (default)
>  
>  Automatic PWM:
>  
> @@ -178,7 +154,7 @@ individual control sources to which the 
>  The eight control sources are: temp1-temp4 (aka "zones" in the datasheet),
>  #PROCHOT 1 & 2, and #VRDHOT 1 & 2.  The bindings are expressed as a bitmask
>  in the sysfs files pwm<n>_auto_channels, where a "1" enables the binding, and
> - a "0" disables it. The h/w default is 0x0f (all temperatures bound).
> +a "0" disables it. The h/w default is 0x0f (all temperatures bound).
>  
>  	0x01 - Temp 1
>  	0x02 - Temp 2
> @@ -324,89 +300,3 @@ LM93 Unique sysfs Files
>  
>  	gpio			input state of 8 GPIO pins; read-only
>  
> -
> -Sample Configuration File
> --------------------------
> -
> -Here is a sample LM93 chip config for sensors.conf:
> -
> ----------- cut here ----------
> -chip "lm93-*"
> -
> -# VOLTAGE INPUTS
> -
> -	# labels and scaling based on datasheet recommendations
> -	label in1	"+12V1"
> -	compute in1	@ * 12.945, @ / 12.945
> -	set in1_min	12 * 0.90
> -	set in1_max	12 * 1.10
> -
> -	label in2	"+12V2"
> -	compute in2	@ * 12.945, @ / 12.945
> -	set in2_min	12 * 0.90
> -	set in2_max	12 * 1.10
> -
> -	label in3	"+12V3"
> -	compute in3	@ * 12.945, @ / 12.945
> -	set in3_min	12 * 0.90
> -	set in3_max	12 * 1.10
> -
> -	label in4	"FSB_Vtt"
> -
> -	label in5	"3GIO"
> -
> -	label in6	"ICH_Core"
> -
> -	label in7	"Vccp1"
> -
> -	label in8	"Vccp2"
> -
> -	label in9	"+3.3V"
> -	set in9_min	3.3 * 0.90
> -	set in9_max	3.3 * 1.10
> -
> -	label in10	"+5V"
> -	set in10_min	5.0 * 0.90
> -	set in10_max	5.0 * 1.10
> -
> -	label in11	"SCSI_Core"
> -
> -	label in12	"Mem_Core"
> -
> -	label in13	"Mem_Vtt"
> -
> -	label in14	"Gbit_Core"
> -
> -	# Assuming R1/R2 = 4.1143, and 3.3V reference
> -	# -12V = (4.1143 + 1) * (@ - 3.3) + 3.3
> -	label in15	"-12V"
> -	compute in15 @ * 5.1143 - 13.57719, (@ + 13.57719) / 5.1143
> -	set in15_min	-12 * 0.90
> -	set in15_max	-12 * 1.10
> -
> -	label in16	"+3.3VSB"
> -	set in16_min	3.3 * 0.90
> -	set in16_max	3.3 * 1.10
> -
> -# TEMPERATURE INPUTS
> -
> -	label temp1	"CPU1"
> -	label temp2	"CPU2"
> -	label temp3	"LM93"
> -
> -# TACHOMETER INPUTS
> -
> -	label fan1	"Fan1"
> -	set fan1_min	3000
> -	label fan2	"Fan2"
> -	set fan2_min	3000
> -	label fan3	"Fan3"
> -	set fan3_min	3000
> -	label fan4	"Fan4"
> -	set fan4_min	3000
> -
> -# PWM OUTPUTS
> -
> -	label pwm1	"CPU1"
> -	label pwm2	"CPU2"
> -
> 
> 
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
