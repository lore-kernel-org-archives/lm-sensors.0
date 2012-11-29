From: David Hubbard <david.c.hubbard@gmail.com>
Date: Thu, 29 Nov 2012 18:00:21 +0000
Subject: Re: [lm-sensors] ITE it8603e
Message-Id: <CAC-0Eqg0duZFwyjZY6Gv=93+WwEm5EPJH8v3vacgrFhTDX8zBQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAC-0Eqii0d94mPbn=8MoOn9UMP_srC3s5Dt3q45G+GTdo2kptw@mail.gmail.com>
In-Reply-To: <CAC-0Eqii0d94mPbn=8MoOn9UMP_srC3s5Dt3q45G+GTdo2kptw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Thu, Nov 29, 2012 at 4:48 AM, Jean Delvare <khali@linux-fr.org> wrote:
> On Thu, 29 Nov 2012 03:09:01 -0700, David Hubbard wrote:
>> +             * at all, not sure about the IT8728F or IT8603E
>> +             * (IT8603E - "hwmon_vid: Unknown VRM version of your x86 CPU"
>> +             * and cpu0_vid reads as 0)
>
> This has nothing to do with the IT8603E but only with your CPU. Which
> kernel version are you running, and can we see (one entry in)
> your /proc/cpuinfo?

Yes. I am most interested in the datasheet, but I appreciate your help
to tweak the it87 driver as a fallback.

$ uname -a
Linux f2a85 3.6.6-gentoo #13 SMP Wed Nov 28 22:29:55 MST 2012 x86_64
AMD A10-5800K APU with Radeon(tm) HD Graphics AuthenticAMD GNU/Linux

$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 21
model           : 16
model name      : AMD A10-5800K APU with Radeon(tm) HD Graphics
stepping        : 1
microcode       : 0x6001116
cpu MHz         : 3800.000
cache size      : 2048 KB
physical id     : 0
siblings        : 4
core id         : 0
cpu cores       : 2
apicid          : 16
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc
extd_apicid aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1
sse4_2 popcnt aes xsave avx f16c lahf_lm cmp_legacy svm extapic
cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs xop skinit wdt
lwp fma4 tce nodeid_msr tbm topoext perfctr_core arat cpb hw_pstate
npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid
decodeassists pausefilflags       old bmi1
bogomips        : 7637.75
TLB size        : 1536 4K pages
clflush size  clflush size  clflush size  clflush size  clflush size
clflus, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate cpb eff_freq_ro


Thanks,
David

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
