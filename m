From: r.marek@assembler.cz (Rudolf Marek)
Date: Sun, 04 Feb 2007 16:49:03 +0000
Subject: [lm-sensors] Asus P5B Deluxe / Winbond 83627DHG
Message-Id: <45C60E7F.6040805@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4dfa50520612211313g7906f3b0kbf8d7aebb2ddcda9@mail.gmail.com>
In-Reply-To: <4dfa50520612211313g7906f3b0kbf8d7aebb2ddcda9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello again,

> in1 (you state it should be 12V) is incorrect.  However, if I use the 
> compute line from lm-sensors-2.10.2 it is in the 12V range.
> in5 (you state it should be 5V) is incorrect.  However, 
> lm-sensors-2.10.2 shows the 5V is in6 with a compute line, which matches 
> what I am getting.

Ok then. They must do the convention elsewhere than on DSDT (oh those ... :)

> temp1: (you state it should be MB) this is consistent with my BIOS monitor
> temp2: (you state it should be CPU)  My temp2 went up from 34.0 to 44 
> under load and then came back down to 35.5 almost immediately.
>             So this does look like temp2 is linked to my CPU.  But you 
> mention a conversion formula for temp2 and temp3.  What formula
>             did you deduce from DSDT? 

None it seems, just generic formula for for 1 decimal point.

> temp2):  Under load, my temp3 *drops* from 119 to 103.5 under load and 
> then goes back up afterwards ?????

Hmm my MB has this at 127C which means unconnected. Please can you send a
dsdt.bin file? (cat /proc/acpi/dsdt > /tmp/dsdt.bin)

> fan1: (you state it should be the CPU_FAN) The RPM in the 1100 range 
> matches what I'm seeing in the BIOS for CHA_FAN1 and CHA_FAN2 (both are 
> documented to run at 1800 RPM)

ok

> fan2: (you state it should be CHA_FAN1) The RPM of 2537 is consistent 
> with what I'm seeing in the BIOS for CPU_FAN (a Zalman CNPS9500 LED)
> fan3: (you state it should be CHA_FAN2) My fan3 shows 0, but I have 
> verified both fans are spinning and connected to CHA_FAN1 and CHA_FAN2
> fan4: (you state this is PWR_FAN):  The P5B manual states that this 
> connector is not supported by their QFan2 software monitoring.  I doubt 
> it would be monitorable.

Hmm how many/what fans can you see in the BIOS?

here is my:

axon:~# sensors
w83627dhg-isa-0290
Adapter: ISA adapter
VCore:     +1.14 V  (min =  +0.00 V, max =  +1.74 V)
in1:      +12.30 V  (min =  +0.26 V, max = +10.88 V) ALARM
AVCC:      +3.25 V  (min =  +1.74 V, max =  +2.24 V) ALARM
3VCC:      +3.25 V  (min =  +3.44 V, max =  +3.17 V) ALARM
in4:       +1.11 V  (min =  +1.17 V, max =  +0.26 V) ALARM
in5:       +1.59 V  (min =  +0.06 V, max =  +1.54 V) ALARM
in6:       +3.53 V  (min =  +0.51 V, max =  +1.00 V) ALARM
VSB:       +3.25 V  (min =  +1.74 V, max =  +3.66 V)
VBAT:      +3.25 V  (min =  +0.05 V, max =  +0.64 V) ALARM
Case Fan:    0 RPM  (min = 21093 RPM, div = 64) ALARM
CPU Fan:  1687 RPM  (min = 1662 RPM, div = 4)
Aux Fan:     0 RPM  (min = 10546 RPM, div = 64) ALARM
fan4:        0 RPM  (min = 10546 RPM, div = 32) ALARM
fan5:     3835 RPM  (min = 7670 RPM, div = 2) ALARM
Sys Temp:    +33?C  (high =   -56?C, hyst =   +39?C)
CPU Temp:  +39.5?C  (high = +80.0?C, hyst = +75.0?C)
AUX Temp: +127.0?C  (high = +80.0?C, hyst = +75.0?C)   ALARM

coretemp-isa-0000
Adapter: ISA adapter
temp1:       +30?C  (high =   +85?C)

coretemp-isa-0001
Adapter: ISA adapter
temp1:       +32?C  (high =   +85?C)

Rudolf

