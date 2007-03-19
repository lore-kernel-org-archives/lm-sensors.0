From: adobriyan@sw.ru (Alexey Dobriyan)
Date: Mon, 19 Mar 2007 14:17:02 +0000
Subject: [lm-sensors] coretemp - take3
Message-Id: <20070319141702.GA6805@localhost.sw.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <45FDC7A4.9070601@assembler.cz>
In-Reply-To: <45FDC7A4.9070601@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Mar 19, 2007 at 07:31:11AM +0100, Rudolf Marek wrote:
> Maybe OpenVZ needs both safe and unsafe variants in msr-on-cpu?

Frankly I don't understand when one should use rdmsr_safe() instead of
rdmsr(). p4-clockmod driver worked fine with plain rdmsr/wrmsr.
For general education, why this driver uses _safe functions?

What's wrong with http://ssh.cz/~ruik/patches/add-msr-io-safe.patch
is:
a) naming: _on_cpu is suffix and thus should be last
	FOO(...) => FOO_on_cpu(unsigned int cpu, ...)

b) static qualifier should be first.
c) coding style in wrmsr_on_cpu/rdmsr_on_cpu/...

	static int foo(...)
	{
		...
	}

d) +#include <linux/errno.h>

	what for? those dummy inlines don't include -E*

> >> On URL bellow is current version of coretemp driver.
> >>
> >> http://ssh.cz/~ruik/patches/
> >>
> >> What was fixed? I fixed the issues Jean pointed out, I created separate patch
> >> for ...msr_safe stuff.
> >>   
> > In arch/i386/lib/msr-on-cpu.c, I'm not sure if you really need to create
> > 2 versions of the functions (safe and unsafe). Anyway, no one uses these
> > functions in the kernel yet, so I think you can simply convert them to
> > safe versions.
> 
> 
> -snip-
> 
> I will answer the rest in the evening.


