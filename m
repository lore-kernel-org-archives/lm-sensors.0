From: "Juerg Haefliger" <juergh@gmail.com>
Date: Mon, 01 Oct 2007 18:45:30 +0000
Subject: Re: [lm-sensors] dme1737 module
Message-Id: <191fb4ca0710011145j4c39855cl3be11926caeab250@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
In-Reply-To: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Juergen,


> > -----Urspr=FCngliche Nachricht-----
> > Von: "Juerg Haefliger" <juergh@gmail.com>
>
>
> >
> > > The type of my cpu  is very new.  At boot up, the bios displays "unkn=
own
> > > cpu type". So, this might be the reason why it does not know how to h=
andle
> > > the sensor output.
> >
> > Can you send the output of 'cat /proc/cpuinfo'?
> >
>
> It is a amd athlon x2 BE-2350
>
> jba@lisa:~$ cat /proc/cpuinfo
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 15
> model           : 107
> model name      : AMD Processor model unknown
> stepping        : 1
> cpu MHz         : 1000.000
> cache size      : 512 KB
> physical id     : 0
> siblings        : 2
> core id         : 0
> cpu cores       : 2
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mc=
a cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt lm=
 3dnowext 3dnow pni cx16 lahf_lm cmp_legacy svm cr8legacy ts fid vid ttp tm=
 stc [6]
> bogomips        : 2011.01
>
> processor       : 1
> vendor_id       : AuthenticAMD
> cpu family      : 15
> model           : 107
> model name      : AMD Processor model unknown
> stepping        : 1
> cpu MHz         : 1000.000
> cache size      : 512 KB
> physical id     : 0
> siblings        : 2
> core id         : 1
> cpu cores       : 2
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mc=
a cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt lm=
 3dnowext 3dnow pni cx16 lahf_lm cmp_legacy svm cr8legacy ts fid vid ttp tm=
 stc [6]
> bogomips        : 2011.01
>

No specs available for this processor, sorry.

...juerg


> Juergen
> _____________________________________________________________________
> Der WEB.DE SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
> http://smartsurfer.web.de/?mc=100071&distributionid=000000000066
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
