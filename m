From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: Latest cvs -> Compile Errors
Message-Id: <3DD68285.18B632D4@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200211161710.26342.amalysh@web.de>
In-Reply-To: <200211161710.26342.amalysh@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thanks. I just checked in lib/chips.[ch].

I was stalling because I was trying to figure out how to do 
a dynamic sensors_chip_feature table in libsensors. But I don't
think it's possible. 

Khali, this probably breaks your doc-features tool.
But I don't know how many of each kind of sensor BMC will find.
I was hoping to just define the first one of each kind in chips.h
but then I realized I had to put the max number into the table
in chips.c anyway. What a pain. If anybody has any ideas let me know.

Dynamic sensor discovery is one of two hard parts of doing IPMI.

The other was defining a new dummy adapter, then realizing libsensors
didn't support dummy adapters other than isa. There's a couple of hacks
in there for that but generic support for dummy adapters will
require more code.

mds


Alexander Malysh wrote:
> 
> Hi there,
> 
> if I try to compile latest cvs version, then i got errors :
> 
> gcc -I. -Ikernel/include -I/usr/local/include -I/lib/modules/2.4.19/build/include  -O2   -c prog/sensors/chips.c -o prog/sensors/chips.ro
> prog/sensors/chips.c: In function `print_bmc':
> prog/sensors/chips.c:3669: `SENSORS_BMC_IN1' undeclared (first use in this function)
> prog/sensors/chips.c:3669: (Each undeclared identifier is reported only once
> prog/sensors/chips.c:3669: for each function it appears in.)
> prog/sensors/chips.c:3671: `SENSORS_BMC_IN1_MIN' undeclared (first use in this function)
> prog/sensors/chips.c:3672: `SENSORS_BMC_IN1_MAX' undeclared (first use in this function)
> prog/sensors/chips.c:3683: `SENSORS_BMC_FAN1' undeclared (first use in this function)
> prog/sensors/chips.c:3688: `SENSORS_BMC_FAN1_MIN' undeclared (first use in this function)
> prog/sensors/chips.c:3699: `SENSORS_BMC_TEMP1' undeclared (first use in this function)
> prog/sensors/chips.c:3701: `SENSORS_BMC_TEMP1_MIN' undeclared (first use in this function)
> prog/sensors/chips.c:3702: `SENSORS_BMC_TEMP1_MAX' undeclared (first use in this function)
> make: *** [prog/sensors/chips.ro] Fehler 1
> 
> What going wrong ?
> Mark, I believe you have forgot some defines ?
> 
> --
> Thanks,
> Alexander Malysh
