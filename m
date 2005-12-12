From: hidden@paradise.net.nz (Volker Kuhlmann)
Date: Mon, 12 Dec 2005 22:11:44 +0000
Subject: [lm-sensors] lm_sensors and nvidia graphic card temperature
Message-Id: <20051212221144.GC6589@paradise.net.nz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4399BE92.9020705@mathematica.scientia.net>
In-Reply-To: <4399BE92.9020705@mathematica.scientia.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Alternatively, you should be able to gain control of the nVidia I2C
> busses using the in-kernel-tree rivafb or nvidiafb framebuffer drivers.

I have a rivafb module, which loads fine and produces no output on
stderr or syslog. What does "gain control of the nvidia i2c busses"
mean? That sensors-detect should find them? It doesn't for me:

modprobe -v rivafb
sensors-detect
...
Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus nForce2 adapter at 1c00'
    Busdriver `i2c-nforce2', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus nForce2 adapter at 1c00'
    Busdriver `i2c-nforce2', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 8)
Driver `it87' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `ITE 8712F Super IO Sensors' (confidence: 9)
...

Same output as always.

Are we talking about the same thing?

Linux .. 2.6.13-15.7-default #1 Tue Nov 29 14:32:29 UTC 2005 x86_64
sensors-2.9.1-4
Gigabyte PCI-express graphics card with nvidia geforce 6600 chip

> Make sure to enable "DDC support" in either case.

Where? The kernel config doesn't seem to know about it:
zgrep -i ddc /proc/config.gz
gives no output. Grepping through the kernel source doesn't tell me
anything more, and none of the 5 rivafb module paramters have to do with
DDC.

Thanks,

Volker

-- 
Volker Kuhlmann			is possibly list0570 with the domain in header
http://volker.dnsalias.net/		Please do not CC list postings to me.

