From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Tue, 28 Jun 2011 06:33:22 +0000
Subject: Re: [lm-sensors] [3.0 regression?] coretemp driver output has
Message-Id: <D6D887BA8C9DFF48B5233887EF04654109E84A6589@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1679233363.543867.1308943464300.JavaMail.mail@webmail20>
In-Reply-To: <1679233363.543867.1308943464300.JavaMail.mail@webmail20>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Tashkinov,

I am looking into this issue.
Could you please provide us the output of (2)

1)cd /sys/devices/platform/coretemp.0/
2)grep . *

Also, Is you kernel booted with SMP option enabled ?

Thanks,
Durga
> -----Original Message-----
> From: Guenter Roeck [mailto:guenter.roeck@ericsson.com]
> Sent: Tuesday, June 28, 2011 2:15 AM
> To: R@imr4.ericy.com; R, Durgadoss
> Cc: Artem S. Tashkinov; lm-sensors@lm-sensors.org; Yu, Fenghua
> Subject: Re: [lm-sensors] [3.0 regression?] coretemp driver output has
> seemingly broken
> 
> Hi Durga,
> 
> can you have a look at this ? I am a bit puzzled how it can happen.
> 
> Thanks,
> Guenter
> 
> On Fri, 2011-06-24 at 15:24 -0400, Artem S. Tashkinov wrote:
> > Hello,
> >
> > My 3.0-rc4 kernel `sensors` command reports this:
> >
> > $ sensors
> > coretemp-isa-0000
> > Adapter: ISA adapter
> > Physical id 0:  +37.0 C  (high = +80.0 C, crit = +99.0 C)
> > Core 0:         +32.0 C  (high = +80.0 C, crit = +99.0 C)
> > Core 3:         +32.0 C  (high = +80.0 C, crit = +99.0 C)
> >
> > Whereas on kernel 2.6.39.x I had four separate cores reported without the
> > nonsensical "Physicial id 0" item.
> >
> > I have an Intel Core i5 2500 CPU.
> >
> > processor       : 0
> > vendor_id       : GenuineIntel
> > cpu family      : 6
> > model           : 42
> > model name      : Intel(R) Core(TM) i5-2500 CPU @ 3.30GHz
> > stepping        : 7
> > cpu MHz         : 1600.000
> > cache size      : 6144 KB
> > physical id     : 0
> > siblings        : 4
> > core id         : 0
> > cpu cores       : 4
> > apicid          : 0
> > initial apicid  : 0
> > fdiv_bug        : no
> > hlt_bug         : no
> > f00f_bug        : no
> > coma_bug        : no
> > fpu             : yes
> > fpu_exception   : yes
> > cpuid level     : 13
> > wp              : yes
> > flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov
> > pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx rdtscp lm
> > constant_tsc arch_perfmon pebs bts xtopology nonstop_tsc aperfmperf pni
> > pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm sse4_1
> > sse4_2 x2apic popcnt aes xsave avx lahf_lm ida arat epb xsaveopt pln pts dts
> > tpr_shadow vnmi flexpriority ept vpid
> > bogomips        : 6603.50
> > clflush size    : 64
> > cache_alignment : 64
> > address sizes   : 36 bits physical, 48 bits virtual
> > power management:
> >
> > ***
> >
> > This problem is tracked at the kernel's bugzilla:
> https://bugzilla.kernel.org/show_bug.cgi?id8202
> >
> > _______________________________________________
> > lm-sensors mailing list
> > lm-sensors@lm-sensors.org
> > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
