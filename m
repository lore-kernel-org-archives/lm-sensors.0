From: Maxim Levitsky <maximlevitsky@gmail.com>
Date: Sun, 30 May 2010 14:43:57 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (coretemp) Get TjMax value from
Message-Id: <1275230637.14907.15.camel@maxim-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100507095945.GB12190@owl>
	 <1275111551.3427.4.camel@maxim-laptop>
In-Reply-To: <1275111551.3427.4.camel@maxim-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Huaxu Wan <huaxu.wan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, huaxu.wan@intel.com, khali@linux-fr.org

On Sat, 2010-05-29 at 08:39 +0300, Maxim Levitsky wrote: 
> On Fri, 2010-05-07 at 17:59 +0800, Huaxu Wan wrote: 
> > The MSR IA32_TEMPERATURE_TARGET contains the TjMax value in the newer
> > processers.
> 
> I know that TjMax on my system is 85, and now coretemp reports wrong
> temperatures.
> First of all BIOS using stupid tricks actualy reports CPU temperature
> through ACPI, and assuming it was correct TjMax is 85.
> It also shuts down the system if I 'lie' to it that cpu temperature is
> 85C.
> 
> Coretemp was working correctly in 2.6.34

The following patch unbreaks the driver:


commit 8ff4f666908dd208a10f1b6b38286303fdb774fc
Author: Maxim Levitsky <maximlevitsky@gmail.com>
Date:   Sat May 29 08:57:09 2010 +0300

coretemp: unbreak tjmax reports on Core2 CPUs

Core2 CPUS don't report TjMax, but its not always 100C

Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>


diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 2988da1..fb100a4 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -276,11 +276,8 @@ static int __devinit get_tjmax(struct cpuinfo_x86
*c, u32 id,
case 0xf:
case 0x16:
case 0x1a:
- dev_warn(dev, "TjMax is assumed as 100 C!\n");
- return 100000;
- break;
case 0x17:
- case 0x1c: /* Atom CPUs */
+ case 0x1c:
return adjust_tjmax(c, id, dev);
break;
default:



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
