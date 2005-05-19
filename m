From: tomek@lodz.tpsa.pl (Tomasz Papszun)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: i2c-piix4.o: SMB base address uninitialized - upgrade BIOS or use force_addr=0xaddr
Message-Id: <20020722194201.A27437@lodz.tpsa.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020704182412.D6544@lodz.tpsa.pl>
In-Reply-To: <20020704182412.D6544@lodz.tpsa.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Phil,
big thanks for your help, but sensors still don't work.
Please, read on - I'm giving details of my trials between fragments of
your letter. Sorry, "sensors people" ;-)  for quoting almost all message
but not all of you remember what I and Phil wrote previously, I think.

On Fri, 05 Jul 2002 at  9:49:46 -0700, phil@netroedge.com wrote:
> 
> Yeah, the problem with the uninitialized base address is that the Bios
> was supposed to configure the chipset on your motherboard to map all
> the base addresses of the different systems to unique and
> non-overlapping addresses.  For some reason, it has left the base
> address of the SMBus system zero/null.  You have a couple choices:
> 
> - figure out if there is a Bios setting (ACPI?) which you need to
> 'enable' to cause the Bios to complete the chipset setup.  Oddly, it
> needed to use the SMBus to sense your memory DIMMs (SPD probing).  Why
> it would purposely uninitialize the SMBus system is not clear to me.

I have checked various BIOS settings once again but haven't found any
relevant one.

> - set the base address yourself.  As you mention, you can do it with
> an insmod/modprobe parameter.  If you are building into the kernel,
> then you'll need to tweak the source code a little to get around this.
> in i2c-piix4.c find this piece of code:
> 
> /* Determine the address of the SMBus areas */
>         if (force_addr) {
>                 piix4_smba = force_addr & 0xfff0;
>                 force = 0;
>         } else {
>                 pci_read_config_word(PIIX4_dev, SMBBA, &piix4_smba);
>                 piix4_smba &= 0xfff0;
>                 if(piix4_smba = 0) {
>                         printk(KERN_ERR "i2c-piix4.o: SMB base address uninitialized - upgrade BIOS or use force_addr=0xaddr\n");
>                         return -ENODEV;
>                 }
>         }
> 
> (line 219)
> 
> Go ahead and add a line just before the comment which looks something
> like this:
> 
> force_addr=0xYOUR_VALUE_HERE;
> 
> I don't know what you should try as an address value.  It must be
> unqiue, yet not overlap with any other memory used by the chipset.

I followed an advice from FAQ: "A high number like 0xf000 is generally
safe". So I used 0xf000 (and 0xe000 but it didn't help either).

> Only the Bios (or the manufacturer) knows what is safe, but you can
> try a value or two and test to make sure everything on your system is
> working.  You can also check /proc/iospace to see what's being used

Most probably, you meant /proc/ioports here. I looked at it.

> that the kernel knows about.
> 
> An idea to find out what a safe value is is to start Windows, run the
> utility to check temps which came with the mobo, and then use loadlin
> or something to get into Linux (don't reboot).  Then insmod
> i2c-piix4.c with a printk() inserted after the pci_read_config_word
> above to print out the current value of piix4_smbus. 

Thanks for this tip but as the server is quite ready (mainly not working
sensors stop it from be used as a production server) I don't want even try
to let Windose play with it.

> Phil

Now I'll describe what I've done.

I removed /usr/src/linux after previous compilations and unpacked clean
sources. Next I followed method nr 1 from INSTALL in i2c-2.6.3 and method
nr 1 from INSTALL in lm_sensors-2.6.3.
So in /usr/src/linux I made 'make menuconfig'. I selected support for
loadable modules and I selected things in "character devices -- I2C
support" _as modules_ <M>. Next: make dep; make bzImage; make modules;
make modules-install (this one maybe wasn't needed because next step
- i2c - added modules into /lib/modules/2.4.18/misc/ so sometime later I
removed the "kernelish" ones).

cd /usr/src/i2c-2.6.3
make all
make install 

In lm_sensors-2.6.3: make all.
Reboot.

modprobe i2c-piix4 force_addr=0xf000
PIIX4 was registered. At last!

sensors-detect probed i2c-piix4 successfully (after I manually modprobed
it, so not a surprise).
But later, things went wrong (as I understand them). From "non-detectable
adapters" it loaded only i2c-philips-par. During "scan the ISA bus" all
"Failed!". At the end, it wrote that I should add to
/etc/modules.conf line "alias char-major-89 i2c-dev" but it has been there
for weeks.
I'm sending full script of sensors-detect as an attachment.
I tried sensors-detect a couple of times, trying various combinations of
"yes" and "no" and "smbus" instead of "ISA". To no avail.

Next I tried 'sensors' but every time the result was "No sensors found!".
I removed modules which was made by kernel compilation so they don't
mess with these built by i2c compilation. Modprobed again. Reboot - just
for sure. Not better - all the time "No sensors found!".
I "rmmod-ed" all modules and modprobed them by hand - still "No sensors".

At this stage I decided to compile a kernel without loadable modules as
it didn't give me "No sensors found!" at least.
This time, the only difference in dmesg is that i2c-piix4.o writes that
SMBus is detected and initialized. But as with previous monolithic
kernels, all results of 'sensors' are 0 or -1.
I'm including excerpts from dmesg here. I can see some unhappy messages
about "Ignoring 'force' parameter for unknown chip" and "enlarge
I2C_DRIVER_MAX. it87.o: Driver registration failed" so I probably selected
too many I2C drivers but I have no idea which ones I should.
There are successful messages before this ugly one (or, at least they
don't shout they are unhappy) so they should work, don't they?
So why are all results empty??
I'm just despaired with it. I don't know what I can do yet.

Linux version 2.4.18 (...) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 SMP Wed Jul 10 20:08:14 CEST 2002
[...]
parport0: PC-style at 0x378 [PCSPP(,...)]
i2c-core.o: i2c core module version 2.6.3 (20020322)
i2c-dev.o: i2c /dev entries driver module version 2.6.3 (20020322)
i2c-algo-bit.o: i2c bit algorithm module version 2.6.3 (20020322)
i2c-philips-par.o: i2c Philips parallel port adapter module version 2.6.3 (20020322)
i2c-philips-par.o: attaching to parport0
i2c-dev.o: Registered 'Philips Parallel port adapter' as minor 0
i2c-proc.o version 2.6.3 (20020322)
i2c-piix4.o version 2.6.3 (20020322)
i2c-piix4.o: Found OSB4 device
i2c-piix4.o: WARNING: SMBus interface set to new address f000!
i2c-dev.o: Registered 'SMBus PIIX4 adapter at f000' as minor 1
i2c-piix4.o: SMBus detected and initialized
i2c-isa.o version 2.6.3 (20020322)
i2c-dev.o: Registered 'ISA main adapter' as minor 2
i2c-isa.o: ISA bus access for i2c modules initialized.
atyfb: using auxiliary register aperture
atyfb: 3D RAGE IIC (PCI) [0x4756 rev 0x7a] 4M SDRAM, 14.31818 MHz XTAL, 230 MHz PLL, 83 Mhz MCLK
Console: switching to colour frame buffer device 80x25
fb0: ATY Mach64 frame buffer device on PCI
pty: 256 Unix98 ptys configured
adm1021.o version 2.6.3 (20020322)
adm1025.o version 2.6.3 (20020322)
adm9240.o version 2.6.3 (20020322)
bt869.o version 2.6.3 (20020322)
bt869.o:  probing address 68 .
bt869.o: address 0x44 testing-->0x0
bt869.o:  probing address 69 .
bt869.o: address 0x45 testing-->0x0
ddcmon.o version 2.6.3 (20020322)
ds1621.o version 2.6.3 (20020322)
gl518sm.o version 2.6.3 (20020322)
gl520sm.o version 2.6.3 (20020322)
gl520sm.o: Ignoring 'force' parameter for unknown chip at adapter 0, address 0x2c
gl520sm.o: Ignoring 'force' parameter for unknown chip at adapter 0, address 0x2d
lm75.o version 2.6.3 (20020322)
lm78.o version 2.6.3 (20020322)
lm80.o version 2.6.3 (20020322)
lm87.o version 2.6.3 (20020322)
mtp008.o version 2.6.3 (20020322)
w83781d.o version 2.6.3 (20020322)
eeprom.o version 2.6.3 (20020322)
it87.o version 2.6.3 (20020322)
 i2c-core.o: register_driver(IT87xx sensor driver) - enlarge I2C_DRIVER_MAX.
it87.o: Driver registration failed, module not inserted.
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
parport0: no more devices allowed
lp: driver loaded but no devices found
Real Time Clock Driver v1.10e
Non-volatile memory driver v1.1
WDT driver for Acquire single board computer initialising.
block: 128 slots per queue, batch2
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ServerWorks OSB4: IDE controller on PCI bus 00 dev 79
ServerWorks OSB4: chipset revision 0
ServerWorks OSB4: not 100% native mode: will probe irqs later



> On Thu, Jul 04, 2002 at 06:24:12PM +0200, Tomasz Papszun wrote:
> > Dear,
> > 
> > I'm trying to use I2C and lm_sensors (2.6.3) on Compaq Proliant ML570
> > (2 Xeons installed). According to dmesg, it has got chipset ServerWorks
> > OSB4.
> > I use monolithic kernels (no dynamically inserted modules), currently
> > 2.4.18.
> > 
> > Just after Debian installation, when the kernel was modular, I used 
> > 'sensors-detect' and got:
> > 
> > "Use driver 'i2c-piix4' for device 00:0f:0: ServerWorks OSB4 South Bridge
> > Probe successfully concluded.
> > We will now try to load each adapter module in turn.
> > Load `i2c-piix4' [YES]
> > modprobe: Can't locate module i2c-piix4"
> > 
> > This version of Debian maybe hasn't got this module but it's not the
> > problem because I just wanted to know which module I needed and I do _not_
> > want to use modular kernels anyway.
> > 
> > First, I built a kernel using Debian packages for i2c-source and
> > lm-sensors-source a few times.
> > 
> > I patched kernel sources following instructions from INSTALL files. I
> > used method number 3 in i2c and method number 2 in lm-sensors. During
> > 'make menuconfig' I chose in section "I2C support":
> > CONFIG_I2C=y
> > CONFIG_I2C_ALGOBIT=y
> > CONFIG_I2C_BITLP=y
> > CONFIG_I2C_MAINBOARD=y
> > CONFIG_I2C_PIIX4=y
> > CONFIG_I2C_ISA=y
> > CONFIG_I2C_CHARDEV=y
> > CONFIG_I2C_PROC=y
> > 
> > Because I don't know which sensors I should choose in section "Hardware
> > sensors support", I was choosing various combinations of them (as David Z.
> > Maze - Debian maintainer - wrote me that too much of them can cause
> > problems with the proper ones). He also advised me to use original
> > tarballs with i2c and lm_sensors so I did that. But that didn't help
> > either.
> > 
> > Using 'sensors' I got all values equal zero (for temperatures and
> > voltages) or -1 (for fans).
> > 
> > Because dmesg says:
> > i2c-piix4.o: SMB base address uninitialized - upgrade BIOS or use
> >              force_addr=0xaddr
> > 
> > I upgraded BIOS to the newest available version (dated 5 April 2002),
> > which is even newer than i2c and lm_sensors tarballs :-)  but the error
> > message is the same.
> > I can't use "force_addr=..." for modprobe because I don't use loadable
> > modules at all.
> > 
> > What can I do?
> > 
> > Below I'm including excerpts from the latest dmesg (I'm not sending full
> > one as I don't want to add too much "noise" but if you need it, just tell
> > me). 
> > I'm quite confused and down after many days of trials with it so I may be 
> > omitting some info you need. If so, don't hesitate to ask me.
> > 
> > Thank you in advance.
> > 
> > [...]

--
 Tomasz Papszun   SysAdm @ TP S.A. Lodz, Poland  | And it's only
 tomek@lodz.tpsa.pl   http://www.lodz.tpsa.pl/   | ones and zeros.


# /usr/src/lm_sensors-2.6.3/prog/detect/sensors-detect
 This program will help you to determine which I2C/SMBus modules you need to
 load to use lm_sensors most effectively.
 You need to have done a `make install', issued a `depmod -a' and made sure
 `/etc/conf.modules' (or `/etc/modules.conf') contains the appropriate
 module path before you can use some functions of this utility. Read
 doc/modules for more information.
 Also, you need to be `root', or at least have access to the /dev/i2c[-/]* files for some things. You can use prog/mkdev/mkdev.sh to create these /dev files
 if you do not have them already.
 If you have patched your kernel and have some drivers built-in you can
 safely answer NO if asked to load some modules. In this case, things may
 seem a bit confusing, but they will still work.

 IF THIS IS AN IBM THINKPAD, PRESS CTRL-C NOW!
 IBM Thinkpads have a severely broken i2c/SMBus implementation,  just scanning
 the bus will break your thinkpad forever!

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-piix4' for device 00:0f.0: ServerWorks OSB4 South Bridge
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Module `i2c-piix4' already loaded.
 Do you now want to be prompted for non-detectable adapters? (yes/NO): yes
Load `i2c-elektor' (say NO if built into your kernel)? (YES/no):
i2c-elektor.o: i2c pcf8584-isa adapter module
i2c-elektor.o: requested I/O region (0x330:2) is in use.
/lib/modules/2.4.18/kernel/drivers/i2c-z-kernela/i2c-elektor.o: init_module: No
such device
Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters
/lib/modules/2.4.18/kernel/drivers/i2c-z-kernela/i2c-elektor.o: insmod /lib/modules/2.4.18/kernel/drivers/i2c-z-kernela/i2c-elektor.o failed
i2c-elektor.o: i2c pcf8584-isa adapter module version 2.6.3 (20020322)
i2c-elektor.o: requested I/O region (0x330:2) is in use.
/lib/modules/2.4.18/misc/i2c-elektor.o: init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters
/lib/modules/2.4.18/misc/i2c-elektor.o: insmod /lib/modules/2.4.18/misc/i2c-elektor.o failed
/lib/modules/2.4.18/misc/i2c-elektor.o: insmod i2c-elektor failed
Loading failed ()... skipping.
Load `i2c-elv' (say NO if built into your kernel)? (YES/no): yes
i2c-elv.o: i2c ELV parallel port adapter module
/lib/modules/2.4.18/kernel/drivers/i2c-z-kernela/i2c-elv.o: init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters
/lib/modules/2.4.18/kernel/drivers/i2c-z-kernela/i2c-elv.o: insmod /lib/modules/2.4.18/kernel/drivers/i2c-z-kernela/i2c-elv.o failed
i2c-elv.o: i2c ELV parallel port adapter module version 2.6.3 (20020322)
/lib/modules/2.4.18/misc/i2c-elv.o: init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters
/lib/modules/2.4.18/misc/i2c-elv.o: insmod /lib/modules/2.4.18/misc/i2c-elv.o failed
/lib/modules/2.4.18/misc/i2c-elv.o: insmod i2c-elv failed
Loading failed ()... skipping.
Load `i2c-philips-par' (say NO if built into your kernel)? (YES/no): yes
Module loaded succesfully.
Load `i2c-velleman' (say NO if built into your kernel)? (YES/no): yes
i2c-velleman.o: i2c Velleman K8000 adapter module
i2c-velleman.o: Port 0x378 already in use.
/lib/modules/2.4.18/kernel/drivers/i2c-z-kernela/i2c-velleman.o: init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters
/lib/modules/2.4.18/kernel/drivers/i2c-z-kernela/i2c-velleman.o: insmod /lib/modules/2.4.18/kernel/drivers/i2c-z-kernela/i2c-velleman.o failed
i2c-velleman.o: i2c Velleman K8000 adapter module version 2.6.3 (20020322)
/lib/modules/2.4.18/misc/i2c-velleman.o: init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters
/lib/modules/2.4.18/misc/i2c-velleman.o: insmod /lib/modules/2.4.18/misc/i2c-velleman.o failed
/lib/modules/2.4.18/misc/i2c-velleman.o: insmod i2c-velleman failed
Loading failed ()... skipping.
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
i2c-dev is already loaded.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus PIIX4 adapter at f000 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively): yes

 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no): yes
Probing for `National Semiconductor LM78'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM78-J'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM79'
  Trying address 0x0290... Failed!
Probing for `Winbond W83781D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83782D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83627HF'
  Trying address 0x0290... Failed!
Probing for `Winbond W83697HF'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'
  Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)?

WARNING! If you have some things built into your kernel, the
below list will contain too many modules. Skip the appropriate ones!
To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
# I2C chip drivers
#----cut here----

To make the sensors modules behave correctly, add these lines to either
/etc/modules.conf or /etc/conf.modules:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----
