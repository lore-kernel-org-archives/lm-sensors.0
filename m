From: markrages@gmail.com (Mark Rages)
Date: Fri, 07 Apr 2006 23:07:27 +0000
Subject: [lm-sensors] nForce 430 SMBus
Message-Id: <74ee72ca0604071607l1c1063b2iad93659df1bfe3fa@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I've got an "Asus A8N-VM CSM nForce 430/GeForce 6150" motherboard.

I want to access the SMBus for hardware hacking purposes.

I can read the sensors through the w83627ehf SuperIO, through the
i2c-isa interface.

But I get nothing from eeprom/decode-dimms.pl ("Number of SDRAM DIMMs
detected and decoded: 0").

I'm guessing I need to get this interface working:

00:0a.1 SMBus: nVidia Corporation MCP51 SMBus (rev a2)
        Subsystem: nVidia Corporation: Unknown device cb84

This has PCI ID 10de:0264.

I tried hacking adding this ID to the nforce2 driver, but I still
can't get anything from decode-dimms.pl.

What do I need to do?

Regards,
Mark
markrages at gmail
--
You think that it is a secret, but it never has been one.
  - fortune cookie

