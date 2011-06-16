From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 16 Jun 2011 21:00:25 +0000
Subject: Re: [lm-sensors] Gigabyte GA-D525 core temps N/A?
Message-Id: <20110616230025.20ebf48a@endymion.delvare>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MP_/5M25S_GC3P/_N9Xw4b5sjeG"
List-Id: <lm-sensors.vger.kernel.org>
References: <12337942.277431308248481343.JavaMail.defaultUser@defaultHost>
In-Reply-To: <12337942.277431308248481343.JavaMail.defaultUser@defaultHost>
To: lm-sensors@vger.kernel.org

--MP_/5M25S_GC3P/_N9Xw4b5sjeG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, 16 Jun 2011 13:27:54 -0700, Guenter Roeck wrote:
> On Thu, Jun 16, 2011 at 04:23:44PM -0400, Guenter Roeck wrote:
> > On Thu, Jun 16, 2011 at 04:06:10PM -0400, everythingsfree@lineone.net wrote:
> > > Thanks Guenter & Jean for the replies.
> > > 
> > > I found this web page with some 
> > > info and was following that (but just used the Makefile as downloaded):
> > > 
> > > 
> > > https://wiki.ubuntu.com/CoreTemp
> > > That checked and updated a few things 
> > > plus downloaded other (it covered everything Guenter had suggested) but 
> > > I still get errors:
> > > 
> > [ ... ]
> > > I 
> > > would have assumed that 'MSR_IA32_TEMPERATURE_TARGET' would be defined 
> > > in a header file and that that would be in the 'linux-headers-2.6.32-24-
> > > server' package that was downloaded, perhaps not?
> > > 
> > > Any suggestions?  
> > > I'll keep looking on-line...
> > 
> > The build worked for me with linux-headers-2.6.32-25-server.
> > Can you update your system to the latest kernel version and try again ?
> > It should be 2.6.32-32 as far as I can see.
> > 
> Sorry, I got that wrong; it was 2.6.35-25, not 2.6.32-25.
> 
> Wel'll have to add the missing defines manually. I'll send you an update later tonight.

I've attached my compatibility patch for your reference. But it's
probably easier for Dave to just use my driver.

-- 
Jean Delvare

--MP_/5M25S_GC3P/_N9Xw4b5sjeG
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=support-older-kernels.patch

---
 coretemp.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

--- coretemp.orig/coretemp.c	2011-06-06 11:38:05.000000000 +0200
+++ coretemp/coretemp.c	2011-06-06 14:50:10.000000000 +0200
@@ -36,9 +36,21 @@
 #include <linux/cpu.h>
 #include <linux/pci.h>
 #include <linux/smp.h>
+#include <linux/version.h>
 #include <asm/msr.h>
 #include <asm/processor.h>
 
+#ifndef MSR_IA32_TEMPERATURE_TARGET
+#define MSR_IA32_TEMPERATURE_TARGET		0x000001a2
+#endif
+#ifndef MSR_IA32_PACKAGE_THERM_STATUS
+#define MSR_IA32_PACKAGE_THERM_STATUS		0x000001b1
+#endif
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 34)
+#define sysfs_attr_init(attr)	do {} while(0)
+#endif
+
 #define DRVNAME	"coretemp"
 
 #define BASE_SYSFS_ATTR_NO	2	/* Sysfs Base attr no for coretemp */
@@ -712,7 +724,11 @@ static void __cpuinit get_core_online(un
 	 * sensors. We check this bit only, all the early CPUs
 	 * without thermal sensors will be filtered out.
 	 */
+#ifdef X86_FEATURE_DTS
 	if (!cpu_has(c, X86_FEATURE_DTS))
+#else
+	if (c->cpuid_level < 6 || !(cpuid_eax(0x06) & 0x01))
+#endif
 		return;
 
 	if (!pdev) {
@@ -729,7 +745,11 @@ static void __cpuinit get_core_online(un
 		 * Check whether pkgtemp support is available.
 		 * If so, add interfaces for pkgtemp.
 		 */
+#ifdef X86_FEATURE_PTS
 		if (cpu_has(c, X86_FEATURE_PTS))
+#else
+		if (c->cpuid_level >= 6 && cpuid_eax(0x06) & 0x40)
+#endif
 			coretemp_add_core(cpu, 1);
 	}
 	/*

--MP_/5M25S_GC3P/_N9Xw4b5sjeG
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--MP_/5M25S_GC3P/_N9Xw4b5sjeG--
