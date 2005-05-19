From: marekm@amelek.gda.pl (Marek Michalkiewicz)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: Gigabyte GA-K8NS Ultra-939 issues
Message-Id: <20050507182053.GA4791@amelek.gda.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

First, thanks for all the good work on lm_sensors (which has already
saved one of my machines from overheating because of failed PSU fan).
This is really a BIOS bug report rather than lm_sensors bug report :)

Hardware: Gigabyte GA-K8NS Ultra-939 motherboard (BIOS version F5 which
is the latest), Athlon64 3000+ S939 0.09um "box" CPU (32-bit for now).

it87: Found IT8712F chip at 0x290, revision 5 

lm_sensors 2.9.1, Linux 2.4.30

First, some hardware-specific information for this board (may be worth
documenting somewhere), in the form ready for /etc/sensors.conf:

# begin

    label in0 "Vcore"
    label in1 "Vram"
    label in2 "+3.3V"
    ignore in3
    label in4 "+12V"
    ignore in5
    ignore in6
    ignore in7
    label in8 "VBat"
    ignore vid
    compute in4 ((30/10) +1)*@  , @/((30/10) +1)

# in0 is +1.4V for CPU core
# in1 is +2.5V for DDR SDRAM
# in2 shows +3.3V correctly without any "compute" lines
# in3, in5, in6, in7 values change all the time, as if these inputs
# were not connected (BIOS "PC health status" only shows +3.3V and +12V)
# in8 seems to always give +4.08V (a little too high for 3V battery?)
# vid reports 2.8V while this CPU uses 1.4 / 1.1 V (for 1800 / 1000 MHz)

    label temp1 "M/B Temp"
    label temp2 "CPU Temp"
    label temp3 "CPU diode"

# temp sensor types are set up as 2/2/3 by the BIOS
# only temp1 and temp2 are shown by the BIOS
# temp3 seems to track CPU temperature (responds much faster than temp2
# to CPU load, so it really looks like the internal diode, while temp2
# is a thermistor outside the CPU, so it is slower), but is too low
# (by about 40 deg C).  Here are the values I get for my motherboard:
# after cold start:   temp1=+25, temp2=+26, temp3=-7
# idle (1.4V/1.8GHz): temp1=+25, temp2=+32, temp3=-1
# during "burnK7":    temp1=+25, temp2=+43, temp3=+9

# end

Now for the fans - fan1 is the CPU fan, and the board is advertised to
have "smart fan control", but it is not very smart actually...

I have read the pwm1 value soon after boot (before "sensors -s", so it's
the original value set by the BIOS) and I can see it is 254 (= use temp3
diode) after power on, and 253 (= use temp2 thermistor) after a reboot.
No idea why the two values (after cold/warm boot) should be different.

After looking at the IT8712 datasheet, I see why the diode can be so
inaccurate: there are "thermal diode zero degree adjust [1-3] registers"
(with default value 0x156 = 0.664V), so the chip seems to simply measure
voltage on the diode with about -2 mV/K negative temperature coefficient
(very dependent on P-N junction characteristics), instead of voltage
difference for two different currents (proportional to absolute Kelvin
temperature, much more repeatable) as other sensor chips do.  So, the
about 40 deg offset (good for my CPU) may differ for other CPUs.

Another issue with this motherboard is fan PWM control, which is very
non-linear: the lowest values (0, 1, 2) give largest changes in fan
speed, and anything above about 10 (up to 127) is almost full speed.
But, initial (BIOS) values of "smart guardian" registers are:

sg_pwm1: 12 20 28
sg_tl1: 0.0 8.0 40.0 50.0 127.0

and 12 is almost full speed (at least for the "box" AMD CPU fan,
which seems to have its own temperature-dependent speed control),
so it effectively becomes on/off control (with threshold at 0 C,
which is about 40 C for the thermal diode).

With the help of lm_sensors, it should be possible to tweak IT8712
"smart guardian" settings to make it work right on this motherboard
under Linux.  But, I'm wondering if the lm_sensors developers have
any good contacts with Gigabyte BIOS developers, who could fix the
settings to make it work right by default under any OS...

Thanks,
Marek
