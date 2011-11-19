From: Paul Norman <penorman@mac.com>
Date: Sat, 19 Nov 2011 06:32:09 +0000
Subject: [lm-sensors] Biostar TA880GB+ Motherboard Information
Message-Id: <000001cca684$f7e5ace0$e7b106a0$@mac.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I was going to add this to the wiki, but was unable to figure out how to
register to add it. Someone on IRC suggested I post to the mailing list.

My Ubuntu server runs on a Biostar TA880GB+ AM3 motherboard, with a 880G
northbridge and an Athelon II processor.

Finding no configuration information for this motherboard, I proceeded to
write it, using the fairly detailed information in the BIOS to match up
sensors with what they measure. I overvolted parts in the BIOS to verify
that I had the configuration right.

My configuration file is as follows. I am running sensors version 3.3.0 with
libsensors version 3.3.0

chip "it8721-isa-*"

# Temperatures
    label temp1 "CPU"
    label temp2 "Northbridge"
    label temp3 "Mainboard"

# fans
# Assuming fans are connected as specified on the motherboard.
# CPU fan is a 4 pin PWM connector, the others are 3 pin.
    label fan1 "CPU Fan"
    label fan2 "System Fan 1"
    label fan3 "System Fan 2"

# Voltages
    #Not sure what in0 and in1 are. They're stable, maybe +12V and +5V lines
in need of scaling?
    label in2 "Vcore"
    label in3 "+3.3V"
    label in4 "NB Voltage"
    label in5 "DDR Voltage"
    label in6 "HT Voltage"
    label in7 "+3.3Vsb"


chip "acpitz-virtual-0"
# This is essentially the same as the CPU temperature.
    label temp1 "temp1"

chip "k10temp-pci-00c3"
#    temp1 represents the CPU temperature but is not in any physical unit
    label temp1 "temp2"

The Northbridge temperature is not listed in the BIOS, but it's the only
component that runs that hot, is not affected by CPU load, and is affected
by CPU fan speed (the cooler gets some air to the northbridge)

I'm pretty sure that in0 and in1 are +5V and +12V readings since those are
shown in the BIOS, but I don't know of a way to tell them apart.

Fancontrol does work with this setup although with my cooling it doesn't
accomplish much since the loudest and most powerful fans are cooling my
drives. Biostar makes some other 880G-based motherboards and this
configuration may apply to them too.

-- 
Paul Norman
http://www.paulnorman.ca/blog


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
