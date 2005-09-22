From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 22 Sep 2005 08:12:23 +0000
Subject: [lm-sensors] Asus Z80V/M6V i2c support
Message-Id: <43324B30.80607@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <318b1df00509211647a24cdec@mail.gmail.com>
In-Reply-To: <318b1df00509211647a24cdec@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

> I have a few problems reading sensor data on an ASUS M6V notebook. The
> notebook has an Intel 915PM chipset which should be supported by the
> i2c-i801 driver. The problem is that the SMBus device is hidden by the
> bios at startup similar to other boards (as I have already seen in
> drivers/pci/quirks.c of the kernel source). The problem is that with the
> ICH6 the SMBus device cannot be enabled anymore as with ICH[2-5] chipsets.
> The data sheet indicates that the SMBus device can be enabled by setting
> the Function Disable register which is listed in the chipset
> configuration register memory map (p. 248 of the data sheet).
> Unfortunately I do not have a clue as how to get access to these registers.
> It would be really great if somebody could give me some pointers as how
> I could interface these registers or at least some links with further
> information as I am new to kernel programming.
> Thanks a lot in advance for any suggestions.

Please provide output of following commands:

lspci -n
lspci -v
lspci -v -v -v
cat /proc/ioports
cat /proc/iomem

What kernel are you using?

I will try to write a patch for you.

Regards
Rudolf
