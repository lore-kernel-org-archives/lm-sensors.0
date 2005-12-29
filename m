From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 29 Dec 2005 17:49:45 +0000
Subject: [lm-sensors] Kernel hangs with i2c-i801 driver?
Message-Id: <43B421B9.4030207@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051123100021.GA29473@oden.homeip.net>
In-Reply-To: <20051123100021.GA29473@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Daniel Nilsson wrote:
> Hi All,
> 
> Sorry for the delay, I'm on vacation and I only have remote access to the
> machine right now so I'm cautious what I experiement with since I can't
> press
> the reset button:-)

Never mind.
> This is probably fine for me, though it feels like putting a patch on the
> sympton instead of the cause. But I realize fixing the cause might be
> impossible without access to the BIOS source code and a hardware debugger.

Yep.

> I suppose we could ask this but maybe I should just ask them to
> reproduce the
> problem on Linux themselves and tell me why it fails? In order to do so
> though
> I feel like we need to be pretty sure that the bug is not in Linux code
> but in
> code installed by their BIOS. Is there a way to prove that?

SMI is completly transparent to OS. In fact you as OS dont notice, you cant catch it. It is simply out of OS control.

>> Maybe we can disable the GPI7 and see if there are no hangs. If so
>> then we can try to find real reason. If it fails
>> we can implement method1.
> 
> 
> This sounds like a reasonable approach, how do I write to the PCI
> registers from
> user space?

There is setpci command.

> Here's the dump:
> 
> 0000:00:1f.0 ISA bridge: Intel Corp.: Unknown device 27b8 (rev 01)
> 00: 86 80 b8 27 47 01 10 02 01 00 01 06 00 00 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 58 14 b0 27
> 30: 00 00 00 00 e0 00 00 00 00 00 00 00 00 00 00 00
> 40: 01 10 00 00 80 00 00 00 81 11 00 00 10 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 8a 8a 8a 8a d0 00 00 00 8a 80 80 85 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 10 00 0f 3f 00 00 00 00 00 00 00 00 91 02 04 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 20 06 00 00 08 00 00 00 13 00 00 00 00 03 00 00
> b0: 00 00 f0 00 00 00 00 00 00 40 01 18 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 33 22 11 00 67 45 00 00 cf ff 00 00 00 00 00 00
> e0: 09 00 0c 10 00 00 20 00 00 00 00 00 00 00 00 00
> f0: 01 c0 d1 fe 00 00 00 00 86 0f 01 00 00 00 00 00
> 
> So the 32 bit value for register GPIO_ROUT @ offset B8h-BBh should be
> 0x18014000

00 40 01 18 =>  18014000 GP7 is bit 15:14 -> 0100 0000 0000 0000 -> 01 -> SMI# ;)

> if I understand correctly. That would indicate that GPIO7 is configured for
> SMI# which is what Gigabyte claims as well. Not sure I got the bytes
> swapped
> correctly though... 

Yes you did.

Now, how do I write these register?

setpci -s 00:1f.0 b8.l010000

You can check it via lspci if it has been changed.

When done, please test the stuff once again. If it is OK then please provide:
lspci -v -v -v (of all devices) and also output of dmidecode utility.
We will need this for the fix the symptom.

Best would be if Gigabyte can bit investigate what went really wrong...

Regards
Rudolf

