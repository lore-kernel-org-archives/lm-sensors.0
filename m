From: Zeke Fast <zekefast@gmail.com>
Date: Sun, 12 Jan 2014 12:53:04 +0000
Subject: [lm-sensors] Configuration to place in Wiki for motherboards GA-A870-UD3 and GA-A870-USB3
Message-Id: <1389531184.16038.6.camel@zf-mws>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello everybody,

I have no Trac account, but would like to place configuration example
for Gigabyte motherboards models: GA-A870-UD3, GA-A870-USB3.

Provided configuration was originally found by another guy in his
post(http://www.spinics.net/lists/lm-sensors/msg32751.html) for
GA-A870-UD3 model, but I tested this configuration on my GA-A870-USB3
and it works pretty good as well.

Here is an exact configuration:

# libsensors3 configuration file for the Gigabyte GA-870A-UD3 rev 3.0
# based on configuration file for the Gigabyte GA-790XTA-UD4 from Wiki with modifications.
# 2011-06-16 Gary Myers <gary@xxxxxxxxxxxxxx>
# Updates welcome.

# CPU sensor

chip "k10temp-*"

   label temp1 "CPU Temp (K10)" # Set for gnome-sensors-applet.
				# See second CPU temp below.

# Motherboard sensors

chip "it8720-isa-*"

### Voltages

   label  in0  "Vcore"
   label  in1  "DDR3 1.5V" # as labelled in the BIOS.
   label  in2  "+3.3V"
   label  in3  "+5V"     # Not shown in BIOS.
   label  in4  "+12V"
   ignore in5		 # Ambiguous - ignoring.
   ignore in6		 # Ambiguous - ignoring.
   label  in7  "5VSB"    # Not shown in BIOS.
   label  in8  "Vbat"    # Not shown in BIOS.
   ignore cpu0_vid

   # "Vcore", "DDR3 1.5V", "+3.3V" and "Vbat" are connected directly, so no compute
   # line is needed for these. +5V and 5VSB are internal so we use the
   # standard scaling factor. Scaling for +12V is apparently not standard,
   # factor 3.963 is guessed from BIOS and EasyTune values (3.943 was
   # another candidate.)
   compute  in3  @ * (6.8/10+1), @ / (6.8/10+1)
   compute  in4  @ * 3.963,      @ / 3.963
   compute  in7  @ * (6.8/10+1), @ / (6.8/10+1)

   # The BIOS will not set any limit for voltages.

   set in0_min  0.825 * 0.95
   set in0_max  1.425 * 1.05
   set in1_min  1.5   * 0.95
   set in1_max  1.5   * 1.05
   set in2_min  3.3   * 0.95
   set in2_max  3.3   * 1.05
   set in3_min  5     * 0.95
   set in3_max  5     * 1.05
   set in4_min 12     * 0.95
   set in4_max 12     * 1.05
   set in7_min  5     * 0.95
   set in7_max  5     * 1.05

### Temperatures

   label temp1 "System Temp"
   # This sensor appears to be around or inside the ITE8720F chip.
   # The temperature drops if the chip and board area are cooled with
   # freezer spray. This sensor may be over-reading!
   # Adjustment applied to match internal case thermal sensor from my Antec P160.
   compute temp1  (@ -20),  (@ + 20)
   set   temp1_min 0
   set   temp1_max 50 # Tropical ambient max plus a bit

   label temp2  "CPU Temp"
   # This sensor can show 2 degrees difference to the K10 sensor.
   # The end user can choose which one they prefer.
   set   temp2_min 0
   set   temp2_max 70 # Set to match your BIOS "CPU Warning Temperature"

   ignore temp3	# No idea what this sensor is for. It always shows
		# +78 deg C regardless of BIOS settings.

### Fans

   # Label based on motherboard connectors.
   label fan1 "CPU Fan"		# M/B label: CPU_FAN (4-pin - near ATX 12V)
   label fan5 "Power Fan"	# M/B label: PWR_FAN (3-pin - near ATX)
   label fan2 "System Fan 1"	# M/B label: SYS_FAN1 (4-pin - near F_PANEL)
   label fan3 "System Fan 2"	# M/B label: SYS_FAN2 (3-pin - near SATA3_4)

   # Minimum fan speeds.
   # Comment/un-comment fan headers you are using if you want alarms.
   set fan1_min 300	# CPU Fan
   set fan5_min 300	# Power Fan
   #set fan2_min 300	# System Fan 1
   set fan3_min 300	# System Fan 2


-- 

________________________________________________________________________
Kind regards,
Zeke Fast





_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
