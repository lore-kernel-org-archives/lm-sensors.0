From: m.pedersen@lancaster.ac.uk (jmp)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: No subject
Message-Id: <1075041483.1154.4.camel@flaptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.33.0111200151170.1364-100000@home.apu.edu>
In-Reply-To: <Pine.LNX.4.33.0111200151170.1364-100000@home.apu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org





-The dmesg or syslog output if applicable:
______________________________________________

i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-dev.o: Registered 'SMBus Via Pro adapter at 0400' as minor 0
i2c-algo-pcf.o: i2c pcf8584 algorithm module
i2c-elektor.o: i2c pcf8584-isa adapter module
i2c-elektor.o: requested I/O region (0x330:2) is in use.
i2c-algo-bit.o: i2c bit algorithm module
i2c-elv.o: i2c ELV parallel port adapter module
i2c-dev.o: Registered 'ELV Parallel port adaptor' as minor 1
i2c-core.o: adapter ELV Parallel port adaptor registered as adapter 1.
i2c-elv.o: found device at 0x378.
i2c-algo-pcf.o: i2c pcf8584 algorithm module
i2c-elektor.o: i2c pcf8584-isa adapter module
i2c-elektor.o: requested I/O region (0x330:2) is in use.
i2c-algo-pcf.o: i2c pcf8584 algorithm module
i2c-elektor.o: i2c pcf8584-isa adapter module
i2c-elektor.o: requested I/O region (0x330:2) is in use.
i2c-philips-par.o: i2c Philips parallel port adapter module
i2c-velleman.o: i2c Velleman K8000 adapter module
i2c-velleman.o: Port 0x378 already in use.
____________________________


  * The output of (as root) prog/detect/sensors-detect
______________________________________

[root@flaptop root]# sensors-detect

This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built-in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.

 BIOS vendor (ACPI): AMI
 System vendor (DMI): FUJITSU SIEMENS
 BIOS version (DMI): 0.28
 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no): y
Probing for PCI bus adapters...
Use driver `i2c-viapro' for device 00:11.0: VIA Technologies
VT8233A/8235 South Bridge
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Module `i2c-viapro' already loaded.
 Do you now want to be prompted for non-detectable adapters? (yes/NO): y
Load `i2c-elektor' (say NO if built into your kernel)? (YES/no): y
/lib/modules/2.4.22-1.2149.nptl/unsupported/drivers/i2c/i2c-elektor.o:
init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg
/lib/modules/2.4.22-1.2149.nptl/unsupported/drivers/i2c/i2c-elektor.o:
insmod
/lib/modules/2.4.22-1.2149.nptl/unsupported/drivers/i2c/i2c-elektor.o
failed
/lib/modules/2.4.22-1.2149.nptl/unsupported/drivers/i2c/i2c-elektor.o:
insmod i2c-elektor failed
Loading failed... skipping.
Load `i2c-elv' (say NO if built into your kernel)? (YES/no): y
Module loaded succesfully.
Load `i2c-philips-par' (say NO if built into your kernel)? (YES/no): y
Module loaded succesfully.
Load `i2c-velleman' (say NO if built into your kernel)? (YES/no): y
/lib/modules/2.4.22-1.2149.nptl/unsupported/drivers/i2c/i2c-velleman.o:
init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg
/lib/modules/2.4.22-1.2149.nptl/unsupported/drivers/i2c/i2c-velleman.o:
insmod
/lib/modules/2.4.22-1.2149.nptl/unsupported/drivers/i2c/i2c-velleman.o
failed
/lib/modules/2.4.22-1.2149.nptl/unsupported/drivers/i2c/i2c-velleman.o:
insmod i2c-velleman failed
Loading failed... skipping.
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
i2c-dev is already loaded.

 We are now going to do the adapter probings. Some adapters may hang
halfway
 through; we can't really help that. Also, some chips will be double
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you
can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus Via Pro adapter at 0400 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively): y
Client at address 0x51 can not be probed - unload all client drivers
first!
Client found at address 0x69

Next adapter: ELV Parallel port adaptor (Bit-shift algorithm)
Do you want to scan it? (YES/no/selectively): y
^X^X^X^X

[root@flaptop root]#

_______________________________

  * The output of lsmodIf a PCI chip problem: 
      * The output of lspci -n
  * If an I2C sensor chip problem: 
      * The output of (as root) prog/detect/i2cdetect X where X = the
        bus number (run i2cdetect with no arguments to list the busses)
        (please send this only if it's not all XX)
      * The output of (as root) prog/dump/i2cdump X 0xXX where XX = the
        address of each chip you see in the output of i2cdetect. (run
        once for each chip) (please send this only if it's not all ff)
  * If an ISA sensor chip problem: 
      * The output of (as root) prog/dump/isadump 0x295 0x296 (only if
        it's not all XX)
  * Part numbers of chips on your motherboard you think are the sensor
    chips (look at your motherboard)
  * Motherboard type
  * Sensors version
  * Kernel version
