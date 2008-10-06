From: Wolfgang Grandegger <wg@grandegger.com>
Date: Mon, 06 Oct 2008 13:32:44 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: w83781d: make ISA interface
Message-Id: <48EA137C.4050903@grandegger.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <48CB7F6D.8010109@grandegger.com>
In-Reply-To: <48CB7F6D.8010109@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Jean Delvare wrote:
> Hi Wolfgang,
> 
> On Sat, 13 Sep 2008 10:53:01 +0200, Wolfgang Grandegger wrote:
>> Probing the ISA bus on systems without ISA bus may hang the system.
>> This patch makes the ISA bus related code depend on the kernel
>> configuration parameter CONFIG_ISA. It moves ISA bus related code
>> into one #ifdef CONFIG_ISA ... #endif block and adds some helper
>> function.
> 
> As said before, this patch is a little bigger than I hoped for, but I
> admit it nicely optimizes the size of the driver when CONFIG_ISA isn't
> set. So, so be it, I'm taking it.

Well, the code was not written with separating the ISA interface in mind
and I'm only partially happy with it, to say the least.

>> Note that this patch is based on the patches:
>>
>>   hwmon-w83781d-01-refactor-beep-enable.patch
>>   hwmon-w83781d-02-alias-detect.patch
>>
>> from http://jdelvare.pck.nerim.net/sensors/w83781d/.

OK, great, thanks.

>> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
>> ---
>>  drivers/hwmon/w83781d.c |  666 +++++++++++++++++++++++++++---------------------
>>  1 file changed, 388 insertions(+), 278 deletions(-)
>>
>> Index: linux-2.6-denx/drivers/hwmon/w83781d.c
>> =================================>> --- linux-2.6-denx.orig/drivers/hwmon/w83781d.c
>> +++ linux-2.6-denx/drivers/hwmon/w83781d.c
>> @@ -49,14 +49,9 @@
>>  #include <asm/io.h>
>>  #include "lm75.h"
> 
> You can put the inclusion of <linux/platform_device.h>,
> <linux/ioport.h> and <asm/io.h> inside #ifdef CONFIG_ISA as well. This
> will avoid unneeded rebuilds.

Fine for me.

[...deletions...]
>> +static void __init
> 
> Should be __exit not __init.

Oops, sorry.

> In order to save some time, I've fixed all these minor issues myself.
>
> Patch tested on my system with an ISA chip and it worked fine. I will
> test later with a graphics adapter with a W83781D chip on the same
> system.

Thanks a lot.

Wolfgang.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
