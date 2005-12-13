From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 13 Dec 2005 20:16:30 +0000
Subject: [lm-sensors] lm_sensors and nvidia graphic card temperature
Message-Id: <20051213211630.13006ce2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4399BE92.9020705@mathematica.scientia.net>
In-Reply-To: <4399BE92.9020705@mathematica.scientia.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Volker,

> > Alternatively, you should be able to gain control of the nVidia I2C
> > busses using the in-kernel-tree rivafb or nvidiafb framebuffer drivers.
> 
> I have a rivafb module, which loads fine and produces no output on
> stderr or syslog. What does "gain control of the nvidia i2c busses"
> mean? That sensors-detect should find them? It doesn't for me:

"Gain control" means that i2c/smbus chip drivers can "see" the bus and
try attaching to devices thereon. You can use i2cdetect to list and
probe these busses.

> modprobe -v rivafb
> sensors-detect
> ...
> Driver `eeprom' (should be inserted):
>   Detects correctly:
>   * Bus `SMBus nForce2 adapter at 1c00'
>     Busdriver `i2c-nforce2', I2C address 0x50
>     Chip `SPD EEPROM' (confidence: 8)
>   * Bus `SMBus nForce2 adapter at 1c00'
>     Busdriver `i2c-nforce2', I2C address 0x51
>     Chip `SPD EEPROM' (confidence: 8)
> Driver `it87' (should be inserted):
>   Detects correctly:
>   * ISA bus address 0x0290 (Busdriver `i2c-isa')
>     Chip `ITE 8712F Super IO Sensors' (confidence: 9)
> ...
> 
> Same output as always.
> 
> Are we talking about the same thing?

If you have a recent graphics adapter, you most likely need the
nvidiafb driver. Just because rivafb loads silently doesn't mean it did
anything useful. Actually, the fact that it was silent suggests very
strongly that it does NOT support your graphics adapter.

> Linux .. 2.6.13-15.7-default #1 Tue Nov 29 14:32:29 UTC 2005 x86_64
> sensors-2.9.1-4
> Gigabyte PCI-express graphics card with nvidia geforce 6600 chip
> 
> > Make sure to enable "DDC support" in either case.
> 
> Where? The kernel config doesn't seem to know about it:
> zgrep -i ddc /proc/config.gz
> gives no output. Grepping through the kernel source doesn't tell me
> anything more, and none of the 5 rivafb module paramters have to do with
> DDC.

For some reason the symbols have "I2C" rather than "DDC" in their names:

CONFIG_FB_RIVA_I2C:
CONFIG_FB_NVIDIA_I2C

-- 
Jean Delvare

