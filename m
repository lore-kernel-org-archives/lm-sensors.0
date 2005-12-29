From: daniel.n.nilsson@home.se (Daniel Nilsson)
Date: Thu, 29 Dec 2005 17:04:03 +0000
Subject: [lm-sensors] Kernel hangs with i2c-i801 driver?
Message-Id: <20051229180403.sgz068mnvpcw04ww@oden.homeip.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051123100021.GA29473@oden.homeip.net>
In-Reply-To: <20051123100021.GA29473@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

Sorry for the delay, I'm on vacation and I only have remote access to the
machine right now so I'm cautious what I experiement with since I can't press
the reset button:-)

Quoting Rudolf Marek <r.marek at sh.cvut.cz>:

> The real question is WHAT is failing. What exactly in the SMM mode 
> handler will fail...
> This is very hard to debug, perhaps with the need of real hardware debugger.
>
> So we have two ways how to handle this:
>
> Method 1) to disable the SMI via GPI7

This is probably fine for me, though it feels like putting a patch on the
sympton instead of the cause. But I realize fixing the cause might be
impossible without access to the BIOS source code and a hardware debugger.

> we need to know:
> 1) how to identify this motherboard, (DMI, PCI subsystem ID 
> (subsystem ID is needed to ask them))
> 2) will the disabled SMI affect the emergency shutdown of CPU?
>   (we can answer this by ourselfs, I think the W83792D has OVT pin for this)
>    Better to have it confirmed.
>
> 3) then we will develop a patch to quirks.c

I can ask this from Gigabyte once we know this is the approach we want 
to take.

> Method 2) try to uncover why the SMI failes
>   This is very difficult. Maybe we can ask them for some special bios version
>   with modified SMM handler to see if it fails too.
>
>   We can ask them to provide the SMM BIOS handler code and try to 
> look around...

I suppose we could ask this but maybe I should just ask them to reproduce the
problem on Linux themselves and tell me why it fails? In order to do so though
I feel like we need to be pretty sure that the bug is not in Linux code but in
code installed by their BIOS. Is there a way to prove that?

>   Are you using USB keyboard or mouse?
>   (SMM is used for emulation this devices as legacy PS/2)

No, the keyboard and mouse are both connected to PS/2 ports.

> So question is what to try....
>
> Maybe we can disable the GPI7 and see if there are no hangs. If so 
> then we can try to find real reason. If it fails
> we can implement method1.

This sounds like a reasonable approach, how do I write to the PCI 
registers from
user space?

>> Regardless, the register of interrest I think is the one in chapter
>> 10.8.1.5. Now how would I read the value in that register from user
>> space in Linux? It says that the registers that this specific register
>> is part of is distributed within PCI Device 31:Function 0 space as
>> well as a separate I/O range but this still doesn't tell me much on
>> how to read it...
>
>
> PCI space => lspci -x -x -x
> IO space => isadump -f

Here's the dump:

0000:00:1f.0 ISA bridge: Intel Corp.: Unknown device 27b8 (rev 01)
00: 86 80 b8 27 47 01 10 02 01 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 58 14 b0 27
30: 00 00 00 00 e0 00 00 00 00 00 00 00 00 00 00 00
40: 01 10 00 00 80 00 00 00 81 11 00 00 10 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 8a 8a 8a 8a d0 00 00 00 8a 80 80 85 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 10 00 0f 3f 00 00 00 00 00 00 00 00 91 02 04 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 20 06 00 00 08 00 00 00 13 00 00 00 00 03 00 00
b0: 00 00 f0 00 00 00 00 00 00 40 01 18 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 33 22 11 00 67 45 00 00 cf ff 00 00 00 00 00 00
e0: 09 00 0c 10 00 00 20 00 00 00 00 00 00 00 00 00
f0: 01 c0 d1 fe 00 00 00 00 86 0f 01 00 00 00 00 00

So the 32 bit value for register GPIO_ROUT @ offset B8h-BBh should be 
0x18014000
if I understand correctly. That would indicate that GPIO7 is configured for
SMI# which is what Gigabyte claims as well. Not sure I got the bytes swapped
correctly though... Now, how do I write these register?

Thanks!

Daniel Nilsson


----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.


