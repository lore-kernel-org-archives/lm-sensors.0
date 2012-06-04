From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 04 Jun 2012 16:46:58 +0000
Subject: Re: [lm-sensors] System: "Point of View ION-MB330-1" produces wrong values with lm-sensors 3.3.2
Message-Id: <1338828418.478.172.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAOB5NSGJmSkyng5C4YDACgcKAAAAQAAAARsa0Leonh0i8VcwkGa2IBgEAAAAA@casema.nl>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAOB5NSGJmSkyng5C4YDACgcKAAAAQAAAARsa0Leonh0i8VcwkGa2IBgEAAAAA@casema.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 2012-06-03 at 20:18 -0400, Ben Kamen wrote:
> I'm using a Supermicro X7SPA D510 and it's like 10'C different btween coretemp readings and what the IPMI reports for its CPU sensor...
> 
> For what it's worth, /proc/cpuinfo reads:
> 
> > processor       : 0
> > vendor_id       : GenuineIntel
> > cpu family      : 6
> > model           : 28
> > model name      : Intel(R) Atom(TM) CPU D510   @ 1.66GHz
> > stepping        : 10
> > cpu MHz         : 1666.670
> > cache size      : 512 KB
> > physical id     : 0
> > siblings        : 4
> > core id         : 0
> > cpu cores       : 2
> > apicid          : 0
> > initial apicid  : 0
> > fpu             : yes
> > fpu_exception   : yes
> > cpuid level     : 10
> > wp              : yes
> > flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat pse36 clflush dts ac                                 pi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm constant_tsc arch_perfmon pebs bts rep_good aperfmpe                                 rf pni dtes64 monitor ds_cpl tm2 ssse3 cx16 xtpr pdcm movbe lahf_lm dts
> > bogomips        : 3334.02
> > clflush size    : 64
> > cache_alignment : 64
> > address sizes   : 36 bits physical, 48 bits virtual
> > power management:
> >
> > processor       : 1
> > vendor_id       : GenuineIntel
> > cpu family      : 6
> > model           : 28
> > model name      : Intel(R) Atom(TM) CPU D510   @ 1.66GHz
> > stepping        : 10
> > cpu MHz         : 1666.670
> > cache size      : 512 KB
> > physical id     : 0
> > siblings        : 4
> > core id         : 1
> > cpu cores       : 2
> > apicid          : 2
> > initial apicid  : 2
> > fpu             : yes
> > fpu_exception   : yes
> > cpuid level     : 10
> > wp              : yes
> > flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat pse36 clflush dts ac                                 pi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm constant_tsc arch_perfmon pebs bts aperfmperf pni dt                                 es64 monitor ds_cpl tm2 ssse3 cx16 xtpr pdcm movbe lahf_lm dts
> > bogomips        : 3399.83
> > clflush size    : 64
> > cache_alignment : 64
> > address sizes   : 36 bits physical, 48 bits virtual
> > power management:
> >
> > processor       : 2
> > vendor_id       : GenuineIntel
> > cpu family      : 6
> > model           : 28
> > model name      : Intel(R) Atom(TM) CPU D510   @ 1.66GHz
> > stepping        : 10
> > cpu MHz         : 1666.670
> > cache size      : 512 KB
> > physical id     : 0
> > siblings        : 4
> > core id         : 0
> > cpu cores       : 2
> > apicid          : 1
> > initial apicid  : 1
> > fpu             : yes
> > fpu_exception   : yes
> > cpuid level     : 10
> > wp              : yes
> > flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat pse36 clflush dts ac                                 pi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm constant_tsc arch_perfmon pebs bts aperfmperf pni dt                                 es64 monitor ds_cpl tm2 ssse3 cx16 xtpr pdcm movbe lahf_lm dts
> > bogomips        : 3333.13
> > clflush size    : 64
> > cache_alignment : 64
> > address sizes   : 36 bits physical, 48 bits virtual
> > power management:
> >
> > processor       : 3
> > vendor_id       : GenuineIntel
> > cpu family      : 6
> > model           : 28
> > model name      : Intel(R) Atom(TM) CPU D510   @ 1.66GHz
> > stepping        : 10
> > cpu MHz         : 1666.670
> > cache size      : 512 KB
> > physical id     : 0
> > siblings        : 4
> > core id         : 1
> > cpu cores       : 2
> > apicid          : 3
> > initial apicid  : 3
> > fpu             : yes
> > fpu_exception   : yes
> > cpuid level     : 10
> > wp              : yes
> > flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat pse36 clflush dts ac                                 pi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm constant_tsc arch_perfmon pebs bts aperfmperf pni dt                                 es64 monitor ds_cpl tm2 ssse3 cx16 xtpr pdcm movbe lahf_lm dts
> > bogomips        : 3333.24
> > clflush size    : 64
> > cache_alignment : 64
> > address sizes   : 36 bits physical, 48 bits virtual
> > power management:
> 
TjMax detection for Atom CPUs is at best marginal today. It should be
100 degrees C for your CPU, but is probably detected as 90.

I submitted an RFC patch a minute ago, trying to improve it. Maybe you
can give it a try.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
