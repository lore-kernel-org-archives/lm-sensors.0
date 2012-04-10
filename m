From: Michael Weingartner <michael.weingartner@tuwien.ac.at>
Date: Tue, 10 Apr 2012 12:04:18 +0000
Subject: [lm-sensors] Fwd: Re:  ASUS Kfn4-dre
Message-Id: <20120410140418.106010n5gr5lwsle@webmail.tuwien.ac.at>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo,

Can someone help please?

regards
mike

----- Weitergeleitete Nachricht von guenter.roeck@ericsson.com -----
      Datum: Thu, 5 Apr 2012 08:49:45 -0700
        Von: Guenter Roeck <guenter.roeck@ericsson.com>
    Betreff: Re: [lm-sensors] ASUS Kfn4-dre
         An: Michael Weingartner <michael.weingartner@tuwien.ac.at>
         Cc: lm-sensors@lm-sensors.org

On Thu, Apr 05, 2012 at 08:48:46AM -0700, Guenter Roeck wrote:
> On Thu, Apr 05, 2012 at 11:28:54AM -0400, Michael Weingartner wrote:
> > Hallo,
> >
> Ah, and you dropped the mailing list. Didn't notice that either.
>
> Again, please don't top-post, and don't drop the mailing list.  
> Others might be
> able to help.
>
... and I forgot to add it back in. Doing that now.

> > It says:
> > cat /proc/cpuinfo
> > processor	: 0
> > vendor_id	: AuthenticAMD
> > cpu family	: 15
> > model		: 65
> > model name	: Dual-Core AMD Opteron(tm) Processor 2212
> > stepping	: 2
> > cpu MHz		: 1000.000
> > cache size	: 1024 KB
> > physical id	: 0
> > siblings	: 2
> > core id		: 0
> > cpu cores	: 2
> > apicid		: 0
> > initial apicid	: 0
> > fdiv_bug	: no
> > hlt_bug		: no
> > f00f_bug	: no
> > coma_bug	: no
> > fpu		: yes
> > fpu_exception	: yes
> > cpuid level	: 1
> > wp		: yes
> > flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> > pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
> > rdtscp lm 3dnowext 3dnow extd_apicid pni cx16 lahf_lm cmp_legacy svm
> > extapic cr8_legacy
> > bogomips	: 2010.44
> > clflush size	: 64
> > cache_alignment	: 64
> > address sizes	: 40 bits physical, 48 bits virtual
> > power management: ts fid vid ttp tm stc
> >
> > processor	: 1
> > vendor_id	: AuthenticAMD
> > cpu family	: 15
> > model		: 65
> > model name	: Dual-Core AMD Opteron(tm) Processor 2212
> > stepping	: 2
> > cpu MHz		: 1000.000
> > cache size	: 1024 KB
> > physical id	: 0
> > siblings	: 2
> > core id		: 1
> > cpu cores	: 2
> > apicid		: 1
> > initial apicid	: 1
> > fdiv_bug	: no
> > hlt_bug		: no
> > f00f_bug	: no
> > coma_bug	: no
> > fpu		: yes
> > fpu_exception	: yes
> > cpuid level	: 1
> > wp		: yes
> > flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> > pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
> > rdtscp lm 3dnowext 3dnow extd_apicid pni cx16 lahf_lm cmp_legacy svm
> > extapic cr8_legacy
> > bogomips	: 2010.44
> > clflush size	: 64
> > cache_alignment	: 64
> > address sizes	: 40 bits physical, 48 bits virtual
> > power management: ts fid vid ttp tm stc
> >
> > processor	: 2
> > vendor_id	: AuthenticAMD
> > cpu family	: 15
> > model		: 65
> > model name	: Dual-Core AMD Opteron(tm) Processor 2212
> > stepping	: 2
> > cpu MHz		: 1000.000
> > cache size	: 1024 KB
> > physical id	: 1
> > siblings	: 2
> > core id		: 0
> > cpu cores	: 2
> > apicid		: 2
> > initial apicid	: 2
> > fdiv_bug	: no
> > hlt_bug		: no
> > f00f_bug	: no
> > coma_bug	: no
> > fpu		: yes
> > fpu_exception	: yes
> > cpuid level	: 1
> > wp		: yes
> > flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> > pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
> > rdtscp lm 3dnowext 3dnow extd_apicid pni cx16 lahf_lm cmp_legacy svm
> > extapic cr8_legacy
> > bogomips	: 2010.44
> > clflush size	: 64
> > cache_alignment	: 64
> > address sizes	: 40 bits physical, 48 bits virtual
> > power management: ts fid vid ttp tm stc
> >
> > processor	: 3
> > vendor_id	: AuthenticAMD
> > cpu family	: 15
> > model		: 65
> > model name	: Dual-Core AMD Opteron(tm) Processor 2212
> > stepping	: 2
> > cpu MHz		: 1000.000
> > cache size	: 1024 KB
> > physical id	: 1
> > siblings	: 2
> > core id		: 1
> > cpu cores	: 2
> > apicid		: 3
> > initial apicid	: 3
> > fdiv_bug	: no
> > hlt_bug		: no
> > f00f_bug	: no
> > coma_bug	: no
> > fpu		: yes
> > fpu_exception	: yes
> > cpuid level	: 1
> > wp		: yes
> > flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> > pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
> > rdtscp lm 3dnowext 3dnow extd_apicid pni cx16 lahf_lm cmp_legacy svm
> > extapic cr8_legacy
> > bogomips	: 2010.44
> > clflush size	: 64
> > cache_alignment	: 64
> > address sizes	: 40 bits physical, 48 bits virtual
> > power management: ts fid vid ttp tm stc
> >
> You might see "Temperature readouts might be wrong - check erratum  
> #141" in your dmesg log.
> Other than that, I have no idea right now what might be going on.  
> Maybe someone else can help.
>
> Guenter
>
> > regards
> > mike
> >
> > Zitat von Guenter Roeck <guenter.roeck@ericsson.com>:
> >
> > > On Thu, Apr 05, 2012 at 10:46:42AM -0400, Michael Weingartner wrote:
> > >> Hallo,
> > >>
> > >> thanks for reply.
> > >> I use  2.6.35-32-generic-pae
> > >> 32 bit
> > >>
> > > Please don't top-post.
> > >
> > > This kernel version includes the following patches:
> > >
> > > 4427834 hwmon: (k8temp) Differentiate between AM2 and ASB1
> > > d535bad hwmon: (k8temp) Fix temperature reporting for ASB1 processor
> > > revisions
> > >
> > > which suggests that the readings with the older kernel may have been
> > > too high.
> > >
> > > Since this is a server, another possibility might be that the CPU type is
> > > detected wrongly as ASB1. What do you see in /proc/cpuinfo ?
> > >
> > > Thanks,
> > > Guenter
> > >
> > >> regards,
> > >> mike
> > >>
> > >>
> > >> Zitat von Guenter Roeck <guenter.roeck@ericsson.com>:
> > >>
> > >> > On Thu, Apr 05, 2012 at 09:42:19AM -0400, Michael Weingartner wrote:
> > >> >> Dear Ladies and Gentlemen,
> > >> >>
> > >> >> I have a asus kfn4-dre serverboard. I use lm-sensors form ubuntu
> > >> >> repositories.
> > >> >> With ubuntu 8.04 LTS. I had with full CPU load 55-60 degrees celsius.
> > >> >>
> > >> >> I have done a distributionupgrade to 10.04 LTS and I use a
> > >> backport kernel.
> > >> >>
> > >> > Nice, but all you are saying is that you use a kernel later than
> > >> > 2.6.32, but not exactly
> > >> > which one. Not very helpful.
> > >> >
> > >> >> I have done a "sensors-detect" and now I have 40-50 degree celsius
> > >> >> with k8temps CPU.
> > >> >>
> > >> > There were several changes in the driver over time to fix wrong
> > >> > temperature readings.
> > >> > Which ones affect your kernel are impossible to say without knowing
> > >> > the exact kernel version.
> > >> >
> > >> > Guenter
> > >> >
> > >>
> > >>
> > >>
> > >
> >
> >
> >


----- Ende der weitergeleiteten Nachricht -----



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
