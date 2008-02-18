From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 18 Feb 2008 22:46:33 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Skip "random" I/O port
Message-Id: <1203374793.6740.33.camel@pasglop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080218223317.2142dc16@hyperion.delvare>
In-Reply-To: <20080218223317.2142dc16@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


On Mon, 2008-02-18 at 22:33 +0100, Jean Delvare wrote:

> The idea is to skip "random" I/O port probing on PPC, as it won't find
> anything anyway and can cause the kernel to oops.

To be more precise, it can cause the chip to access random parts of the
address space that will result in machine checks or worse.

The fact that it oopses instead of SIGBUS is an unfortunate side effect
of those accesses being done by the kernel and not by userland, and not
being marked as recoverable in the exception tables. We could try to fix
-that- though it would still be fairly unreliable as that sort of
machine check tends to be asynchronous, and that wouldn't fix the
problem that on non-x86 arch, it's not uncommon to have completely
different bits of HW around those ports.

So I believe the only thing that should be allowed on powerpc is to
probe "known" areas, that is, places where you know there is something
to be found, typically via the device-tree provided by the platform or
the firmware.

> Christian, can you please test this patch and confirm that it solves
> your problem?
> 
> Ben, can you please comment on this patch? I'm not familiar with the
> PPC architecture at all so I'm not sure if I am looking for the right
> strings.

I think ppc and ppc64 are what you get.

Cheers,
Ben.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
