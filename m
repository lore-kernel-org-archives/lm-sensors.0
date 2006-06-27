From: grimm@nickellson.com (Nick Ellson)
Date: Tue, 27 Jun 2006 17:13:52 +0000
Subject: [lm-sensors] i2c-i801 on Intel Server Board se7525gp2?
Message-Id: <Pine.LNX.4.64.0606271008390.22045@gubbie.home>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0606261023280.15719@gubbie.home>
In-Reply-To: <Pine.LNX.4.64.0606261023280.15719@gubbie.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Sorry about that Jim, I had intended on pasting this in.

gubbie ~ # ls /sys
block  bus  class  devices  firmware  fs  kernel  module  power
gubbie ~ # ls /sys/bus
ac97  i2c  ide  pci  pci_express  platform  pnp  scsi  serio  spi  usb
gubbie ~ # ls /sys/bus/i2c
devices  drivers
gubbie ~ # ls /sys/bus/i2c/drivers
dev_driver  eeprom  i2c_adapter
gubbie ~ # ls /sys/bus/i2c/devices
0-0051  0-0055
gubbie ~ #


And on acpi (not sure how to use this but here is a peek at my tree)

gubbie ~ # ls /proc/acpi
ac_adapter  battery  button  dsdt  embedded_controller  event  fadt  fan 
info  power_resource  processor  thermal_zone  video
gubbie ~ # ls /proc/acpi/processor/
CPU1  CPU2  CPU3  CPU4
gubbie ~ # ls /proc/acpi/processor/CPU1
info  limit  power  throttling
gubbie ~ # ls /proc/acpi/processor/CPU1/info
/proc/acpi/processor/CPU1/info
gubbie ~ # cat /proc/acpi/processor/CPU1/info
processor id:            0
acpi id:                 1
bus mastering control:   no
power management:        no
throttling control:      yes
limit interface:         yes
gubbie ~ # ls /proc/acpi/thermal_zone/
gubbie ~ # ls /proc/acpi/info
/proc/acpi/info
gubbie ~ # cat /proc/acpi/info
version:                 20060127
gubbie ~ #


-- 
Nick Ellson
CCDA, CCNP, CCSP, CCAI,
MCSE 2000, Security+, Network+
Network Hobbyist, VFR Private Pilot.


On Tue, 27 Jun 2006, Jim Cromie wrote:

> Nick Ellson wrote:
>> 
>>
>>  Hi Jim,
>>
>>  It is my own Kernel in the sense that with Gentoo the install process I
>>  need to pick the features that match my system. The SMP stuff and drive
>>  controllers, network, the basics.
>>
>>  I do not add any odd patches to my kernel.
>> 
>
> I was thinking more of the possible mis-*configuration* of the build,
> which is less likely for a 'distro' build than yours or mine.
> From what youve said, it sounds like you selected one of the prebuilt 
> kernels.
>
> I guess Im still dwelling on whether /sys exists or not, which you didnt 
> respond to.
> If /sys isnt there, for whatever reason, no sensors will work, no matter the 
> chip.
>
> That said, it might not matter, given what youve found about the chip.
>
> What, if anything, does the BIOS tell you about sensors, etc.
> What does the kernels ACPI tell you ?
> Given that Intel was one of 2 or 3 players in ACPI development,
> it would be worth a look into /proc/acpi/*
>
>>  And yep, I bought two systems at the same time so that they would be
>>  identical so I could try software on one and work out the kinks before
>>  messing with my E-mail/DNS box.
>>
>>  What I have learned is that the E7525 chipset is known to not report any
>>  sensors. While I would love that not to be true, I have found no evidence
>>  that they can be read by lm-sensors. Intel's sensor observation drivers
>>  are for RedHat only as far as Linux goes, so I am not sure if they will
>>  work under Gentoo.
>> 
> 'Redhat *only*'  is more likely to be a 'certification' issue than a 'just 
> wont run' problem.
>
>>  I am now looking at alternative solutions. I seem to have this kind of
>>  luck with systems, always picking one that Linux is shut out from the nice
>>  features on the hardware. :\
>>
>>  Nick
>> 
>
>

