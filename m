From: alext@uazone.net (Alex Tkachenko)
Date: Thu, 19 May 2005 06:25:24 +0000
Subject: Strange beeping behaviour
Message-Id: <1101640549.14912.31.camel@acheron.uasite.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings!

Could you please help me to solve my problem?

I have an Asustek A7V motherboard. The system runs Fedora Core 3, which
has 2.6.9 kernel with whatever was backported on top of that and I also
installed lm_sensors 2.8.8 to address my vid readings issue. With this
setup the sensors work great, providing quite accurate
readings/controls, but my problem is with alarms. Basically it seems to
me that once any alarm is triggered, motherboard starts beeping (which
is good), but when the value gets back into the valid range (and alarm
is not shown in the sensors output anymore) motherboard still keeps
beeping. If I modify the beep_mask to stop watching the value in
question, the beep stops. Same if I disable beeping globally. But the
moment I modify the mask to include that value back and/or set
beep_enable=1, the mobo starts beeping again, even if there is no
currently an alarm triggered for this value.

I understand that the asustek chipset is in beta if ever supported, but
otherwise it works great so I was wondering if the native winbond
behaves the same way.

Besides, what I can't understand, what is actually causing this
continuous beeping - the bug in software or hardware - it looks like the
software can stop the beeping if I manipulate the mask, and there is no
alarm reported (at least through the sysfs interface) so why this damn
things keeps beeping?

Below please find the relevant portion of sensors.conf file and sensors
output. Please let me know if I could provide anything else.

chip "as99127f-*"

# alext@uazone.net: this entry has been modified to suite my AsusTek A7V
# (single power plane, no temp3, no fan3

# Asus won't release a datasheet so this is guesswork.
# Thanks to Guntram Blohm, Jack, Ed Harrison, Artur Gawryszczak,
# Victor G. Marimon and others for their feedback.

# Dual power plane
#    label in0 "VCore 1"
#    label in1 "VCore 2"
# Single power plane (A7V133, A7M266)
   label in0 "VCore"
   ignore in1

    label in2 "+3.3V"
    label in3 "+5V"
    label in4 "+12V"
# These last two may not make sense on all motherboards.
    label in5 "-12V"
    label in6 "-5V"

    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    compute in4 ((28/10)+1)*@  ,  @/((28/10)+1)
# AS99127F rev.1 (same as w83781d)
    compute in5 -(240/60.4)*@ ,  -@/(240/60.4)
    compute in6 -(90.9/60.4)*@ ,  -@/(90.9/60.4)
# AS99127F rev.2 (same as w83782d)
#   compute in5 (5.14 * @) - 14.91 , (@ + 14.91) / 5.14
#   compute in6 (3.14 * @) -  7.71 , (@ +  7.71) / 3.14

# Depending on your motherboard, you have to choose between three formulae
# for temp2. Quoting Artur Gawryszczak:
# "I guess, that the formula "temp2 (@*30/43)+25, (@-25)*43/30" is correct
# for those Asus motherboards, which get CPU temperature from internal
# thermal diode (Pentium Coppermine, and above), and "temp2 @*2.0, @/2.0"
# is correct for Athlon/Duron boards, which use a thermistor in the
# socket."
# The third formula was found and reported by Victor G. Marimon.
# Asus CUV4X, Asus A7V8X
#   compute temp2 (@*30/43)+25, (@-25)*43/30
# Asus A7V133, Asus A7M266
    compute temp2 @*2.0, @/2.0
# Asus CUSL2, Asus CUV266-DLS
#   compute temp2 (@*60/43)+25, (@-25)*43/60

# See comments above if temp3 looks bad. What works for temp2 is likely
# to work for temp3.
#    compute temp3 @*2.0, @/2.0

# Most Asus boards have temperatures settled like that:
    label temp1 "M/B Temp"
    label temp2 "CPU Temp"
# However, some A7N8X boards (Deluxe rev.2, -X) have them swapped:
#   label temp1 "CPU Temp"
#   label temp2 "M/B Temp"
# If you know other boards where they are swapped, let us know and
# we'll update the list.

# adjust this if your vid is wrong; see doc/vid
#   set vrm 9.0

# set limits to  5% for the critical voltages
# set limits to 10% for the non-critical voltages
# set limits to 20% for the battery voltage

    set in0_min vid*0.95
    set in0_max vid*1.05

# alex@uazone.net: in1 is ignored anyway, but provide some ranges to
# prevent an alarm from being triggered
#    set in1_min vid*0.95
#    set in1_max vid*1.05
    set in1_min 0.07
    set in1_max 0.15

    set in2_min 3.3 * 0.95
    set in2_max 3.3 * 1.05
    set in3_min 5.0 * 0.95
    set in3_max 5.0 * 1.05
    set in4_min 12 * 0.90
    set in4_max 12 * 1.10
    set in5_max -12 * 0.90
    set in5_min -12 * 1.10
    set in6_max -5 * 0.95
    set in6_min -5 * 1.05

# examples for temperature limits
#    set temp1_over 40
#    set temp1_hyst 37
#    set temp2_over 52
#    set temp2_hyst 47
#    set temp3_over 52
#    set temp3_hyst 47

# The A7N8X-X board is known to need this:
# (reported by Roberto Sebastiano <robs@multiplayer.it>)
#    compute fan1  @/2,  2*@

    # alex@uazone.net: down to the end of this sections are my
    # settings
    set fan1_div 8
    set fan2_div 8


    label fan1 "Case Fan"
    label fan2 "CPU Fan"

    set fan1_min 1000
    set fan2_min 1000

    # Not connected. But technically this is a Power Fan
    # set fan3_div 4
    # label fan3 "Case Fan2"
    ignore fan3

    label temp1 "M/B Temp"
    set temp1_over 45
    set temp1_hyst 42

    label temp2 "CPU Temp"
    compute temp2 @*2.0, @/2.0
    set temp2_over 62
    set temp2_hyst 58

    # alex@uazone.net
    # temp3 is JTPWR - Power Supply Sensor - not present in my
    # configuration
    ignore temp3


[alex@acheron ~]$ sensors
as99127f-i2c-0-2d
Adapter: SMBus Via Pro adapter at e800
VCore:     +1.79 V  (min =  +1.66 V, max =  +1.82 V)              
+3.3V:     +3.44 V  (min =  +3.14 V, max =  +3.46 V)              
+5V:       +4.92 V  (min =  +4.73 V, max =  +5.24 V)              
+12V:     +11.92 V  (min = +10.82 V, max = +13.19 V)              
-12V:     -11.76 V  (min = -13.22 V, max = -10.74 V)              
-5V:       -5.06 V  (min =  -5.25 V, max =  -4.74 V)              
Case Fan: 1506 RPM  (min =  998 RPM, div = 8)                     
CPU Fan:  1454 RPM  (min =  998 RPM, div = 8)                     
M/B Temp:    +41?C  (high =   +45?C, hyst =   +42?C)          
CPU Temp:  +58.5?C  (high =   +62?C, hyst =   +58?C)          
vid:      +1.750 V  (VRM Version 9.0)
alarms:   
beep_enable:
          Sound alarm enabled
[alex@acheron ~]$ cat /sys/bus/i2c/devices/0-002d/alarms
0

As you can see, there is no beep's enabled in the mask right now,
because this beeping drives me crazy :) The only way to get rid of it is
to reboot.

Thank you very much in advance, I really appreciate your help.

-- 
Alex Tkachenko <alext@uazone.net>
