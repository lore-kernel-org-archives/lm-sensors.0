From: andreas@strodl.org (Andreas Strodl)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: PII4X/Compaq ProLiant ML370 G2 server (fwd)
Message-Id: <20030129082215.GA2286@moon.void.at>
List-Id: <lm-sensors.vger.kernel.org>
References: <200301281638.h0SGcEm25577@morannon.frodo.local>
In-Reply-To: <200301281638.h0SGcEm25577@morannon.frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jan 28, 2003 at 06:45:21PM +0100, Jean Delvare wrote:
> 
> *** PLEASE REPLY TO THE LIST, NOT TO ME ***
> (There are lots of people there, much better qualified than I am to
> solve the problem.)
> 
> 
> > http://secure.netroedge.com/~lm78/supported.html
> > =>
> > ServerWorks 	OSB4,  CSB5 	i2c-piix4 
> 
> OK, so it must be there. Since you have already updated the BIOS, you
> are supposed to force the address. The problems are, that we have to
> find the address, and that the procedure is known to be extremely
> dangerous.
> 
> First thing, could you issue a "lspci" (or "cat /proc/pci") and see if
> you can find an entry for the PIIX4. I got a Compaq desktop system here,
> which says:
> 
> 00:14.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 01)
>         Flags: medium devsel, IRQ 9
> 
> That's what you are looking for. The function must be 3.
I've already read busses/i2c-piix4 and tried force and force_addr...
no success...
> 
> >From our docs (busses/piix4):
> 
> On some computers (most notably, some Dells), the SMBus is disabled by
> default. If you use the insmod parameter 'force=1', the kernel module
>  will try to enable it. THIS IS VERY DANGEROUS! If the BIOS did not
> set up a correct address for this module, you could get in big trouble
> (read: crashes, data corruption, etc.). Try this only as a last resort
> (try BIOS updates first, for example), and backup first! An even more
> dangerous option is 'force_addr=<IOPORT>'. This will not only enable the
> PIIX4 like 'force' foes, but it will also set a new base I/O port
> address.
> The SMBus parts of the PIIX4 needs a range of 8 of these addresses to
> function correctly. If these addresses are already reserved by some
> other
> device, you will get into big trouble! DON'T USE THIS IF YOU ARE NOT
> VERY
> SURE ABOUT WHAT YOU ARE DOING!
> 
> So be very careful. I'd suggest you wait a bit so that Mark gets a
> chance to answer, I think he knows the PIIX4 better than anyone here and
> may have some precious piece of advice for you.
> 
> (From previous mail)
> 
> > sensor-detect also fails...
> 
> How does it fail?
 This program will help you to determine which I2C/SMBus modules you
need to
 load to use lm_sensors most effectively.
 You need to have done a `make install', issued a `depmod -a' and made
sure
 `/etc/conf.modules' (or `/etc/modules.conf') contains the appropriate
 module path before you can use some functions of this utility. Read
 doc/modules for more information.
 Also, you need to be `root', or at least have access to the
/dev/i2c[-/]* files
 for some things. You can use prog/mkdev/mkdev.sh to create these /dev
files
 if you do not have them already.
 If you have patched your kernel and have some drivers built-in you can
 safely answer NO if asked to load some modules. In this case, things
may
 seem a bit confusing, but they will still work.

 BIOS vendor (ACPI): COMPAQ
 System vendor (DMI): Compaq
 BIOS version (DMI): P25
 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-piix4' for device 00:0f.0: ServerWorks OSB4 South Bridge
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Load `i2c-piix4' (say NO if built into your kernel)? (YES/no):
/lib/modules/2.4.20/kernel/drivers/i2c/busses/i2c-piix4.o: init_module:
No such device
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters
/lib/modules/2.4.20/kernel/drivers/i2c/busses/i2c-piix4.o: insmod
/lib/modules/2.4.20/kernel/drivers/i2c/busses/i2c-piix4.o failed
/lib/modules/2.4.20/kernel/drivers/i2c/i2c-piix4.o: init_module: No such
device
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters
/lib/modules/2.4.20/kernel/drivers/i2c/i2c-piix4.o: insmod
/lib/modules/2.4.20/kernel/drivers/i2c/i2c-piix4.o failed
/lib/modules/2.4.20/kernel/drivers/i2c/i2c-piix4.o: insmod i2c-piix4
failed
Loading failed... skipping.
 Do you now want to be prompted for non-detectable adapters? (yes/NO):
NO
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
Segmentation fault

so long,
Andrew
