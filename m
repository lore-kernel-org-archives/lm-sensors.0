From: hfvogt@arcor.de (Hans-Frieder Vogt)
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: [NEW DRIVER] nForce2 SMB support
Message-Id: <20030202142606.256731F53@achilles.nass-vogt.home>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030202142027.5F6331F53@achilles.nass-vogt.home>
In-Reply-To: <20030202142027.5F6331F53@achilles.nass-vogt.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

(resend because of errorneous sender identity in first e-mail)
Hello,

I just wrote a driver for the SMBus (more precise: the SMBuses) in the nVidia
nForce2 southbridge (based on the AMD-8111 driver). It runs both with version
2.6.5 and with CVS. Although it is not very well tested, it runs perfectly on
my computer and I think it might be useful for others as well. Please include
it in lm_sensors.

Cheers,
Hans-Frieder
--
--
Hans-Frieder Vogt                 e-mail: hfvogt@arcor.de
-------------- next part --------------
Kernel driver `i2c-nforce2.o'

Status: Beta, although no problems found during one month usage with hwsensor

Supported adapters:
    * nVidia nForce2 SMBus PCI interface (10de:0064, included in nForce2 MCP)
      Datasheet: not publically available, but seems to be similar to the
                 AMD-8111 SMBus 2.0 adapter.

Author: Hans-Frieder Vogt <hfvogt@arcor.de>


Module Parameters
-----------------

None.


Description
-----------

i2c-nforce2 is a driver for the SMBuses included in the nVidia nForce2 MCP.

If your 'lspci -v' listing shows something like the following,

00:01.1 SMBus: nVidia Corporation: Unknown device 0064 (rev a2)
        Subsystem: Asustek Computer, Inc.: Unknown device 0c11
        Flags: 66Mhz, fast devsel, IRQ 5
        I/O ports at c000 [size2]
        Capabilities: <available only to root>

then this driver should support the SMBuses of your motherboard.


Notes
-----

The SMBus adapter in the nForce2 chipset seems to be very similar to the
SMBus 2.0 adapter in the AMD-8111 southbridge. However, I could only get the
driver to work with direct I/O access, which is different to the EC interface
of the AMD-8111.
Tested on Asus A7N8X. The ACPI DSDT table of the Asus A7N8X lists two SMBuses,
both of which are supported by this driver.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c-nforce2.c
Type: text/x-c
Size: 11637 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030202/151fdc8a/i2c-nforce2.bin
