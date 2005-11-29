From: belle@bazuin.nl (L.P.H. van Belle)
Date: Tue, 29 Nov 2005 10:18:33 +0000
Subject: [lm-sensors] Asus P4S533-E need help with CPU Fan.
Message-Id: <200511290918.jAT9IPZ10439@engine.bazuin.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Im running Debian Sarge with kernel 2.6.12 from testing.
This is on a asus P4S533-E mainboard.

Everything execpt 1 is running fine, so is there somebody who
know's how to get the CPU Fan speed out of this.
I checked the bios hardware monitor and 
there is a Fan Speed (running at 2549 RPM)

and yes there is "ignore fan1" => 3, but when i enable it ( all three ) 
the output is 0

i need help with this one.
So if somebody knows the solution .. 
please.. 

this is my config and output now:

as99127f-i2c-0-2d
Adapter: SiS96x SMBus adapter at 0xe600
VCore:     +1.55 V  (min =  +1.44 V, max =  +1.60 V)
+3.3V:     +3.30 V  (min =  +3.14 V, max =  +3.46 V)
+5V:       +5.00 V  (min =  +4.73 V, max =  +5.24 V)
+12V:     +11.19 V  (min = +11.37 V, max = +12.59 V)       ALARM  => 
=> ignore this, is under control, i need a new Powersupply ;-)

M/B Temp:    +31?C  (high =   +45?C, hyst =   +38?C)
SYS Temp:  +32.0?C  (high =   +52?C, hyst =   +47?C)
CPU Temp:  +48.0?C  (high =   +62?C, hyst =   +56?C)
vid:      +1.525 V  (VRM Version 9.0)
alarms:
beep_enable:
          Sound alarm disabled


/etc/sensors.conf
### for ASUS P4S533-E
chip "as99127f-*"
    label in0 "VCore"
    ignore in1
    label in2 "+3.3V"
    label in3 "+5V"
    label in4 "+12V"
    ignore in5
    ignore in6

    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    compute in4 ((28/10)+1)*@  ,  @/((28/10)+1)
    compute in5 -(240/60.4)*@ ,  -@/(240/60.4)
    compute in6 -(90.9/60.4)*@ ,  -@/(90.9/60.4)

    label temp1 "M/B Temp"
    label temp2 "SYS Temp"
	## TEMP2 ?? is this System temp ? 
    label temp3 "CPU Temp"
    compute temp3  @/2,  2*@

# set limits to  5% for the critical voltages
# set limits to 10% for the non-critical voltages
# set limits to 20% for the battery voltage

    set in0_min vid*0.95
    set in0_max vid*1.05
    set in1_min vid*0.95
    set in1_max vid*1.05
    set in2_min 3.3 * 0.95
    set in2_max 3.3 * 1.05
    set in3_min 5.0 * 0.95
    set in3_max 5.0 * 1.05
    set in4_min 12 * 0.95
    set in4_max 12 * 1.05

    set temp1_over 45
    set temp1_hyst 38
    set temp2_over 52
    set temp2_hyst 47
    set temp3_over 63
    set temp3_hyst 56

#   set sensor1 1
#   set sensor2 2
#   set sensor3 3435

    ignore fan1
    ignore fan2
    ignore fan3

    set beep_enable 0
--
*** Bazuin & Partners Managed E-mail Filter scanned this email for viruses ***
