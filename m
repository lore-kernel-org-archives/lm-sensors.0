From: lists@localguru.de (Marcus Schopen)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: i2c-piix4 problem
Message-Id: <200408041637.21472.lists@localguru.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I've problem to get values for my "82371AB PIIX4 ACPI (rev 01)". Could anyone 
send me a working sensors.conf? I get just parse errors or "No sensors 
found!".

The following kernel modules are loaded:

# lsmod:
Module                  Size  Used by    Tainted: P
i2c-proc                6272   0
i2c-dev                 3680   0
i2c-piix4               3908   0
i2c-core               12160   0  [i2c-proc i2c-dev i2c-piix4]

I read the documentation on 
 
  http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/busses/i2c-piix4

and it seems, that I have a a PIIX4 SMBus controller, whereas 
"cat /proc/bus/i2c" shows this:

i2c-0   smbus           SMBus PIIX4 adapter at 5f00             Non-I2C SMBus 
ad

# cat /proc/bus/i2c-0
cat: /proc/bus/i2c-0: Invalid argument

# cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corp. 430TX - 82439TX MTXC (rev 1).
      Master Capable.  Latency2.
  Bus  0, device   7, function  0:
    ISA bridge: Intel Corp. 82371AB PIIX4 ISA (rev 1).
  Bus  0, device   7, function  1:
    IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 1).
      Master Capable.  Latency2.
      I/O at 0xf000 [0xf00f].
  Bus  0, device   7, function  2:
    USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 1).
      IRQ 11.
      Master Capable.  Latency2.
      I/O at 0x6400 [0x641f].
  Bus  0, device   7, function  3:
    Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 1).
      IRQ 9.

Any ideas? 

Thanks,
Marcus
