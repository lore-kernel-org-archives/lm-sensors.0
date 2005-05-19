From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: VRM(VRD) detection versus CPUID
Message-Id: <200407021019.i62AJVp2052430@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0406301920320.26054@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0406301920320.26054@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>And what about INTEL_VRM_10x I assigned 10 which is not good Idea it is
>lower than 80. Should I do 100 ?

Yes, use 100. That's already what MDS did if I'm not mistaking.

>One more question about the architecture dispatcher. I think I cannot do
>any runtime manager. Because I'm using struct cpuinfo_x86 *c = cpu_data;
>And if the module insterted on PPC the symbol wont be there..
>
>Defined as a preprocessor macro in:
>
>    * include/asm-sh/processor.h, line 73
>    * include/asm-um/processor-generic.h, line 140
>    * include/asm-x86_64/processor.h, line 86
>    * include/asm-sparc/cpudata.h, line 24
>    * include/asm-i386/processor.h, line 93
>    * include/asm-ia64/processor.h, line 194
>    * include/asm-sparc64/cpudata.h, line 28
>
>In attachment is what I have now. There is one stupid #ifdef.

Yes, it's definitely compile-time stuff. You compile for a given
architecture anyway! So what you did is fine.

Thanks,
Jean Delvare
