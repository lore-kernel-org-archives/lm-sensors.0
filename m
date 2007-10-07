From: Rudolf Marek <r.marek@assembler.cz>
Date: Sun, 07 Oct 2007 11:42:09 +0000
Subject: Re: [lm-sensors] [PATCH] coretemp driver and Celeron 430 - works
Message-Id: <4708C611.5040808@assembler.cz>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------080703050006030105060604"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------080703050006030105060604
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello Jan,

Sorry for the delay, I'm busy with other stuff too.

Thank you for the report, I check the revision guide and everything seems ok. I
would like you to test attach patch. I think it does only what you did + updates
the documentation.

Please can you test that patch?

Signed-off-by: Rudolf Marek <r.marek@assembler.cz>

This patch adds support for the Celeron 4xx based on Core 2 core.

Thanks,

Rudolf




Jan Richling wrote:
> Hi,
> 
> I just tested your coretemp driver on a Celeron 430 (Core 2 based) and
> got unknown CPU model 16 which is triggered by the condition that you
> only accept model 0xe or 0xf as valid devices. The Celeron 4xx is model
> 22 (0x16) so I patched the driver by adding (|| (c->x86_model == 0x16)).
> This works out of the box with no further modifications and shows
> temperatures that are equal to those displayed by a Windows utility on
> the same machine.
> 
> So I can tell you that your driver works for family 6, model 22 also.
> 
> Just to be complete here is the cpuinfo:
> 
> cat /proc/cpuinfo
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 22
> model name      : Intel(R) Celeron(R) CPU          430  @ 1.80GHz
> stepping        : 1
> cpu MHz         : 2400.147
> cache size      : 512 KB
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 10
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss tm syscall lm
> constant_tsc pni monitor ds_cpl tm2 ssse3 cx16 xtpr lahf_lm
> bogomips        : 4802.79
> clflush size    : 64
> cache_alignment : 64
> address sizes   : 36 bits physical, 48 bits virtual
> power management:
> 
> (it shows 2400 MHz due to FSB-mod (200->266) and the resulting
> overclock, stock is 9x200=1,8 GHz)
> 
> Greetings and many thanks for the driver,
> 
> Jan
> 
>    ------------------------------------------------------------------
>   / Dr. Jan Richling - http://www.richling.de                      /
>  / Member of Computer Architecture and Communication Group -      /
> / Department of Computer Science - Humboldt University Berlin    /

--------------080703050006030105060604
Content-Type: text/x-diff;
 name="add_support_for_sc_celerons.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="add_support_for_sc_celerons.patch"

Index: linux-2.6.23-rc7-rc9/drivers/hwmon/coretemp.c
===================================================================
--- linux-2.6.23-rc7-rc9.orig/drivers/hwmon/coretemp.c	2007-10-07 13:18:51.650651170 +0200
+++ linux-2.6.23-rc7-rc9/drivers/hwmon/coretemp.c	2007-10-07 13:27:05.086652886 +0200
@@ -371,9 +371,10 @@
 	for_each_online_cpu(i) {
 		struct cpuinfo_x86 *c = &(cpu_data)[i];
 
-		/* check if family 6, models e, f */
+		/* check if family 6, models e, f, 16 */
 		if ((c->cpuid_level < 0) || (c->x86 != 0x6) ||
-		    !((c->x86_model == 0xe) || (c->x86_model == 0xf))) {
+		    !((c->x86_model == 0xe) || (c->x86_model == 0xf) ||
+			(c->x86_model == 0x16))) {
 
 			/* supported CPU not found, but report the unknown
 			   family 6 CPU */
Index: linux-2.6.23-rc7-rc9/Documentation/hwmon/coretemp
===================================================================
--- linux-2.6.23-rc7-rc9.orig/Documentation/hwmon/coretemp	2007-10-07 13:27:18.682652097 +0200
+++ linux-2.6.23-rc7-rc9/Documentation/hwmon/coretemp	2007-10-07 13:27:39.226648400 +0200
@@ -4,7 +4,7 @@
 Supported chips:
   * All Intel Core family
     Prefix: 'coretemp'
-    CPUID: family 0x6, models 0xe, 0xf
+    CPUID: family 0x6, models 0xe, 0xf, 0x16
     Datasheet: Intel 64 and IA-32 Architectures Software Developer's Manual
                Volume 3A: System Programming Guide
 

--------------080703050006030105060604
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------080703050006030105060604--
