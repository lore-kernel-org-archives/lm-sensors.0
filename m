From: r.marek@assembler.cz (Rudolf Marek)
Date: Tue, 20 Mar 2007 22:50:39 +0000
Subject: [lm-sensors] [PATCH] coretemp 1/3 Add rdmsr_safe_on_cpu and
Message-Id: <4600653F.8040000@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I will spin the new patches here, in this thread. However I dont know whom to 
address this patch - after it is well tested. Maybe I will convert the msr.c 
driver for this new calls too.

This patch adds support for _safe (exception handled) variants of rdmsr_on_cpu 
and wrmsr_on_cpu. This is needed for the new coretemp driver, which might step
into non-existing MSR (poorly documented).

Signed-of-by: Rudolf Marek <r.marek at assembler.cz>

Alexey, are you the right person to pass this to? LKML maybe?

To correct my statement about the include file:

   CHK     include/linux/version.h
   CHK     include/linux/utsrelease.h
   CC      arch/x86_64/kernel/asm-offsets.s
In file included from include/asm/processor.h:16,
                  from include/linux/prefetch.h:14,
                  from include/linux/list.h:8,
                  from include/linux/module.h:10,
                  from include/linux/crypto.h:21,
                  from arch/x86_64/kernel/asm-offsets.c:7:
include/asm/msr.h: In function 'rdmsr_safe_on_cpu':
include/asm/msr.h:179: error: 'EIO' undeclared (first use in this function)
include/asm/msr.h:179: error: (Each undeclared identifier is reported only once
include/asm/msr.h:179: error: for each function it appears in.)
include/asm/msr.h: In function 'wrmsr_safe_on_cpu':
include/asm/msr.h:183: error: 'EFAULT' undeclared (first use in this function)

Thanks,
Rudolf
-------------- next part --------------
A non-text attachment was scrubbed...
Name: add-msr-io-safe.patch
Type: text/x-patch
Size: 5442 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070320/0ede87d7/attachment-0001.bin 
