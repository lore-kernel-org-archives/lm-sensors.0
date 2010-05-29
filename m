From: Maxim Levitsky <maximlevitsky@gmail.com>
Date: Sat, 29 May 2010 05:39:11 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (coretemp) Get TjMax value from
Message-Id: <1275111551.3427.4.camel@maxim-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100507095945.GB12190@owl>
In-Reply-To: <20100507095945.GB12190@owl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Huaxu Wan <huaxu.wan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, huaxu.wan@intel.com, khali@linux-fr.org

On Fri, 2010-05-07 at 17:59 +0800, Huaxu Wan wrote: 
> The MSR IA32_TEMPERATURE_TARGET contains the TjMax value in the newer
> processers.

I know that TjMax on my system is 85, and now coretemp reports wrong
temperatures.
First of all BIOS using stupid tricks actualy reports CPU temperature
through ACPI, and assuming it was correct TjMax is 85.
It also shuts down the system if I 'lie' to it that cpu temperature is
85C.

Coretemp was working correctly in 2.6.34

cat /proc/cpuinfo

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 15
model name	: Intel(R) Core(TM)2 Duo CPU     T5450  @ 1.66GHz
stepping	: 13
cpu MHz		: 1667.000
cache size	: 2048 KB
physical id	: 0
siblings	: 2
core id		: 0
cpu cores	: 2
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm constant_tsc arch_perfmon pebs bts rep_good aperfmperf pni dtes64 monitor ds_cpl est tm2 ssse3 cx16 xtpr pdcm lahf_lm
bogomips	: 3324.70
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 15
model name	: Intel(R) Core(TM)2 Duo CPU     T5450  @ 1.66GHz
stepping	: 13
cpu MHz		: 1667.000
cache size	: 2048 KB
physical id	: 0
siblings	: 2
core id		: 1
cpu cores	: 2
apicid		: 1
initial apicid	: 1
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm constant_tsc arch_perfmon pebs bts rep_good aperfmperf pni dtes64 monitor ds_cpl est tm2 ssse3 cx16 xtpr pdcm lahf_lm
bogomips	: 3324.99
clflush size	: 64
cache_alignment	: 64
address sizes	: 36 bits physical, 48 bits virtual
power management:


Best regards,
	Maxim Levitsky


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
