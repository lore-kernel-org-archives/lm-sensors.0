From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Wed, 14 Mar 2007 20:52:13 +0000
Subject: [lm-sensors] PC8374L SuperIO chip
Message-Id: <45F8607D.8010802@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070310181650.33ed8ef7@beast>
In-Reply-To: <20070310181650.33ed8ef7@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Marcin DrStorm Sliwinski wrote:
> On Sat, 10 Mar 2007 22:57:46 +0100
> Hans de Goede <j.w.r.degoede at hhs.nl> wrote:
> 
>> Writing a driver should be quite doable. My only concern is that this 
>> chip breathes acpi / tastes like acpi. It very much seems designed to 
>> make implementing acpi easy (thermal zones instead of sensors, etc).
> 
> Bad part is that ACPI on my board don't show any data about sensors, thermal zones or fans.
> Probably it wasn't implemented in bios (AMI, worst bios i ever saw)
> Even on my old Toshiba laptop i get at least cpu temperature from ACPI.
> 
>> So I'm afraid we might have some collisions with acpi here. Either way I 
>> would like to write a little userspace test program (for starters) to 
>> see if we can get some info out of the chip.
> 
> If You write it I will be very happy to test it.
> Basic info about my box (I don't know if You need it)
> CPU: Core 2 Duo
> OS: Gentoo Linux 64bit with 2.6.20.2 kernel
> 

Okay,

I've done some reading of the datasheet and it seems that this is one of the
more complicated superio chips. This beast can do both io based io and 
memorymapped io. And I had to read the chapter on this 3 times to find out how 
it all works. (My fault I tried to quick read. just reading it linear helps)

Anyways I'm ready write a simple iopl using, run as root test program now. I'll 
see if I can find some time for that tomorrow and send it to you then.

Also it would greatly help / speed things up if I could get ssh access to that 
machine. In order for that to be really usefull I would need either to be able 
to sudo, or (to be in a group with) r/w access to /dev/port and /dev/mem

You can send me account info with the public key registered to this mail 
address at pgp.mit.edu .

Thanks & Regards,

Hans


