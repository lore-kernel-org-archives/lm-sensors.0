From: dwkemp@iinet.net.au (Dale Kemp)
Date: Thu, 19 May 2005 06:25:18 +0000
Subject: Gigabyte GA-8IPE1000-G
Message-Id: <4161390E.1070004@iinet.net.au>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello <LM-Sensors Team>,

I'm not sure who/where to send this but I've figured out most of the
sensors config for a Gigabyte GA-8IPE1000-G motherboard.  It should
be correct for all GA-8IPE1000 models too.

Example output:

sensors
it87-isa-0290
Adapter: ISA adapter
VCore:     +1.49 V  (min =  +1.41 V, max =  +1.55 V)
DDR:       +2.58 V  (min =  +2.37 V, max =  +2.62 V)
+3.3V:     +3.31 V  (min =  +3.14 V, max =  +3.47 V)
+5V:       +5.02 V  (min =  +4.74 V, max =  +5.25 V)
+12V:     +11.97 V  (min = +11.39 V, max = +12.61 V)
-12V:     -12.10 V  (min = -12.61 V, max = -11.46 V)
-5V:       -5.01 V  (min =  -5.26 V, max =  -4.75 V)
VBat:      +4.08 V
CPU Fan:  1394 RPM  (min =    0 RPM, div = 8)
 NB Fan:     0 RPM  (min =    0 RPM, div = 8)
SYS Fan:     0 RPM  (min =    0 RPM, div = 8)
CPU Temp:    +30 C  (low  =  +127 C, high =   +65 C)   sensor = diode


Hope this helps with the lm-sensors project.

Best Regards,
Dale.

-- 
sig=0xda1e;

-------------- next part --------------
# Sensors configuration file used by 'libsensors'
#------------------------------------------------

# May need to run 'sensors -s' as root to get effect.

chip "it87-isa-0290"
# As used in the Gigabyte GA-8IPE1000-G (865,IC5 chipsets)

    label in0 "VCore"
    label in1 "DDR"
    label in2 "+3.3V"
    label in3 "+5V"
    label in4 "+12V"
    label in5 "-12V"
    label in6 "-5V"
    label in7 "Stdby"
    label in8 "VBat"

    set in0_min 1.475 * 0.95
    set in0_max 1.475 * 1.05
    # Core could be 2V not 2.5V for older DDR?
    set in1_min 2.5 * 0.95
    set in1_max 2.5 * 1.05
    set in2_min 3.3 * 0.95
    set in2_max 3.3 * 1.05
    set in3_min 5.0 * 0.95
    set in3_max 5.0 * 1.05
    set in4_min 12 * 0.95
    set in4_max 12 * 1.05
    set in5_max -12 * 0.95
    set in5_min -12 * 1.05
    set in6_max -5 * 0.95
    set in6_min -5 * 1.05
    # Stby fluctuates when system is running, so all
    # we can do is see if the values arn't too out :-(
    set in7_min 5 * 0.95
    set in7_max 5 * 1.05
    ignore in7
    #the chip does not support in8 min/max

    ignore  vid

    ignore temp1
    ignore temp2
    label temp3       "CPU Temp"
    set temp3_over 65
    #set temp3_hyst 55

    label fan1	"CPU Fan"
    label fan2	" NB Fan"
    label fan3	"SYS Fan"

    compute in0 (1)*@ ,  @/(1)
    compute in1 (1)*@ ,  @/(1)
    compute in2 (1)*@ ,  @/(1)
    compute in3 (2)*@ ,  @/(2)
    compute in4 (4)*@ ,  @/(4)
    compute in5 (8*@)-24 ,  (@+24)/8
    compute in6 (4*@)-10 ,  (@+10)/4
    compute in7 1*@, @/1
    compute in8 1*@, @/1
