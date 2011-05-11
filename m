From: Luca Tettamanti <kronos.it@gmail.com>
Date: Wed, 11 May 2011 12:43:35 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <20110511124334.GA23421@nb-core2.darkstar.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, May 10, 2011 at 10:05:29AM -0500, Jeff Rickman wrote:
> On 5/10/2011 9:24 AM, Jean Delvare wrote:
> >Hi Jeff,
> >
> >On Tue, 10 May 2011 08:54:21 -0500, Jeff Rickman wrote:
> >>I checked for any packages that could manipulate the CPU frequency. I
> >>only found "cpuspeed". I removed the "cpuspeed" package and rebooted to
> >>ensure a known state. Attempting to install the "stock i8k" module
> >>causes a crash. Reboot to return to known state.
> >>
> >>I changed the "maxcpus=4" in "grub.conf" to "maxcpus=1". Reboot.
> >>
> >>Attempt to load "stock i8k" module. Crash. "/proc/cpuinfo" shows 1 CPU.
> >
> >Care to try again with maxcpus=0? I seem to recall that this disables
> >even more of SMP than maxcpus=1 does.
> >
> >>Return system to previous configuration with "cpuspeed" and reboot.
> >>
> >>My only other choice would be to physically pull CPU2, leaving CPU1 in
> >>the system, but we know that config should work based on Harry's testing.
> >
> >We don't, actually. You have different software environments and maybe
> >different BIOS options. And not exactly the same hardware either...
> >
> >But I totally understand that you don't want to physically remove the
> >second CPU. I'm not even sure if that would help.
> >
> >OTOH, if you see an option in the BIOS to disable HT, that would be
> >worth trying.
> >
> 
> Slightly different crash with "maxcpus=0". See attached.

From the log:

> [   74.591343] invalid opcode: 0000 [#1] SMP
[...]
> [   74.592309] Code: 52 8b 58 04 8b 48 08 8b 50 0c 8b 70 10 8b 78 14 58 e6 b2 e6 84 48 87 04 24 89 58 04 89 48 08 89 50 0c 89 70 10 89 78 14 5a 89 10 <9f> c1 e8 08 83 e0 01 85 c0 ba ea ff ff ff 75 0f 41 8b 08 66 83
> May 10 09:54:59 XX kernel: [   74.592309] RIP  [<ffffffffa0362041>] i8k_smm+0x41/0x65 [i8k]

   0:   52                      push   %rdx
   1:   8b 58 04                mov    0x4(%rax),%ebx
   4:   8b 48 08                mov    0x8(%rax),%ecx
   7:   8b 50 0c                mov    0xc(%rax),%edx
   a:   8b 70 10                mov    0x10(%rax),%esi
   d:   8b 78 14                mov    0x14(%rax),%edi
  10:   58                      pop    %rax
  11:   e6 b2                   out    %al,$0xb2
  13:   e6 84                   out    %al,$0x84
  15:   48 87 04 24             xchg   %rax,(%rsp)
  19:   89 58 04                mov    %ebx,0x4(%rax)
  1c:   89 48 08                mov    %ecx,0x8(%rax)
  1f:   89 50 0c                mov    %edx,0xc(%rax)
  22:   89 70 10                mov    %esi,0x10(%rax)
  25:   89 78 14                mov    %edi,0x14(%rax)
  28:   5a                      pop    %rdx
  29:   89 10                   mov    %edx,(%rax)
  2b:*  9f                      lahf        <-- trapping instruction
  2c:   c1 e8 08                shr    $0x8,%eax
  2f:   83 e0 01                and    $0x1,%eax
  32:   85 c0                   test   %eax,%eax
  34:   ba ea ff ff ff          mov    $0xffffffea,%edx
  39:   75 0f                   jne    0x4a
  3b:   41 8b 08                mov    (%r8),%ecx

lahf is present in the assembly block inside the driver in i8k_smm; lahf
moves the lowest byte of eflags into ah.
Wikipedia[1] tells me that:

  Early AMD64 and Intel 64 CPUs lacked LAHF and SAHF instructions. AMD
  introduced the instructions with their Athlon 64, Opteron and Turion 64
  revision D processors in March 2005 while Intel introduced
  the instructions with the Pentium 4 G1 stepping in December 2005.

Jeff's CPU does indeed lack lahf (see cpuinfo), so the driver should not
unconditionally use the intruction.
The driver should check X86_FEATURE_LAHF_LM or use use a different
method to read EFLAFS (pushf?).

drivers/char/toshiba.c (tosh_smm) also suffers from the same issue.

Luca
[1] http://en.wikipedia.org/wiki/X86-64

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
