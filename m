From: jharvell+lists.lm-sensors@dogpad.net (Joe Harvell)
Date: Wed, 31 Jan 2007 01:36:16 +0000
Subject: [lm-sensors] Asus P5B Deluxe / Winbond 83627DHG
Message-Id: <45BFF290.8010707@dogpad.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4dfa50520612211313g7906f3b0kbf8d7aebb2ddcda9@mail.gmail.com>
In-Reply-To: <4dfa50520612211313g7906f3b0kbf8d7aebb2ddcda9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm replying to a recent post I found in the archives:  
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-January/018563.html

> in0 VCore
> in1 12V
> in2 not monitored
> in3 3.3V
> in4 not monitored
> in5 5V
>
>
> No formulas are used. Just raw value * 8mV so no need for compute lines in
> sensors.conf
>
> TEMP1 should be MBTEMP, which is direct value, temp2 is CPU temp, temp3 is not
> used in their implementation - but conversion formula is same as for the temp2.
> So it is most likely floating or not connected.
>
> As for fans:
>
> fan1 is cpu
> fan2 is chassis1
> fan3 is chassis2
> fan4 is power fan
> fan5 is not monitored
>
> All in all it seems that gkrellm is wrong. Please use the version indicated
> above, and provide the output of sensors command so we can check that the
> readings match the reality (and we trust our tools ;)
>   


I have an Asus P5B Deluxe (not the Wi-Fi edition), and the readings I'm 
getting don't match the conclusions you made from the DSDT.  I flashed 
to the latest BIOS (1004), and my DSDT looks basically the same as what 
you show.  But here is what I'm getting.  I commented out all of the 
"label" and "compute" lines so you can see the raw data.  Anyway, you 
say there should be no need for computes:

cujo kernel # sensors
w83627dhg-isa-0290
Adapter: ISA adapter
in0:       +1.12 V  (min =  +0.00 V, max =  +1.74 V)
in1:       +1.84 V  (min =  +1.64 V, max =  +2.00 V)
in2:       +3.33 V  (min =  +0.59 V, max =  +0.53 V) ALARM
in3:       +3.33 V  (min =  +2.43 V, max =  +0.35 V) ALARM
in4:       +1.58 V  (min =  +1.28 V, max =  +0.00 V) ALARM
in5:       +1.56 V  (min =  +1.62 V, max =  +0.17 V) ALARM
in6:       +1.58 V  (min =  +1.49 V, max =  +1.64 V)
in7:       +3.33 V  (min =  +0.29 V, max =  +3.36 V)
in8:       +2.11 V  (min =  +0.29 V, max =  +1.66 V) ALARM
fan1:     1102 RPM  (min = 8437 RPM, div = 8) ALARM
fan2:     2537 RPM  (min = 4440 RPM, div = 4) ALARM
fan3:        0 RPM  (min = 5273 RPM, div = 128) ALARM
fan4:        0 RPM  (min = 10546 RPM, div = 128) ALARM
fan5:        0 RPM  (min = 168750 RPM, div = 8) ALARM
temp1:       +28 C  (high =   +26 C, hyst =   +34 C)
temp2:     +34.0 C  (high = +80.0 C, hyst = +75.0 C)
temp3:    +119.0 C  (high = +91.0 C, hyst = +89.0 C)   ALARM

Here are my comments:

in1 (you state it should be 12V) is incorrect.  However, if I use the 
compute line from lm-sensors-2.10.2 it is in the 12V range.
in5 (you state it should be 5V) is incorrect.  However, 
lm-sensors-2.10.2 shows the 5V is in6 with a compute line, which matches 
what I am getting.

temp1: (you state it should be MB) this is consistent with my BIOS monitor
temp2: (you state it should be CPU)  My temp2 went up from 34.0 to 44 
under load and then came back down to 35.5 almost immediately.
            So this does look like temp2 is linked to my CPU.  But you 
mention a conversion formula for temp2 and temp3.  What formula
            did you deduce from DSDT?  lm-sensors-2.10.2 has no compute 
line.  So I don't know if the temp is accurate.
temp3: (you state unused but with the same conversion formula as 
temp2):  Under load, my temp3 *drops* from 119 to 103.5 under load and 
then goes back up afterwards ?????

fan1: (you state it should be the CPU_FAN) The RPM in the 1100 range 
matches what I'm seeing in the BIOS for CHA_FAN1 and CHA_FAN2 (both are 
documented to run at 1800 RPM)
fan2: (you state it should be CHA_FAN1) The RPM of 2537 is consistent 
with what I'm seeing in the BIOS for CPU_FAN (a Zalman CNPS9500 LED)
fan3: (you state it should be CHA_FAN2) My fan3 shows 0, but I have 
verified both fans are spinning and connected to CHA_FAN1 and CHA_FAN2
fan4: (you state this is PWR_FAN):  The P5B manual states that this 
connector is not supported by their QFan2 software monitoring.  I doubt 
it would be monitorable.


