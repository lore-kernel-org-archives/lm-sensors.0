From: arvidjaar@mail.ru (Andrey Borzenkov)
Date: Tue, 03 Jan 2006 13:41:45 +0000
Subject: [lm-sensors] lm90: i2c_adapter i2c-0: Error: command never completed
Message-Id: <200601031641.46499.arvidjaar@mail.ru>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Using 2.6.14.5 and 2.6.15 I get in dmesg:

i2c_adapter i2c-0: Error: command never completed
i2c_adapter i2c-0: Error: command never completed
i2c_adapter i2c-0: Error: command never completed
i2c_adapter i2c-0: Error: command never completed
i2c_adapter i2c-0: Error: command never completed
i2c_adapter i2c-0: Error: command never completed
i2c_adapter i2c-0: Error: command never completed
i2c_adapter i2c-0: Error: command never completed
...
i2c_adapter i2c-0: Error: command never completed
lm90 0-004c: Register 0x14 read failed (-1)
i2c_adapter i2c-0: Error: command never completed
lm90 0-004c: Register 0x14 read failed (-1)

I did not remember having something like it before, running Mandriva kernels 
(up to 2.6.12-12mdk).

{pts/1}% sensors
eeprom-i2c-0-50
Adapter: SMBus ALI1535 adapter at ef00
Memory type:            SDR SDRAM DIMM
Memory size (MB):       256

adm1032-i2c-0-4c
Adapter: SMBus ALI1535 adapter at ef00
M/B Temp:    +41?C  (low  =   -65?C, high =  +127?C)
CPU Temp:  +49.4?C  (low  = +45.0?C, high = +53.0?C)
M/B Crit:   +127?C  (hyst =  +122?C)
CPU Crit:   +100?C  (hyst =   +95?C)
{pts/1}% lspci
00:00.0 Host bridge: ALi Corporation M1644/M1644T Northbridge+Trident (rev 01)
00:01.0 PCI bridge: ALi Corporation PCI to AGP Controller
00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00:04.0 IDE interface: ALi Corporation M5229 IDE (rev c3)
00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link 
Controller Audio Device (rev 01)
00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
00:08.0 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
00:0a.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] 
(rev 08)
00:10.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller 
(rev 01)
00:11.0 CardBus bridge: Toshiba America Info Systems ToPIC100 PCI to Cardbus 
Bridge with ZV Support (rev 32)
00:11.1 CardBus bridge: Toshiba America Info Systems ToPIC100 PCI to Cardbus 
Bridge with ZV Support (rev 32)
00:12.0 System peripheral: Toshiba America Info Systems SD TypA Controller 
(rev 03)
01:00.0 VGA compatible controller: Trident Microsystems CyberBlade XPAi1 (rev 
82)

I am ready to provide any additional information on request.

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDun8aR6LMutpd94wRArwMAKCwcleffkIWuhjcp7xD062eCZc9QQCfcRvm
312hhzT2yKx4cqcbYCjnSiY=L/KJ
-----END PGP SIGNATURE-----

