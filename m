From: Juerg Haefliger <juergh@gmail.com>
Date: Mon, 23 Feb 2009 15:53:09 +0000
Subject: Re: [lm-sensors] module c7temp shows voltage, but no temperature
Message-Id: <191fb4ca0902230753pf339a06vb4863600a083d235@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200902221052.31780.justin@justinzane.com>
In-Reply-To: <200902221052.31780.justin@justinzane.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Michael,

On Sun, Feb 22, 2009 at 12:27 PM, Michael Reinelt <michael@reinelt.co.at> wrote:
> Hi Justin,
>
>> As I understand, VIA has not released documentation to the lm-sensors
>> developers on the latest revisions of the C7.
> too bad...
>
>> I believe that it is
>> helpful if you post the output of cpuid with your info, but I forget
>> which switch(es) to use.
>
> Well, as far as I con see, my version of cpuid doesn't have any switches
> at all :-)
>
> so here's the output:
>
> artus.reinelt.local:~ # cpuid
>  eax in    eax      ebx      ecx      edx
> 00000000 00000001 746e6543 736c7561 48727561
> 00000001 000006d0 00000800 00004181 a7c9bbff
> 80000000 80000006 00000000 00000000 00000000
> 80000001 00000000 00000000 00000000 00100000
> 80000002 20202020 20202020 20202020 20202020
> 80000003 20202020 56202020 43204149 72502037
> 80000004 7365636f 20726f73 30303531 007a484d
> 80000005 00000000 08800880 40040140 40040140
> 80000006 00000000 00000000 0080a140 00000000
>
> Vendor ID: "CentaurHauls"; CPUID level 1
>
> Unknown vendor


You need a newer cpuid to display some additional data:
http://freshmeat.net/redir/cpuid_2/63002/url_tgz/cpuid-20060917.src.tar.gz

...juerg

>
> and the output of cat /proc/cpuinfo:
>
> artus.reinelt.local:~ # cat /proc/cpuinfo
> processor       : 0
> vendor_id       : CentaurHauls
> cpu family      : 6
> model           : 13
> model name      : VIA C7 Processor 1500MHz
> stepping        : 0
> cpu MHz         : 800.000
> cache size      : 128 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> cmov pat clflush acpi mmx fxsr sse sse2 tm nx pni est tm2 xtpr rng
> rng_en ace ace_en ace2 ace2_en phe phe_en pmm pmm_en
> bogomips        : 1599.86
> clflush size    : 64
> power management:
>
>
> HTH, Michael
>
> --
> Michael Reinelt <michael@reinelt.co.at>
> http://home.pages.at/reinelt
> GPG-Key 0xDF13BA50
> ICQ #288386781
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
