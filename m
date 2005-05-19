From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: [PATCH] Get rid of assembler code in kernel/i2c-algo-biths.c
Message-Id: <fKJxppRF.1110445717.5908390.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050310003504.GA4882@bode.aurel32.net>
In-Reply-To: <20050310003504.GA4882@bode.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Aurelien,

> There is some assembler code in kernel/i2c-algo-biths.c, which prevents
> i2c to be built on x86_64 machines. However, it still works on non-x86
> machines, as this part of the code is only built on machines that have
> rdtscl, ie x86 and x86_64 architectures.
>
> I propose to change it by C code, as in the patch attached. Please note
> that I haven't tested it "in live", as I don't have something that uses
> this module. However, I have tested it in a simple C program, and I also
> tested that i2c still build correctly.

Great you worked on this. I am all in favor of removing that assembly
code. We want i2c to be portable. Especially the bit-banging algorithm
is to be used on all platforms so it doesn't make any sense to me to
put assembly code in there.

It's normal that you have "nothing that uses this module" since is is
actually unused. This algorithm driver is meant as a drop-in replacement
for i2c-algo-bit. So you can test it by modifying a driver using
i2c-algo-bit and make it use i2c-algo-biths instead. I'll give it a try
myself this evening.

> Surprisingly the assembler code produced from the C code by gcc (3.3 in
> my case) is always (-O0 to -O3) more efficient than the asm + C code
> (see my attached file).

I am not all that surprised. gcc is producing better code over time and
versions, and compilers in general know much more about the CPU
internals than we do. Making better code than they do require very, very
good knowledge. I know some people that can do that (hi Ruik ;)) but in
the general case we are much better letting the compiler do its job.

Thanks,
--
Jean Delvare
