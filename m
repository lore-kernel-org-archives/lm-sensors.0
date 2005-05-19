From: andreas@strodl.org (Andreas Strodl)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: PII4X/Compaq ProLiant ML370 G2 server (fwd)
Message-Id: <20030129090503.GA6557@moon.void.at>
List-Id: <lm-sensors.vger.kernel.org>
References: <200301281638.h0SGcEm25577@morannon.frodo.local>
In-Reply-To: <200301281638.h0SGcEm25577@morannon.frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jan 29, 2003 at 09:56:20AM +0100, Jean Delvare wrote:
> >  If you found that the adapter hung after probing a certain address,
> >  you can
> >  specify that address to remain unprobed. That often
> >  includes address 0x69 (clock chip).
> > Segmentation fault
> 
> Strange. Never seen that before. Perl itself would be segfaulting. Could
> you please tell me which distribution you are running,  and which
> version of Perl is used?
> 
> Do you have any way to get a core dumped (ulimit -c unlimited could
> help)?
> 
> May I send you a modified version of the script with some extra prints
> to try and locate the problem?
> 
> Thanks.
> 
> -- 
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/

Hi,

the segfault was because of cat'ing /proc/bus/i2c-0...
even a rmmod and insmod again hadnt worked so I rebooted
the machine and ran the detect tool again:

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
 Do you want to probe now? (YES/no): YES
Probing for PCI bus adapters...
Use driver `i2c-piix4' for device 00:0f.0: ServerWorks OSB4 South Bridge
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Load `i2c-piix4' (say NO if built into your kernel)? (YES/no): YES
/lib/modules/2.4.20/kernel/drivers/i2c/busses/i2c-piix4.o: init_module:
No such
device
Hint: insmod errors can be caused by incorrect module parameters,
including inva
lid IO or IRQ parameters
/lib/modules/2.4.20/kernel/drivers/i2c/busses/i2c-piix4.o: insmod
/lib/modules/2
.4.20/kernel/drivers/i2c/busses/i2c-piix4.o failed
/lib/modules/2.4.20/kernel/drivers/i2c/i2c-piix4.o: init_module: No such
device
Hint: insmod errors can be caused by incorrect module parameters,
including inva
lid IO or IRQ parameters
/lib/modules/2.4.20/kernel/drivers/i2c/i2c-piix4.o: insmod
/lib/modules/2.4.20/k
ernel/drivers/i2c/i2c-piix4.o failed
/lib/modules/2.4.20/kernel/drivers/i2c/i2c-piix4.o: insmod i2c-piix4
failed
Loading failed... skipping.
 Do you now want to be prompted for non-detectable adapters? (yes/NO):
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no):
 Module loaded succesfully.

 We are now going to do the adapter probings. Some adapters may hang
halfway
 through; we can't really help that. Also, some chips will be double
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you
can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no):
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
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'
  Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

 Sorry, no chips were detected.
 Either your sensors are not supported, or they are
 connected to an I2C bus adapter that we do not support.
 See doc/FAQ, doc/lm_sensors-FAQ.html, or
 http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html
 (FAQ #4.24.3) for further information.
 If you find out what chips are on your board, see
 http://secure.netroedge.com/~lm78/newdrivers.html for driver status.

lspci output:
00:00.0 Host bridge: ServerWorks CNB20HE Host Bridge (rev 23)
00:00.1 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)
00:00.2 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
00:00.3 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
00:01.0 RAID bus controller: Compaq Computer Corporation Smart Array
5i/532 (rev 01)
00:02.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev
08)
00:05.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
00:06.0 System peripheral: Compaq Computer Corporation Advanced System
Management Controller
00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 51)
00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
01:02.0 SCSI storage controller: Adaptec 7899A (rev 01)
01:02.1 SCSI storage controller: Adaptec 7899A (rev 01)
07:07.0 PCI Hot-plug controller: Compaq Computer Corporation PCI Hotplug
Controller (rev 12)

so long,
Andrew
