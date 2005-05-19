From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: VRM(VRD) detection versus CPUID
Message-Id: <Pine.LNX.4.58.0407021204130.26054@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0406301920320.26054@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0406301920320.26054@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



On Fri, 2 Jul 2004, Jean Delvare wrote:

> We will have to find one. If none we have to pick an arbitrary number,
> much like was done for AMD. If possible, pick one which makes some sense
> and is not likely to be needed later (i.e. < 80).

And what about INTEL_VRM_10x I assigned 10 which is not good Idea it is
lower than 80. Should I do 100 ?

One more question about the architecture dispatcher. I think I cannot do
any runtime manager. Because I'm using struct cpuinfo_x86 *c = cpu_data;
And if the module insterted on PPC the symbol wont be there..

Defined as a preprocessor macro in:

    * include/asm-sh/processor.h, line 73
    * include/asm-um/processor-generic.h, line 140
    * include/asm-x86_64/processor.h, line 86
    * include/asm-sparc/cpudata.h, line 24
    * include/asm-i386/processor.h, line 93
    * include/asm-ia64/processor.h, line 194
    * include/asm-sparc64/cpudata.h, line 28

In attachment is what I have now. There is one stupid #ifdef.
Two hours left before I leave :)

Regards

Rudolf
-------------- next part --------------
A non-text attachment was scrubbed...
Name: cpuidvrm2.c
Type: text/x-csrc
Size: 2495 bytes
Desc: here
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040702/aecca7d3/cpuidvrm2.bin
