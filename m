From: michal.mleczko@gmail.com (=?ISO-8859-2?Q?Micha=B3_Mleczko?=)
Date: Sat, 24 Sep 2005 01:48:06 +0000
Subject: [lm-sensors] Asus Z80V/M6V i2c support
Message-Id: <318b1df0050923164636fe9055@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <318b1df00509211647a24cdec@mail.gmail.com>
In-Reply-To: <318b1df00509211647a24cdec@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!

As you pointed out you need to get to that enable register. This register is
> provided in PCI address space.
> To access it you need to its base address. RCBA--Root Complex Base Address
> Register (page 361) Value in register
> is 16KB aligned so it size is also 16KB. Then you just need to map it to
> address space of procesor. This
> can be done via ioremap_nocache. Once mapped you just need to change right
> bit in right place.
> Note that you can access to this register only in 32bit chunks.(so
> readl/writel should help).

First of all thank you very much for the very quick response! Unfortunately
the patch does not work. I have read the value in the register even before
we write anything to it and the value stored is 0x1000f00 which means that
bit 3 is 0 and therefore the SMBus controller should be enabled. So there
must be some other means of enabling it. Under windows I have seen that the
software Everest Home enables the controller and it works so there *is* a
way of enabling it...

Regards,
Michal
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050924/3a81c4a5/attachment.html
