From: roger@planbit.co.uk (Roger Lucas)
Date: Thu, 03 Nov 2005 11:04:56 +0000
Subject: [lm-sensors] lm-sensors
Message-Id: <20051103100421.6844012E9E@bluewhale.planbit.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <3C61EE92.392A5D31@paradyne.com>
In-Reply-To: <3C61EE92.392A5D31@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

Try using the BIOS reset jumper on the motherboard to cause the CMOS to
clear on the MoBo (do this while the MoBo is OFF) then put the jumper back
to the normal position and power up the PC.  You should find instructions
for this in your MoBo manual (which you carefully kept in case you needed
it... ;-) ... do follow them carefully.

Hopefully this will clear the problem and allow you to boot cleanly.  Then
you can start to track down exactly where it came from.

- Roger

-----Original Message-----
From: lm-sensors-bounces@lm-sensors.org
[mailto:lm-sensors-bounces@lm-sensors.org] On Behalf Of Grant Coady
Sent: 03 November 2005 06:45
To: David Haertig
Cc: lm-sensors@lm-sensors.org
Subject: Re: [lm-sensors] lm-sensors
installchanged/corruptedBIOS/chip_firmware???!!!

Hi David,
David Haertig wrote:
> Hi Grant -
> 
> Thanks for the quick reply.  However, I don't understand your
> concerns about what compiler or kernel I have installed.
> I did not recompile the kernel BTW.  I downloaded a binary
> kernel from Debian SID, but I needed the kernel source and the
> newer compiler to compile the nVidia drivers.

Okay, but it maybe an issue later.  I'm asking the silly preliminary
stuff, somebody else will chime in, we hope :)
> 
> After installing lm-sensors (apt-get install, then sensor-detect)
> I rebooted.  The first reboot I tried was a soft one ("Logoff and
> restart" from within Gnome Desktop).  My second reboot was a
> total power down one.

Okay.
> 
> Anyway, the hang is during POST.  This is way before any OS is
> loaded, tainted kernel or not.  I'm not even to the MBR -> XOSL Boot
> Manager -> Grub -> Linux Kernel yet.  I'm still in POST (firmware).
> Drivers and kernels are not in the picture at this stage of booting.
> The harddisk hasn't even been accessed yet!

This is where we get concerned, something has upset the BIOS?

> I'm hoping that what I think happened is not what really happened.
> Or at least there's an easy fix for it.

Can you try clearing the BIOS, don't run lm_sensors, but take a look
at the ACPI in dmesg and /sys area, newer BIOS now report hardware
monitoring through ACPI, which is a different ballgame.  There was
info about ACPI hw monitoring very recently either on this list or
linux-kernel.

Sorry cannot be more helpful.  Out of cluebats today :(

Grant.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

