From: Dean Nelson <dnelson@redhat.com>
Date: Mon, 25 Jul 2011 19:57:16 +0000
Subject: Re: [lm-sensors] modprobe of dme1737 on a ppc64 system results in
Message-Id: <4E2DCA9C.4010409@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4E262B97.40809@redhat.com>
In-Reply-To: <4E262B97.40809@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/22/2011 03:23 PM, Jean Delvare wrote:
> Hi Dean,
>
> On Tue, 19 Jul 2011 20:12:55 -0500, Dean Nelson wrote:
>> I was told that a modprobe of dme1737 on a ppc64 system running RHEL5
>> would cause the kernel to Oops. And indeed it did. I found this was
>> also the case on RHEL6, and the latest linux-3.0.
>>
>> It occurs when:
>>     dme1737_init() calls
>>     dme1737_isa_detect(0x2e,&addr) calls
>>     dme1737_isa_sio_enter(sio_cip=0x2e) calls
>>     outb(0x55, sio_cip=0x2e)
>>
>> And outb() goes through some macro transformations into out_8(),
>> which does a store byte indexed assembly (stbx) instruction. Along
>> the way the port number (0x2e) is changed into an address to
>> which the value 0x55 is stored. The address is based on:
>>
>>     addr = pci_io_base + port      // on RHEL5
>>     addr = _IO_BASE + port         // on RHEL6 and linux-3.0
>>
>> With RHEL5 on the system I was running, pci_io_base was set to
>> 0xd000080000000000. And with RHEL6 and linux-3.0, _IO_BASE was also
>> set to 0xd000080000000000.
>
> Thanks for raising this problem, this is the first time I hear about it.
>
>> There are other hwmon drivers that also Oops on a ppc64 system when
>> modprobed. Some of them encounter the Oops when executing inb()/in_8().
>> The following are the drivers that I confirmed oops and the args passed
>> into in_8() or out_8().
>>
>>     drivers/hwmon/dme1737.ko    out_8(addr=0xd00008000000002e, val=0x55)
>>     drivers/hwmon/f71805f.ko    out_8(addr=0xd00008000000002e, val=0x87)
>>     drivers/hwmon/lm78.ko        in_8(addr=0xd000080000000291)
>>     drivers/hwmon/pc87427.ko    out_8(addr=0xd00008000000002e, val=0x20)
>>     drivers/hwmon/vt1211.ko     out_8(addr=0xd00008000000002e, val=0x87)
>
> Of these, lm78 is different, the chip is an ISA device, when all other
> drivers are for more recent LPC (Super-I/O) devices. It should be fixed
> in a similar way as the w83781d driver was fixed: putting the
> problematic code inside #ifdef CONFIG_ISA/#endif.
>
>> It's been reported that there are a number of other hwmon drivers that
>> exhibit the same behavior, but I've not confirmed that.
>
> Indeed, f71882fg, it87, pc87360, sis5595, smsc47b397, smsc47m1,
> w83627ehf and w83627hf certainly have the same problem.
>
>>
>> All three kernels have an isa_io_base variable and where it is
>> defined in the code is a comment that says: /* NULL if no ISA bus */.
>> (In RHEL5, defined in arch/powerpc/kernel/pci_64.c; and in RHEL6 and
>> linux-3.0, it's in arch/powerpc/kernel/isa-bridge.c.) On the system
>> I was running on it was always NULL.
>>
>> So how should this issue be resolved? I can think of three
>> directions one could head in:
>>
>>     . Don't build these drivers for systems that don't have an ISA bus.
>
> Works for lm78, not for other drivers which don't depend on the ISA bus
> (x86_64 has no ISA bus but needs these drivers.)
>
> For the other drivers, I think we should simply not build them on
> PPC64, as I don't think they are needed there at all. In fact I am
> unsure if any of the affected driver is needed on an architecture not
> x86 or x86_64.
>
>>
>>     . Make a check for an ISA address and no ISA bus reside in the
>>       callers to outb()/inb()
>
> Are there any other drivers doing this?

Not that I'm aware of. Just indicating that it is one way to address
the problem (though perhaps not a very good way).


>>     . Make such a check reside in outb()/inb().
>
> This would be very, very expensive at run-time, so I don't think it is
> an option at all.

Agreed. Just listing this means of addressing the problem for
completeness.


>> I tried adding 'ISA' to the 'depends on' lines for the above
>> drivers in drivers/hwmon/Kconfig. That worked for the ppc64 system
>> I was running on, but I don't know if it's really a valid approach.
>> The various CONFIGs (e.g., 'ISA_DMA_API') and the setting of such on
>> the various architectures is something that is a mystery to me. But if
>> there was something that could be used (like 'ISA'), the first option
>> above would seem to be the simplest one to take.
>
> ISA can't be used for the reason given above, and I am unfortunately
> not aware of any other option that could be used instead.
>
>> The third option, might look something like...
>>
>> For CONFIG_PPC64 on RHEL6 and linux-3.0, I found in the following
>> function arch/powerpc/include/asm/pci-bridge.h:
>>
>> static inline int isa_vaddr_is_ioport(void __iomem *address)
>> {
>>           /* Check if address hits the reserved legacy IO range */
>>           unsigned long ea = (unsigned long)address;
>>           return ea>= ISA_IO_BASE&&  ea<  ISA_IO_END;
>> }
>>
>> And when I was running on these kernels I found,
>>
>>     ISA_IO_BASE = 0xd000080000000000
>>     ISA_IO_END  = 0xd000080000010000
>>
>> So perhaps DEF_MMIO_OUT_BE(), which is what produces out_8() and is
>> found in arch/powerpc/include/asm/io.h, could be changed to something
>> like:
>>
>> #define DEF_MMIO_OUT_BE(name, size, insn)                               \
>> static inline void name(volatile u##size __iomem *addr, u##size val)    \
>> {                                                                       \
>>          if (!isa_vaddr_is_ioport(addr) || isa_io_base) {                 \
>>                   __asm__ __volatile__("sync;"#insn"%U0%X0 %1,%0"         \
>>                           : "=m" (*addr) : "r" (val) : "memory");         \
>>                   IO_SET_SYNC_FLAG();                                     \
>>          }                                                                \
>> }
>>
>> And the others, like DEF_MMIO_IN_BE(), in a similar way.
>
> This sounds pretty complex, to solve a problem which isn't as far as I
> can see.
>
>> But I really must say that I know nothing about ppc systems. This was my
>> first exposure to them. So the above might be pure nonsense. Besides, it
>> doesn't begin to address the other architectures that might have issues
>> with reading/writing ISA addresses when there is no ISA bus.
>>
>> So, again, how should this issue be resolved?
>
> I know nothing about ppc either, but I'm sure we would know if these
> systems needed these drivers. So the easy fix is to simply make all
> offending drivers depend on !PPC. Or be even bolder and make them
> depend on X86. I'm sure we'll know soon enough if any other
> architecture is suddenly missing a driver they were using (IA64 maybe)
> I'm fine both ways.

I didn't feel very bold, so I went with !PPC. Just posted a patch to
lm-sensors.


> And for lm78 we want a specific fix, copied from w83781d (not sure why
> this wasn't done already.) I'll do that, I can test this driver.

Thank you.

Dean


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
