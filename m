From: trini@kernel.crashing.org (Tom Rini)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: [PATCH] Fix for i2c-piix4 with on some boards
Message-Id: <20030811232816.GI807@ip68-0-152-218.tc.ph.cox.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030811181001.GE807@ip68-0-152-218.tc.ph.cox.net>
In-Reply-To: <20030811181001.GE807@ip68-0-152-218.tc.ph.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Aug 11, 2003 at 08:28:49PM +0200, Jean Delvare wrote:

> 
> Hi Tom,
> 
> We would need a bit more details about your patch before we can apply
> it.
> 
> 1* What is the register that cause the problems? How did you come to it,
> starting from the problem you encountered on that motherboard?

I must admit I'm working as a bit of a middle man here, but:
This is the SMBus Host Configuration Register (PCI space, function 0,
offset 0xd2).  I was trying to get I2C working, and it was just doing
bizarre things.  I finally looked at every register that had anything to
do with I2C.  This was the only thing I had to change to make it work.

> 2* What are these values 0x02 and 0xFD you are using? Why do you say
> that having 0x02 in that register is an "unknown" state?

In this register, bit 0 is an enable, bits 1-3 assign the interrupt, and
bits 4-7 are reserved.  The only valid values for the interrupt are 000b
(SMI#) and 100b (IRQ9).  All other values are reserved.  Thus bit 1
should never be set in the register.

> 3* How well-tested is your patch? Did you test it on a "standard" piix4
> chipset?

Yes, this has been tested on a "standard" piix4 chipsets.
<hat type="montavista employee">
This was also shipped in MVL 2.1 (just the CPCI-735 used the i2c-piix.c
code) and MVL 3.0 (as well as MVL CGE 3.0, and the CPCI-735 as well as a
Motorola board that did not need the workaround).
Sadly the fix fell through the cracks until now.
</hat>

-- 
Tom Rini
http://gate.crashing.org/~trini/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030811/de4f2cd3/attachment.bin
