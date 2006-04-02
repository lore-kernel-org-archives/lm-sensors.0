From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 02 Apr 2006 09:58:20 +0000
Subject: [lm-sensors] nForce 410
Message-Id: <442FA03C.6060602@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060401215808.67999.qmail@web37401.mail.mud.yahoo.com>
In-Reply-To: <20060401215808.67999.qmail@web37401.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

>     >echo "10de 0264" > /sys/bus/pci/drivers/nForce2_smbus/new_id

You may also try to change it in your kernel if you are able to
recompile it on your own.

Just go to the linux/drivers/i2c/busses/i2c-nforce2.c

Find this line:
    { PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_MCP04_SMBUS) },

And change it:
    { PCI_DEVICE(PCI_VENDOR_ID_NVIDIA, 0x264) },
Delete the .o and .ko files and recompile whole kernel.

See if it helps.

Also watch the kernel log if there is new message.

We can have more clue from the DSDT acpi table because it seems you
have the special asus ATK0110 virtual device that might handle the bus
and sensors.

Please provide the output of cat /proc/acpi/dsdt > dsdt.bin
and send it to me in private (because mailing list do not like
binary attach or put it online somewhere)

Thanks,

Regards
Rudolf

