From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 21 Jun 2011 08:20:50 +0000
Subject: Re: [lm-sensors] sensors doesn't show my fans,
Message-Id: <20110621102050.59dbd8dc@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

On Fri, 17 Jun 2011 20:51:21 +0300, Mark Bloch wrote:
> I have a dv6t-6000 (i7-2630QM ) , sensors-detect finds my hardware.
> I can see the temperature of the CPU.
> 
> The thing is I can't see my fan(/s?) ( in windows there is a hp software for
> controlling the fans, and I have an option in the bios for the fans, so I
> know I have them ) .
> 
> Can you help me find a solution, I've attached everything I could think of.

This is very common on laptops, that native hardware monitoring drivers
can't be used. Thermal management is usually handled by ACPI.
Unfortunately I am not aware of any HP-specific driver exposing fan
speeds to user-space.

Your best option is probably to ask HP support for a Linux driver and
see what they have to say.

> 
> I haven't installed any distro just yet, so I've used SystemRescueCd v*
> 2.2.0.
> 
> *My motherboard is listed as :
> 
> 
> Mainboard Manufacturer: Hewlett-Packard
> Mainboard Name:1657
> Mainboard Version:10.22
> Mainboard Serial Number:PBWQE05HT0C0QV
> Asset Tag:Base Board Asset Tag
> Location in chassis:Base Board Chassis Location
> Info :  http://pastebin.com/1xFa5Ccp*
> *dmesg :http://pastebin.com/fAY69Ac3
> lsmod : http://pastebin.com/h5y17Atd
> lspci -nn : http://pastebin.com/GxWtyBSt
> sensors : http://pastebin.com/3kpxEN3F
> sensors-detect : http://pastebin.com/4PhaGfV9

FYI, the max6650 detection and one of the sbs detections are false
positives (fixed in sensors-detect meanwhile) caused by a misbehaving
radeon I2C bus (you may want to report to the radeon driver maintainer.)

The other sbs detection may be correct, I'm not sure. Feel tree to try
loading the sbs driver and see if it works (note that it doesn't
integrate with the hwmon subsystem though so you won't see anything in
the output of "sensors".)

There is an unknown Super-I/O chip detected, it may or may not have
sensors. It's impossible to know without first finding out the vendor
and model of the Super-I/O chip and then obtaining a datasheet from the
vendor.

So in the end there's not much we can do for you, I'm afraid.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
