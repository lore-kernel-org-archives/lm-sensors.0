From: Jeremy Fitzhardinge <jeremy@goop.org>
Date: Wed, 06 Jun 2007 19:50:41 +0000
Subject: Re: [lm-sensors] 2.6.22-rc4-mm1 -- ERROR:
Message-Id: <46671011.6090008@goop.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <a44ae5cd0706061058u3566e0a4yf178b9e473d17395@mail.gmail.com>
In-Reply-To: <a44ae5cd0706061058u3566e0a4yf178b9e473d17395@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Andrew Morton wrote:
> On Wed, 6 Jun 2007 10:58:34 -0700 "Miles Lane" <miles.lane@gmail.com> wrote:
>
>   
>>   RELOCS  arch/i386/boot/compressed/vmlinux.relocs
>> WARNING: Absolute relocations present
>> Offset     Info     Type     Sym.Value Sym.Name
>> c0102029 00535201   R_386_32 00000000  xen_irq_disable_direct_reloc
>> c0102043 00722e01   R_386_32 00000000  xen_save_fl_direct_reloc
>>     

I don't know why these two are coming out absolute.  I think they should
be relative.  I'll see what I can do.

>> c040f81c 0064f101   R_386_32 c045a4a4  __per_cpu_end
>> c040f821 00588001   R_386_32 c0453000  __per_cpu_start
>> c040f82d 00588001   R_386_32 c0453000  __per_cpu_start
>>     

These are due to the definition of PERCPU in
include/asm-generic/vmlinux.lds.h.  It should read:

#define PERCPU(align)							\
	. = ALIGN(align);						\
	.data.percpu  : AT(ADDR(.data.percpu) - LOAD_OFFSET) {		\
		__per_cpu_start = .;					\
		*(.data.percpu)						\
		*(.data.percpu.shared_aligned)				\
		__per_cpu_end = .;					\
	}


ie, __per_cpu_start/end should be inside the section, rather than
floating about between sections.

> The others _might_ have
> been triggered by use-the-new-percpu-interface-for-shared-data.patch and
> define-new-percpu-interface-for-shared-data.patch,
define-new-percpu-interface-for-shared-data.patch is the source of the
bad definition of PERCPU.

    J

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
