From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 22 Oct 2005 13:00:33 +0000
Subject: [lm-sensors] ATI SMBus - new information
Message-Id: <435A1BA9.9080009@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all owners of ATI SMBus,

Part of my last night was a chase to ATI SMBUS. Today I'm quite confident it is just
i801 clone. The only thing that is different is the base address.

If you still have such systems, please provide following:

lspci
lspci -x -x -x
cat /proc/acpi/dsdt
(best would be to run IASL to disassembly the DSDT table but I can do it on my own)
cat /proc/ioports

Post it back to the list please.
I dont own such systems myself but I think I can try to develop missing parts to i2c-i801.c
Of course I will need testers. I must warn you that this try might damage your hardware or render it
unusable. I would prefer to test it on desktop PC rather than notebook.

I think I will be able to create patch later today.

The details I know so far:
Base address will be likely 0x1000
The base address register is located in device 0x14, function 0, offset 0x90
Rest of the controller seems to follow the i801 SMBUS cotroller.

Thanks,
Regards
Rudolf
