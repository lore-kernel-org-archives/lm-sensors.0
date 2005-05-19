From: miles.lane@gmail.com (Miles Lane)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: Who should I write to about this OOPS in 2,6,11-mm3?
Message-Id: <a44ae5cd05032120473a7170d7@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050315050746.GB13009@kroah.com>
In-Reply-To: <20050315050746.GB13009@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I think I decoded this Oops correctly.  The crash occurs before the
disk is mounted, so I am unable to access the contents of /proc/ksyms
and /proc/modules.  However, the decoding using the modules and
System.map looks reasonable.  Is the decoding accurate?

ksymoops -o /lib/modules/2.6.12-rc1-mm1/ -m
/boot/System.map-2.6.12-rc1-mm1 < oops
ksymoops 2.4.9 on i686 2.6.11-bk5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.12-rc1-mm1/ (specified)
     -m /boot/System.map-2.6.12-rc1-mm1 (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 00000000
C028bbc2
*pde = 00000000
Oops: 0000 [#1]
CPU:     0
EIP:     0060:[<c028bbc2>]   Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS:  00010282   (2.6.11-mm3)
Eax: 00000000   ebx: 00000000   ecx: 00000000   edx: f7e99504
Esi: c03f5260   edi: 00000000   ebp: f7c21fa4   esp: f7c21f90
Ds: 007b   es: 007b   ss: 0068
Stack: f7c00540 c03f5264 00000000 00000000 00000000 f7c21fbc c0480695 c03f5260
      c03724f8 c03f5140 c048d204 f7c21fd8 c04668ab c01002d0 00000000 00000000
      c01002d0 00000000 f7c21fec c0100302 0000007b 0000007b ffffffff 00000000
Call Trace:
[<c010404f>] show_stack+0x7f/0xa0
[<c01041ea>] show_registers+0x15a/0x1c0
[<c01043e0>] die+0xf0/0x190
[<c011450b>] do_page_fault+0x31b/0x670
[<c0103c83>] error_code+0x2b/0x30
[<c0480695>] i2c_dev_init+0x55/0xa0
[<c04668ab>] do_initcalls+0x2b/0xc0
[<c0100302>] init+0x32/0x130
[<c0101351>] kernel_thread_helper+0x5/0x14
Code: e5 e8 ff f6 46 2c 01 74 30 8b 1d a0 4e 3f c0 8b 03 0f 18 00 90


>>EIP; c028bbc2 <pnp_assign_mem+82/140>   <==
>>edx; f7e99504 <pg0+37936504/3fa9b400>
>>Esi; c03f5260 <__func__.2+1edc5/3adbd>
>>ebp; f7c21fa4 <pg0+376befa4/3fa9b400>
>>esp; f7c21f90 <pg0+376bef90/3fa9b400>

Trace; c010404f <irq_entries_start+183/880>
Trace; c01041ea <irq_entries_start+31e/880>
Trace; c01043e0 <irq_entries_start+514/880>
Trace; c011450b <_setbad+401/6f6>
Trace; c0103c83 <ret_from_fork+3/14>
Trace; c0480695 <texts.16+5/8>
Trace; c04668ab <__devices_8086+acb/eb0>
Trace; c0100302 <init+32/130>
Trace; c0101351 <kernel_thread_helper+5/14>

Code;  c028bbc2 <pnp_assign_mem+82/140>
00000000 <_EIP>:
Code;  c028bbc2 <pnp_assign_mem+82/140>   <==   0:   e5 e8                     in     $0xe8,%eax   <==Code;  c028bbc4 <pnp_assign_mem+84/140>
   2:   ff f6                     push   %esi
Code;  c028bbc6 <pnp_assign_mem+86/140>
   4:   46                        inc    %esi
Code;  c028bbc7 <pnp_assign_mem+87/140>
   5:   2c 01                     sub    $0x1,%al
Code;  c028bbc9 <pnp_assign_mem+89/140>
   7:   74 30                     je     39 <_EIP+0x39>
Code;  c028bbcb <pnp_assign_mem+8b/140>
   9:   8b 1d a0 4e 3f c0         mov    0xc03f4ea0,%ebx
Code;  c028bbd1 <pnp_assign_mem+91/140>
   f:   8b 03                     mov    (%ebx),%eax
Code;  c028bbd3 <pnp_assign_mem+93/140>
  11:   0f 18 00                  prefetchnta (%eax)
Code;  c028bbd6 <pnp_assign_mem+96/140>
  14:   90                        nop

<0>Kernel panic ??" not syncing: Attempted to kill init!

1 error issued.  Results may not be reliable.
