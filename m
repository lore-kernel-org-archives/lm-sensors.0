From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: i2c-piix4.o: SMB base address uninitialized - upgrade BIOS or use
Message-Id: <3D248BEF.344102D6@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020704182412.D6544@lodz.tpsa.pl>
In-Reply-To: <20020704182412.D6544@lodz.tpsa.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I don't know any way to pass the address to the driver without modules.
You'll have to modify the source to put "force_addr=0x1234" somewhere.

You should also use sensors-detect from the lm_sensors package to
do your detection rather than just loading all the chip drivers.
Note that you hit the limit on number of loaded drivers.

mds


Tomasz Papszun wrote:
> 
> Dear,
> 
> I'm trying to use I2C and lm_sensors (2.6.3) on Compaq Proliant ML570
> (2 Xeons installed). According to dmesg, it has got chipset ServerWorks
> OSB4.
> I use monolithic kernels (no dynamically inserted modules), currently
> 2.4.18.
> 
> Just after Debian installation, when the kernel was modular, I used
> 'sensors-detect' and got:
> 
> "Use driver 'i2c-piix4' for device 00:0f:0: ServerWorks OSB4 South Bridge
> Probe successfully concluded.
> We will now try to load each adapter module in turn.
> Load `i2c-piix4' [YES]
> modprobe: Can't locate module i2c-piix4"
> 
> This version of Debian maybe hasn't got this module but it's not the
> problem because I just wanted to know which module I needed and I do _not_
> want to use modular kernels anyway.
> 
> First, I built a kernel using Debian packages for i2c-source and
> lm-sensors-source a few times.
> 
> I patched kernel sources following instructions from INSTALL files. I
> used method number 3 in i2c and method number 2 in lm-sensors. During
> 'make menuconfig' I chose in section "I2C support":
> CONFIG_I2C=y
> CONFIG_I2C_ALGOBIT=y
> CONFIG_I2C_BITLP=y
> CONFIG_I2C_MAINBOARD=y
> CONFIG_I2C_PIIX4=y
> CONFIG_I2C_ISA=y
> CONFIG_I2C_CHARDEV=y
> CONFIG_I2C_PROC=y
> 
> Because I don't know which sensors I should choose in section "Hardware
> sensors support", I was choosing various combinations of them (as David Z.
> Maze - Debian maintainer - wrote me that too much of them can cause
> problems with the proper ones). He also advised me to use original
> tarballs with i2c and lm_sensors so I did that. But that didn't help
> either.
> 
> Using 'sensors' I got all values equal zero (for temperatures and
> voltages) or -1 (for fans).
> 
> Because dmesg says:
> i2c-piix4.o: SMB base address uninitialized - upgrade BIOS or use
>              force_addr=0xaddr
> 
> I upgraded BIOS to the newest available version (dated 5 April 2002),
> which is even newer than i2c and lm_sensors tarballs :-)  but the error
> message is the same.
> I can't use "force_addr=..." for modprobe because I don't use loadable
> modules at all.
> 
> What can I do?
> 
> Below I'm including excerpts from the latest dmesg (I'm not sending full
> one as I don't want to add too much "noise" but if you need it, just tell
> me).
> I'm quite confused and down after many days of trials with it so I may be
> omitting some info you need. If so, don't hesitate to ask me.
> 
> Thank you in advance.
> 
> Linux version 2.4.18 (tomek@kiezmar) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 SMP Wed Jul 3 22:39:06 CEST 2002
> [...]
> i2c-core.o: i2c core module version 2.6.3 (20020322)
> i2c-dev.o: i2c /dev entries driver module version 2.6.3 (20020322)
> i2c-algo-bit.o: i2c bit algorithm module version 2.6.3 (20020322)
> i2c-philips-par.o: i2c Philips parallel port adapter module version 2.6.3 (20020322)
> i2c-philips-par.o: attaching to parport0
> i2c-dev.o: Registered 'Philips Parallel port adapter' as minor 0
> i2c-proc.o version 2.6.3 (20020322)
> i2c-piix4.o version 2.6.3 (20020322)
> i2c-piix4.o: Found OSB4 device
> i2c-piix4.o: SMB base address uninitialized - upgrade BIOS or use force_addr=0xaddr
> i2c-piix4.o: Device not detected, module not inserted.
> i2c-isa.o version 2.6.3 (20020322)
> i2c-dev.o: Registered 'ISA main adapter' as minor 1
> i2c-isa.o: ISA bus access for i2c modules initialized.
> atyfb: using auxiliary register aperture
> atyfb: 3D RAGE IIC (PCI) [0x4756 rev 0x7a] 4M SDRAM, 14.31818 MHz XTAL, 230 MHz PLL, 83 Mhz MCLK
> Console: switching to colour frame buffer device 80x25
> fb0: ATY Mach64 frame buffer device on PCI
> pty: 256 Unix98 ptys configured
> adm1021.o version 2.6.3 (20020322)
> adm1025.o version 2.6.3 (20020322)
> adm9240.o version 2.6.3 (20020322)
> bt869.o version 2.6.3 (20020322)
> bt869.o:  probing address 68 .
> bt869.o: address 0x44 testing-->0x0
> bt869.o:  probing address 69 .
> bt869.o: address 0x45 testing-->0x0
> ddcmon.o version 2.6.3 (20020322)
> ds1621.o version 2.6.3 (20020322)
> gl518sm.o version 2.6.3 (20020322)
> gl520sm.o version 2.6.3 (20020322)
> gl520sm.o: Ignoring 'force' parameter for unknown chip at adapter 0, address 0x2c
> gl520sm.o: Ignoring 'force' parameter for unknown chip at adapter 0, address 0x2d
> lm75.o version 2.6.3 (20020322)
> lm78.o version 2.6.3 (20020322)
> lm80.o version 2.6.3 (20020322)
> lm87.o version 2.6.3 (20020322)
> mtp008.o version 2.6.3 (20020322)
> w83781d.o version 2.6.3 (20020322)
> eeprom.o version 2.6.3 (20020322)
> it87.o version 2.6.3 (20020322)
>  i2c-core.o: register_driver(IT87xx sensor driver) - enlarge I2C_DRIVER_MAX.
> it87.o: Driver registration failed, module not inserted.
> [...]
> ServerWorks OSB4: IDE controller on PCI bus 00 dev 79
> ServerWorks OSB4: chipset revision 0
> ServerWorks OSB4: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0x2c00-0x2c07, BIOS settings: hda:pio, hdb:pio
>     ide1: BM-DMA at 0x2c08-0x2c0f, BIOS settings: hdc:pio, hdd:pio
> 
> Regards
> --
>  Tomasz Papszun   SysAdm @ TP S.A. Lodz, Poland  | And it's only
>  tomek@lodz.tpsa.pl   http://www.lodz.tpsa.pl/   | ones and zeros.
